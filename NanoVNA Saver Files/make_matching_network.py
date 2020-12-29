#!/usr/bin/python3.7
from math import sqrt, floor, log10
import skrf as rf
import sys


def lclp(rs, xs, rl, xl, f):
    # Same as cllp, but with source and load reversed
    return cllp(rl, xl, rs, xs, f)

def cllp(rs, xs, rl, xl, f):
    w = 2.0*3.14159*f
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
    
    return {"c": c, "l": l}


def sig_digit(x, num_digits=3):
    # Round to num_digits significant digits
    return round(float(x), -int(floor(log10(abs(x)))-(num_digits-1)))


def make_networks(s1p_file, freqs):
    s1p = rf.Network(s1p_file)
    
    for f_mhz in freqs:
        f_hz = f_mhz*1000000
        net=s1p[str(f_hz)]
        rl = float(net.z_re)
        xl = float(net.z_im)
        rs = 50.0
        xs = 0.0

        cl = cllp(rs, xs, rl, xl, f_hz)
        lc = lclp(rs, xs, rl, xl, f_hz)

        if cl is not None and (cl['c'] < 0 or cl['l'] < 0):
            cl = None
        if lc is not None and (lc['c'] < 0 or lc['l'] < 0):
            lc = None

        if cl is None:
            print(f"Freq: {f_mhz}MHz\tR+jX: {sig_digit(rl)}+j{sig_digit(xl)}\tC:\t\tL: {sig_digit(lc['l'])}nH\tC: {sig_digit(lc['c'])}pF")
        elif lc is None:
            print(f"Freq: {f_mhz}MHz\tR+jX: {sig_digit(rl)}+j{sig_digit(xl)}\tC: {sig_digit(cl['c'])}pF\tL: {sig_digit(cl['l'])}nH\tC:")
        else:
            print(f"Freq: {f_mhz}MHz\tR+jX: {sig_digit(rl)}+j{sig_digit(xl)}\tC: {sig_digit(cl['c'])}pF\tL: {sig_digit(cl['l'])}nH\t\tL: {sig_digit(lc['l'])}nH\tC: {sig_digit(lc['c'])}pF")


if (__name__ == "__main__"):
    if len(sys.argv) < 2:
        print("ERROR: Must specify at least one 's1p' filename. Exiting.")
        exit(1)

    freqs = [3.75, 7.15, 10.12, 14.17, 18.11, 21.20, 24.94, 28.5]
    for s1p_file in sys.argv[1:]:
        print(f"File: {s1p_file}")
        make_networks(s1p_file, freqs)
        print("")
    

