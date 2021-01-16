#!/usr/bin/python3.7
from math import sqrt, floor, log10, pi
import skrf as rf
import sys


pF = 1000000000000
nH = 1000000000


class Impedance(complex):

    def __init__(self, r, x = None):
        super().__init__()

        self.abs_z = sqrt(self.real*self.real + self.imag*self.imag)
        swr = self.abs_z/50.0
        # How does SWR ever get to 0.0? I get an error here in my testing, but never see a 0 in my results. :-/
        if 0 < swr < 1:
            self.swr = 1/swr
        else:
            self.swr = swr


    def __str__(self):
        return f"{self.real:>7.2f}  {self.imag:>+8.2f}j  {self.abs_z:>6.1f}  {self.swr:>5.2f}"



class MatchingNetwork:
    c1 = None
    l1 = None
    c2 = None

    c_unit = None
    c_str = None
    l_unit = None
    l_str = None


    def __init__(self, c1: float = None, l1: float = None, c2: float = None, z_source: Impedance = None, z_load: Impedance = None, freq: int = None):
        """
        Builds a `MatchingNetwork` object from givens.  You must provide EITHER:
        * `z_source`, `z_load`, and `freq` We'll calculate the values needed, OR
        * `c1`, `l1`, and `c2` We'll just apply the values you provide.
          * Spoiler: If you provide nothing, you'll get `c1`, `l1`, and `c2` all set to None.

        :param c1: A `float` value for a capacitor in parallel with `z_source`, in Farads. `None`, if the matching network needs capacitance in parallel with the load instead.
        :param l1: A `float` value for an inductor in series between `z_source` and `z_load`, in Henrys
        :param c2: A `float` value for a capacitor in parallel with `z_load`, in Farads. `None`, if the matching network needs capacitance in parallel with the source instead.
        :param z_source: A `Impedance` impedance of the source.
        :param z_load: A `Impedance` impedance of the load.
        :param freq: An `int` frequency to build the network for, in Hz
        :return: A `MatchingNetwork` object.
        """
        if z_source is not None and z_load is not None and freq is not None:
            self.make_network(z_source, z_load, freq)
        else:
            self.c1 = c1
            self.l1 = l1
            self.c2 = c2

        self.set_units(c='pF', l='nH')


    def set_units(self, c: str = None, l: str = None):
        c_units = {
            'F': 1,
            'mF': 1000,
            'uF': 1000000,
            'nF': 1000000000,
            'pF': 1000000000000,
        }
        l_units = {
            'H': 1,
            'mH': 1000,
            'uH': 1000000,
            'nH': 1000000000,
            'pH': 1000000000000,
        }
        if c is not None:
            if c not in c_units.keys():
                raise ValueError(f"'{c}' is not a valid capacitance unit. Must be in {c_units.keys()}")
            self.c_unit = c_units[c]
            self.c_str = c

        if l is not None:
            if l not in l_units.keys():
                raise ValueError(f"'{l}' is not a valid inductance unit. Must be in {l_units.keys()}")
            self.l_unit = l_units[l]
            self.l_str = l


    def _c_first_low_pass(self, z_source: Impedance, z_load: Impedance, freq):
        w = 2*pi*freq
        r_source = z_source.real
        x_source = z_source.imag
        r_load = z_load.real
        x_load = z_load.imag

        qs = -x_source/r_source
        ql = x_load/r_load
        rp = r_source*(1+qs*qs)
        c1 = qs/rp/w
        l1 = x_load/w
    
        if r_load > rp:
            # Load resistence is larger than source. Use LC instead.
            self.c1 = -1
            self.l1 = -1
            return
    
        Q = sqrt(rp/r_load-1)
        cp = Q/rp/w
        c = (cp-c1)
        ls = Q*r_load/w
        l = (ls-l1)
        
        self.c1 = c
        self.l1 = l
        self.c2 = None


    def make_network(self, z_source: Impedance, z_load: Impedance, freq: float):
        """
        Makes an L matching network that will match `z_load` to `z_source` at `freq`.
        Strictly speaking, `load` and `source` are arbitrary.  But the resultant network
        will have `MatchingNetwork.c1` in parallel with `z_source` and `MatchingNetwork.c2` in parallel with `z_load`,
        and `MatchingNetwork.l1` in series between them.

        Since this is an L network, not a Pi network, only either `MatchingNetwork.c1` or `MatchingNetwork.c2` will
        be defined, the other will be `None`.

        :param z_load: A `Impedance` load impedance.
        :param z_source: A `Impedance` source impedance.
        :param freq: An `int` frequency to build this network for.
        :return: None. It sets the internal values in this `MatchingNetwork` object.
        """
        self._c_first_low_pass(z_source, z_load, freq)
    
        if self.c1 < 0 or self.l1 < 0:
            # It needs an L-First network. Swap source and load, and move C to the other side in the result.
            self._c_first_low_pass(z_load, z_source, freq)
            foo = self.c1
            self.c1 = self.c2
            self.c2 = foo
    

    def apply_network(self, z_load: Impedance, freq: int):
        """
        Apply the compmonents from network to z_load at freq and return the resulting impedance.
        `MatchingNetwork.c2` is applied in parallel with `z_load`, then `MatchingNetwork.l1` in series, then `MatchingNetwork.c1` in parallel.

        :param z_load: A `Impedance` impedance.
        :param freq: An `int` frequency to apply this network at.
        :return: Returns a `Impedance` impedance.
        """
        w = 2*pi*freq
        z_effective = z_load
    
        # c2 in parallel
        if self.c2 is not None:
            z_c2 = Impedance(0, -1/(self.c2*w))
            z_effective = (z_c2*z_effective)/(z_c2+z_effective)
    
        # l1 in series
        z_l1 = Impedance(0, w*self.l1)
        z_effective = z_effective + z_l1
    
        # c1 in parallel
        if self.c1 is not None:
            z_c1 = Impedance(0, -1/(self.c1*w))
            z_effective = (z_c1*z_effective)/(z_c1+z_effective)
    
        return Impedance(z_effective)


    def __str__(self):
        if self.c1 is not None:
            c1_str = f"{round_to(self.c1*self.c_unit, 1):>4.0f}{self.c_str}"
        else:
            c1_str = "      "

        l1_str = f"{round_to(self.l1*self.l_unit, 1):>5.0f}{self.l_str}"

        if self.c2 is not None:
            c2_str = f"{round_to(self.c2*self.c_unit, 1):>4.0f}{self.c_str}"
        else:
            c2_str = "      "

        return c1_str + "  " + l1_str + "  " + c2_str

def round_to(x: float, place: float):
    # Round to place.  eg: place=0.001, x=1.234567 would return 1.235
    if x is None:
        return None
    return round(float(x)*(1/place))*place


def print_header():
    print("---------------Measurements:----------------   -----Ideal Network:----   -----Tuner Network:----     ---------Tuner Impedance:---------   -----------Mid Impedance:---------")
    print("--Freq:--  ---R:--  ----X:---  --|Z|-  -SWR-   --C:--  ---L:--  --C:--   --C:--  ---L:--  --C:--     ---R:---  ----X:---  --|Z|-  -SWR-   ---R:---  ----X:---  --|Z|-  -SWR-")


def print_row(freq, z_load=None, network_ideal=None, network_tuner=None, alarm=None, z_tuner=None, z_mid=None, row=None):
    if row is not None:
        z_load = row['z_load']
        network_ideal = row['network_ideal']
        network_tuner = row['network_tuner']
        alarm = row['alarm']
        z_tuner = row['z_tuner']
        z_mid = row['z_mid']

    print(f"{freq/1000000:>6.2f}MHz  {z_load}   {network_ideal}   {network_tuner} {alarm}  {z_tuner}    {z_mid}")


def make_networks(s1p_file, freqs):
    networks = dict()
    
    # Everything uses a 50ohm source impedance.
    z_source = Impedance(50.0, 0.0)

    s1p = rf.Network(s1p_file)
    
    # Pick the middle of the range, and also calculate actual impedances using this value
    # First quarter
    mid_freq = freqs[int(len(freqs)*.25)]
    # Middle
    #mid_freq = freqs[int(len(freqs)*.5)]
    antenna = s1p[str(mid_freq)]

    z_load = Impedance(float(antenna.z_re), float(antenna.z_im))
    network_mid = MatchingNetwork(z_source=z_source, z_load=z_load, freq=mid_freq)

    for freq in freqs:
        antenna=s1p[str(freq)]
        z_load = Impedance(float(antenna.z_re), float(antenna.z_im))
        network = MatchingNetwork(z_source=z_source, z_load=z_load, freq=freq)

        alarm = "   "

        # Actual values available on the tuner
        c1_tuner = round_to(network.c1, 10 * 10**-12)  # 10pF
        l1_tuner = round_to(network.l1, 100 * 10**-9)  # 100nH
        c2_tuner = round_to(network.c2, 10 * 10**-12)  # 10pF

        c_max = 1270 * 10**-12  # 1270pF is the most the RT-600 can apply
        l_max = 12700 * 10**-9  # 12700nH is the most the RT-600 can apply
        if c1_tuner is not None and c1_tuner > c_max:
            c1_tuner = c_max
            alarm = "!c1"
        if l1_tuner > l_max:
            l1_tuner = l_max
            alarm = "!l1"
        if c2_tuner is not None and c2_tuner > c_max:
            c2_tuner = c_max
            alarm = "!c2"

        # Actual impedance presented to source when tuned
        network_tuner = MatchingNetwork(c1=c1_tuner, l1=l1_tuner, c2=c2_tuner)
        z_tuner = network_tuner.apply_network(z_load, freq)

        # Actual impedance when using the mid-range value matching network
        z_mid = network_mid.apply_network(z_load, freq)


        # Save in the larger data structure
        networks[freq] = {
            'z_load': z_load,
            'z_tuner': z_tuner,
            'z_mid': z_mid,
            'network_ideal': network,
            'network_tuner': network_tuner,
            'network_mid': network_mid,
            'alarm': alarm,
        }

    return networks




def make_bands(s1p_file, bands):
    networks_by_band = dict()
    for band in bands:
        lower = band['lower']
        upper = band['upper']
        bw = upper-lower
        first_quarter = bw*.25 + lower
        middle = bw*.5 + lower
        third_quarter = bw*.75 + lower

        freqs = [lower, first_quarter, middle, third_quarter, upper]
        #print(f"Band: {band['name']}")
        #print_header()
        networks_by_band[band['name']] = make_networks(s1p_file, freqs)
        #for freq, network in networks_by_band[band['name']].items():
        #    print_row(freq, network['z_load'], network['network_ideal'], network['network_tuner'], network['alarm'], network['z_tuner'], network['z_mid'])
        #print("")

    return networks_by_band

if (__name__ == "__main__"):
    if len(sys.argv) < 2:
        print("ERROR: Must specify at least one 's1p' filename. Exiting.")
        exit(1)

    bands = [
        #{'lower': 135700, 'name': '2200m', 'upper': 137800},
        #{'lower': 472000, 'name': '630m', 'upper': 479000},
        #{'lower': 1800000, 'name': '160m', 'upper': 2000000},
        {'lower': 3500000, 'name': '80m Complete', 'upper': 4000000},
        {'lower': 3500000, 'name': '80m CW only', 'upper': 3750000},
        {'lower': 3750000, 'name': '75m SSB only', 'upper': 4000000},
        {'lower': 5250000, 'name': '60m', 'upper': 5450000},
        {'lower': 7000000, 'name': '40m', 'upper': 7300000},
        {'lower': 10100000, 'name': '30m', 'upper': 10150000},
        {'lower': 14000000, 'name': '20m', 'upper': 14350000},
        {'lower': 18068000, 'name': '17m', 'upper': 18168000},
        {'lower': 21000000, 'name': '15m', 'upper': 21450000},
        {'lower': 24890000, 'name': '12m', 'upper': 24990000},
        {'lower': 28000000, 'name': '10m', 'upper': 29700000},
        #{'lower': 50000000, 'name': '6m', 'upper': 54000000},
        #{'lower': 144000000, 'name': '2m', 'upper': 148000000},
        #{'lower': 219000000, 'name': '1.25m', 'upper': 225000000},
        #{'lower': 420000000, 'name': '70cm', 'upper': 450000000},
        #{'lower': 902000000, 'name': '33cm', 'upper': 928000000},
        #{'lower': 1240000000, 'name': '23cm', 'upper': 1300000000},
    ]

    networks_by_file = dict()
    files = sys.argv[1:]
    for s1p_file in files:
        networks_by_file[s1p_file] = make_bands(s1p_file, bands)
    
    #print(networks_by_file)

    # Print data by file, by band (original output)
    if False:
        for s1p_file, networks_by_band in networks_by_file.items():
            print(f"# File: {s1p_file}")
            for band, networks in networks_by_band.items():
                print(f"### Band: {band}")
                print_header()
                for freq, row in networks.items():
                    print_row(freq, row=row)
                print("")
        print("")


    # Print data across multiple files, grouped by band
    if True:
        for band in bands:
            band_name = band['name']
            print(f"# Band: {band_name}")
            for s1p_file in files:
                networks = networks_by_file[s1p_file][band_name]
                print(f"### File: {s1p_file}")
                print("```")
                print_header()
                for freq, row in networks.items():
                    print_row(freq, row=row)
                print("```")
                print("")
            print("")
