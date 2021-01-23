# Introduction
* Who am I?

# Background and Goals
## W6NBC Double Delta HF Slot
* https://w6nbc.com/articles/2020-TBDdoubledelta.pdf
* Looks great on paper, does it live up to it?

## I blame George
* Which is better, Parallel or Series?
* Can you rotate it by 45deg instead of 90deg by using a single loop?

# Data Collection
## Build it!
* 3D model for bracket: https://github.com/SmittyHalibut/DoubleDeltaSlotAntenna/tree/mainline/Brackets
* 22' tall loop, 2' off the ground, 24' height at top
* 4' spreader arms, 8' total spread at top
* Tuner: RT-600 (same as W6NBC used)
* Balun: 11 turns of speaker wire on FT140-43

## Oops...
* John's design has: Radio -> Feeline -> Balun -> Tuner -> Antenna
  * Uses an unbalanced tuner in a balanced circuit.
* I built: Radio -> Feedline -> Tuner -> Balun -> Antenna
  * Uses a balun designed for 50+j0 ohms in a wildly varried and complex impedance circuit.
* Neither are perfect. I'm proceeding with my analysis. I've already got the data.

## Measure it!
* NanoVNA-F
  * Learn to calibrate!
* NanoVNA Saver software
  * 3MHz to 30.27MHz in 2727 steps of 10kHz (27 segments of 101 data points each.)
  * Measures S11: Power output, and power _and relative phase_ of reflection.
  * Saves data in the standard "Touchstone" file format: `.s1p` files.
  * NanoVNA Saver does lots of visualizations and calculations on its own! Its very neat.

## Understand it!
* I wrote a python script to analize the data in the Touchstone file.
* For 5 data points across each ham band:
  * What does the antenna look like natively? It's all over the place, as expected.
  * What is the theoretical perfect matching L network?
  * What matching network can the RT-600 make based on its limitations?
    * 0 to 1270pF in 10pF steps
    * 0 to 12700nH in ~100nH steps
  * What impedance is presented to the radio, given this "actual" matching network?
  * Extra credit: Pick an "optimal" single matching network per band. What impedance does that present to the radio across the band?

# Conclusions
* This analysis is of MY PARTICULAR BUILD.
* The build is very flexible on exact dimentions, because the tuner will handle it.
* If you build yours differently than I built mine, your numbers are likely to be different!

## Show us the data
* Include snapshot of raw data, showing:
  * Parallel is good or great from 60m to 10m, except 30m and 20m
  * Series is good (but not great) at 60m, and 15m and above. It's GREAT on 30m, not pretty reactive on 40m, 20, and 17m.
  * Single is good or great from 60m to 10m, but nearly unusably high SWR on 30m and 20m.
* Very minimal, non-scientific, practical experience matches this data.

## What's it good at?
* All the benefits that John describes in his article.
* Covers all bands from 60m to 10m to varying degrees.
  * Possibly usable at 6m too, I didn't measure.
* Easy to construct, could be made "field-day" portable (but probably not SOTA portable.)

## What's it not so good at?
* 80m and below is a complete loss. A larger/taller loop would probably be better.
* 20m is not great in any configuration. Usable, but with very reactive impedance.

## How would I build it? (Haven't I already built it?)
* If I cared strongly about 30m, I would consider building a complex switching network to do Series on 30m, and parallel on other bands.
* I'm willing to trade 30m to get simplicity, so I will only build mine for Parallel.
* But someone with different goals, or an antenna with different numbers, I could see wanting the complexity.

## Is there a benefit to supporting single loops for 45deg rotation resolution?
* Would it help?
  * The modeled beam width is -3db at 90deg, so it wouldn't help reception sensitivity much.
  * The nulls are pretty narrow, so rotating 45deg might help point nulls.
* Can it even be done?
  * The Single loop numbers are similar to the Parallel numbers: Good or great from 60m to 10m, except 30m and 20m
* Should it be done?
  * RT-600 remembers the matching network for a given frequency.
  * Changing the antenna impedance on a given frequency will require the tuner to completely retune every time you switch from Dual to Single, losing the benefit of the memory.
  * The tuner turned out to be more of a pain than I expected, so anything that makes the tuner less effective is not good, IMHO.

# Next Steps
## A remote switching box
* If you DO want the full switching options, I've designed a switching network that will do:
  * Parallel, In and Out of phase.
  * Series, In and Out of phase.
  * Single N/S loop, or E/W loop.
* Using 4 Relays: 3 DPDT, 1 3PDT (for safety interlock to make sure only valid states are selected.)
* I'm considering designing a board with:
  * SO-239 input, a spot for a balun, relays, and screw terminals for the antenna loops.
  * Microcontroller to control the relays
  * Using George's serial protocol for remote control over RS-485 or ZigBee

## More work from W6NBC coming
* I won't steal his thunder. Watch for his presentation in the QSO Today Ham Expo in March 2021.
* It will make the antenna a bit cheaper to construct, eliminating the need for a remote tuner.

