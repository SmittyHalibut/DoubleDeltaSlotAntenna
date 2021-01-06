#!/usr/bin/python3.7
from math import sqrt, floor, log10, pi
import skrf as rf
import sys


def lclp(rs, xs, rl, xl, f):
    # Same as cllp, but with source and load reversed
    return cllp(rl, xl, rs, xs, f)

def cl_reverse(rl, xl, c, l, f):
    # Calculates the reverse of cllp: What impedance is the load, with the source and matching network?
    # Reverse source and load to calculate: What impedance does the source see with the load and matching network?
    w = 2*pi*f
    c = c / 1000000000000 # pF to F
    l = l / 1000000000    # nH to H

    z_load = complex(rl, xl)
    z_c = complex(0, -1/(w*c))
    z_l = complex(0, w*l)

    zseries = z_load + z_l
    return (z_c*zseries)/(z_c+zseries)

def lc_reverse(rl, xl, c, l, f):
    # Calculates the reverse of cllp: What impedance is the load, with the source and matching network?
    # Reverse source and load to calculate: What impedance does the source see with the load and matching network?
    w = 2*pi*f
    c = c / 1000000000000 # pF to F
    l = l / 1000000000    # nH to H

    z_load = complex(rl, xl)
    z_c = complex(0, -1/(w*c))
    z_l = complex(0, w*l)

    return (z_c*z_load)/(z_c+z_load) + z_l


def cllp(rs, xs, rl, xl, f):
    w = 2*pi*f
    qs = -xs/rs
    ql = xl/rl
    rp = rs*(1+qs*qs)
    c1 = qs/rp/w
    l1 = xl/w

    if rl > rp:
        # Load resistence is larger than source. Use LC instead.
        return None

    Q = sqrt(rp/rl-1)
    cp = Q/rp/w
    c = (cp-c1) * 1000000000000  # pF
    ls = Q*rl/w
    l = (ls-l1) * 1000000000 # nH
    
    if c < 0 or l < 0:
        return None

    return {"c": c, "l": l}


def sig_digit(x, num_digits=3):
    # Round to num_digits significant digits
    return round(float(x), -int(floor(log10(abs(x)))-(num_digits-1)))


def round_to(x, place):
    # Round to place.  eg: place=0.001, x=1.234567 would return 1.235
    return round(float(x)*(1/place))*place


def make_networks(s1p_file, freqs):
    s1p = rf.Network(s1p_file)
    
    print("--------Measurements:--------   -----Ideal Matching Network:----   -Actual Matching Network:-   ---------Actual Impedance:--------")
    print("--Freq:--  ---R:--  ----X:---   ----C:---  ----L:----  ----C:---   ---C:--  ---L:---  ---C:--   ---R:---  ----X:---  --|Z|-  -SWR-")
    for f_mhz in freqs:
        f_hz = f_mhz*1000000
        net=s1p[str(f_hz)]
        rl = float(net.z_re)
        xl = float(net.z_im)
        rs = 50.0
        xs = 0.0

        # Returns None if invalid.
        cl = cllp(rs, xs, rl, xl, f_hz)
        lc = lclp(rs, xs, rl, xl, f_hz)

        # Set numeric precision, and select tuner values
        alarm = ""
        if cl is not None:
            # Ideal values
            c1 = f"{round_to(cl['c'], 0.01):>7.2f}pf"
            l = f"{round_to(cl['l'], 0.01):8.2f}nH"
            c2 = "         "

            # Actual values available on the tuner
            c_actual = round_to(cl['c'], 10)
            l_actual = round_to(cl['l'], 100)
            if c_actual > 1270:
                c_actual = 1270
                alarm += "!c"
            if l_actual > 12700:
                l_actual = 12700
                alarm += "!l"
            ct1 = f"{c_actual:>5.0f}pf"
            lt = f"{l_actual:>6.0f}nH"
            ct2 = "       "

            # Actual impedance presented to source
            zsource = cl_reverse(rl, xl, c_actual, l_actual, f_hz)
            #zsource = cl_reverse(rl, xl, cl['c'], cl['l'], f_hz)

        if lc is not None:
            # Ideal values
            c1 = "         "
            l = f"{round_to(lc['l'], 0.01):8.2f}nH"
            c2 = f"{round_to(lc['c'], 0.01):>7.2f}pf"

            # Actual values available on the tuner
            c_actual = round_to(lc['c'], 10)
            l_actual = round_to(lc['l'], 100)
            if c_actual > 1270:
                c_actual = 1270
                alarm += "!c"
            if l_actual > 12700:
                l_actual = 12700
                alarm += "!l"
            ct1 = "       "
            lt = f"{l_actual:>6.0f}nH"
            ct2 = f"{c_actual:>5.0f}pf"

            # Actual impedance presented to source
            zsource = lc_reverse(rl, xl, c_actual, l_actual, f_hz)
            #zsource = lc_reverse(rl, xl, lc['c'], lc['l'], f_hz)

        r_measured = f"{rl:>7.2f}"
        x_measured = f"{xl:>+8.2f}j"
        r_actual = f"{round_to(zsource.real, .01):>7.2f}"
        x_actual = f"{round_to(zsource.imag, .01):>+8.2f}j"
        z = sqrt(zsource.real*zsource.real + zsource.imag*zsource.imag)
        swr = z/50.0
        if swr < 1:
            swr = 1/swr
        z = sig_digit(z)

        print(f"{f_mhz:>6.2f}MHz  {r_measured}  {x_measured}   {c1}  {l}  {c2}   {ct1}  {lt}  {ct2}    {r_actual}  {x_actual}  {z:>6.1f}  {swr:>5.2f} {alarm}")


if (__name__ == "__main__"):
    if len(sys.argv) < 2:
        print("ERROR: Must specify at least one 's1p' filename. Exiting.")
        exit(1)

    freqs = [3.75, 7.15, 10.12, 14.17, 18.11, 21.20, 24.94, 28.5]
    for s1p_file in sys.argv[1:]:
        print(f"{s1p_file}")
        make_networks(s1p_file, freqs)
        print("")
    

