# Update 2021-01-16: 

## Updates to `make_matching_network.py`
Cleaned up some of the python code, making it a bit more pythonic (it's a word, look it up).  Also rearranged the output to group by band instead of file (read: antenna configuration.)  I'm trying to compare the different configurations of the antenna, so it's helpful to look at comparable data (read: for a given band) accross different configurations (read: files) together.

Look in [2021-01-05/README.md](2021-01-05/README.md) for the output of `make_matching_network.py` on the antenna data collected on that day.

### Fixed matching networks
I also added a new column.  Instead of putting a configurable antenna tuner at the base of the antenna, what if you built a single fixed matching network to make it a mono-band antenna?  Maybe a pluggable, or remotely switchable, module to change bands.  How well would that work?

For each band, I calculate the upper and lower limits of the band, and the "quarters", for a total of 5 frequencies in each band.  Using the 40m band as an example:
* Lower limit: 7.00MHz
* First quarter: 7.08MHz
* Middle: 7.15MHz
* Third quarter: 7.22Mhz
* Upper limit: 7.30MHz

I choose one of those frequencies (by hand, in code; it's not auto-caluclated), calculate the matching network for that frequency, and present what the load would look like at all 5 frequencies, given that one "mid point" matching network.

I started choosing the literal mid point, half way between the upper and lower ends of the band.  But apparently the lower slope of the matching network drops off a lot quicker than the upper slope, meaning the SWR gets worse much more quickly going down in frequency than it does going up.  In most cases, choosing the "first quarter" frequency provides a much better match across the whole band.  The code I checked in uses the "first quarter" frequency.  You'll note that the first quarter row is always a perfect 50ohm 1:1 SWR match.  This is why.

So, the "Mid Impedance" column is the R, X, |Z|, and SWR that the radio will see with this antenna if it were matched using a fixed matching network built for the "first quarter" frequency.  For the immediate term, this is just an oddity. I'm not using this for this analysis, but might use this later.

## What conclusions can we draw?
Reminder: We're looking for the "best" configuration (Parallel, Series, or Single).  

The problem is, I'm not sure how to define "Best."  Originally, I defined it as as "the least matching required" thinking that would offer the best efficiency. Turns out, matching networks aren't lossy because of their reactance, but because they're real physical devices and not ideal components.  This makes sense.  Unfortunately, it also makes it difficult to calculate efficiency using nothing but the data here.

Instead, I define "best" as "closest to 1:1 match," or "most resistive, least reactive match", regardless of "how hard" the tuner is working.

This is an analysis of the data in [2021-01-05/README.md](2021-01-05/README.md).  There's some surprisng data here, which I'll comment on in the **Notes** field.

| **Band** | **Parallel** | **Series** | **Single** |  **Notes** |
| -------- | ------------ | ---------- | ---------- | ---------- |
| 80m CW   | High SWR     | High SWR   | High SWR   | None of them are very good (3:1 to 4:1), L is out of range for all. |
| 75m SSB  | High SWR     | Very Reactive | High SWR   | L is out of range.  SWR is lowest for Series (1.1:1 to 2:1), but its almost entirely reactive. |
| 60m      | Great        | Good       | Great      | Series is a bit more reactive because C is out of range for the tuner. |
| 40m      | Good         | Reactive   | Good       | All options could use more C, but still get close. Series is only 2.2:1 at worst. |
| 30m      | Reactive     | Great      | High SWR   | Parallel and Single need more C. SWR are high, and very reactive. |
| 20m      | More React   | Reactive   | High SWR   | Antenna has very low R, very reactive, hard to match. Varies wildly over the band. Single is hardest. |
| 17m      | Great        | Reactive   | Great      | Series isn't bad, just more reactive than the others. All better than 2:1. |
| 15m      | Good         | Good       | Good       | All are equally good not great. 1:1 to 2:1, moderately reactive. |
| 12m      | Great        | Good       | Good       | Series and Single are just more reactive.  All better than 2:1. |
| 10m      | Good         | Good       | Good       | All are equally good not great. 1:1 to 2:1, moderately reactive. |

## Spit it out already! tl,dr:
For starters, I'm going to eliminate 80m for further analysis and none of the configurations do an acceptable job matching 80m.  Series configuration gets close on the SSB section, but it's almost entirely reactive.  I'm considering this a 60m and up antenna at these dimensions.

* **Q:** Is there a single best configuration?
  **A:** No. The "best" configuration changes from band to band, and all configurations have problems on one band or another.

* **Q:** What are each configuration good at?
  **A:** Let's look at them individually.
  * Parallel: Is Good or Great on all bands except 30m and 20m, where it'll still match at 2:1 or better, but very reactive matches.
  * Series: Is Good (but not Great) on all bands, except 40m, 20m, and 17m, where it's more reactive than we prefer, but less reactive than Parallel on 20m.
  * Single: Is Good or Great on all bands except 30m and 20m, where it has an unusably high SWR (above 2:1 for most the band, above 3:1 for at least part.)
  
* **Q:** Is it worth adding the complexity to switch configurations?
  **A:** That depends on how badly you want good performance on all bands.  With the exception of 20m, there is a Good or Great configuration for all bands on either Parallel or Series, so the "more complex" antenna would work well on all bands, and the simpler antenna would be a compromise on some bands.  However, the complexitiy of the switching network makes operating more difficult, the antenna more expensive to build, and you'd have to run a more complex control cable to the antenna.

* **Q:** Which configuration would you choose if you didn't want to make it switchable?
  **A:** Parallel compromises 30m and 20m, but is Great on more bands.  Series compromises 40m, 20m (somewhat less than Parallal), and 17m.  (Single is only used for rotating the antenna by 45deg.)  For me personally, I'd choose Parallel because I work during the day and operate more at night when 40m is open.

## What's next?
As stated earlier, this is all for a presentation I'm giving at [BayCon 2021](http://www.bay-net.org/baycon-radio-conference.html).  My immediate next task is to put that presentation together.

However, in conversations with W6NBC, he's got some more work he's doing on this design that he'll be presenting at QSO Today Expo in March 2021.  Once that work is released, I might do some more analysis here.  We'll see.

In the mean time, off to put together an outline.  Cheers!
-Mark

# Update 2021-01-05:
I removed all the old `.s1p` files, they are junk.  (If you really want the data to compare, look in the git history.)

[Twitter thread from today.](https://twitter.com/smittyhalibut/status/1346524796457156610?s=20)

## TIL
Did you know that calibrating a VNA is frequency dependent?  You have to set the frequency sweep range on the nVNA (easier to type than NanoVNA) before you calibrate, otherwise it will only calibrate the default range!

So, yeah.  All the Touchstone data from before today is junk.  I've removed it from the repo (it's still in the history) so no one attempts to analyze known bad data.

## Test setup
I setup a "mini field day" in my back yard: a small table and chair, equipment, battery, iced tea, etc.

The Radio setup: IC-735 (recently inherited from my dad), to 3' jumper of RG-8X, to LDG RC-600 tuner controller, to about 20' RG-58 feedline, to LDG RT-600 tuner, to about 3' jumper of RG-8X, to balun (11 turns of twin lead on an FT140-43 core), and finally to the delta loops.

I calibrated both the nVNA and the NanoVNA Saver software (it has its own calibration routines too) from 3MHz to 30MHz: nVNA, to SMA to PL-259 adapters, to 3' jumper, to RC-600, to about 20' RG-58 feedline, to PL-259 adapters, to nVNA O/S/L tests.  So this should "calibrate" the 20' feed line and controller out of my measurements.

I measured the antenna in the same three configurations as before:
* Parallel loops
* Series loops
* A single loop

Raw data is below. They look a lot closer to what I expect: a horrible match on their own, but tunable.

I added another feature to `make_matching_network.py`: If the ideal matching network component value is larger than the RT-600 can do, it sets the "actual" component value to the maximum the tuner is capable, and uses that to calculate the actual impedance that the radio sees.

### What do I see from today's nVNA data?
The three different configurations are producing different data, though the data isn't the "parallel = Z/2, series = 2Z" that I'd expect.  But at least its different now.  (Before calibration, all three configs produced nearly identical data.)

My script says that 80m, 40m, and 30m are outside the tuner's ability to tune.  However, if the tuner just gets as close as it can, it's not that bad.  In fact, a single loop on 40m still tunes to 1.05:1 even though it "doesn't have enough capacitance!"  That's better than the 2.92:1 on 20m that _IS_ in range! (See below.)

### Predictions vs Measurements in the field
It was getting dark as I was taking measurements, so I wanted to get everything packed back up and headed inside.  But I did take enough time to connect the radio and give the Tuner more time to do its work than I did before.  I also figured out how to see the SWR on this radio (it's non-obvious for some reason).

The antenna was configured for a single loop.  I tuned up on 20m, which I expected to work, and saw about 2.5:1 SWR. Not great, but workable.  I tuned up on 15 and 10m and saw about 1.5:1 (I'm going from memory.  It was "Good, but not perfect.")

"What the heck, let's see how bad 40m is."  1:1.  The SWR meter needle didn't even twitch when keying up.  What the what?  Did I blow out my finals?  No, it's still putting out power.  Huh.  Not sure what's up with that.

Later, after dinner, I started looking closer at the data I had collected and noticed that, even though 40m is "out of range" (Ideally would have about 1400pF and the tuner can only provide up to 1270pF), as close as the tuner can get is 1.05:1 on 40m.  Huh.  Then I noticed that it predicted 2.92:1 on 20m.  Double huh.  Wait, that's about what I saw!

**HOLY CATS**...  My predictions from the NanoVNA measurements and my calculations, are matching the data I'm seeing from the radio!  Granted, it's not many data points, and they're very inprecise, and from memory...  BUT IT'S MATCHING..

## On Air Observations from the shack
Back in the shack, with about 200' of possibly-questionable RG-213 between the radio/RC-600 and the tuner, and the antenna back in Parallel-InPhase configuration.  I dialed around various bands and forced a tune every 30kHz or so, just to program the tuner.  Note that the Double Delta Slot is at the back corner of my yard, about 79' away from the house.

Comparisons are made against a rotatable trap dipole ([Comet H422](https://www.dxengineering.com/parts/cma-h-422)) at ~40' elevation directly over my house, with about 125' of LMR400-UF cable. 

### Match
Sure 'nuf, the tuner was able to match the antenna down to 1:1 across the whole 40m band.  20m and 15m got down to about 1.2:1.  These match predictions.  (I didn't do an exhaustive data collection.)

### Sensitivity
The H422 is definitely louder.  Very not-scientificly, it's about 10db louder.  And that's after forcing a tune.  Granted, the feedline is shorter and lower loss, but not by enough to account for 10db.

(Before finding a blown fuse, and figuring out how to properly calibrate my nVNA, I blamed all these problems on questionable feedline and purchased [a 500' spool of DX Engineering DXE-400MAX](https://www.dxengineering.com/parts/dxe-400max-500). **'cuz why not immediately jump to the expensive solution before testing everything?!**  Anyway.  It's coming, and it's way better than the RG-213.  I'll replace the RG-213 with this LMR-400-a-like which should improve the loss in the feedline.)

### Noise
Even though the Double Delta Slot is quieter, in several cases it sounded like the signal to noise ratio was better than the H422.

Obviously this depends on where the signal is relative to the radiation pattern.  I tried to point the H422 in about the same direction as the Double Delta Slot, but I'm not sure.  It also could be that the Double Delta Slot is about 80' away from the house, where as the H422 is directly above my house. There are a lot of unknows here, but initial data is positive.

### ~~Getting out~~
I'm tired and don't feel like talking to anyone today, so I didn't attempt to make any QSOs.  We'll see how it does some other time.

## Raw Data
Raw Touchstone files are in [2021-01-05/](2021-01-05/).  I'll save you the effort of running my script on it, here's the output:
```
DoubleDletaSlotAntenna/NanoVNA Saver Files/2021-01-05$ ../make_matching_network.py Parallel-InPhase.s1p Series-InPhase.s1p Single-NS.s1p 
Parallel-InPhase.s1p
--------Measurements:--------   -----Ideal Matching Network:----   -Actual Matching Network:-   ---------Actual Impedance:--------
--Freq:--  ---R:--  ----X:---   ----C:---  ----L:----  ----C:---   ---C:--  ---L:---  ---C:--   ---R:---  ----X:---  --|Z|-  -SWR-
  3.75MHz   673.29  +1558.69j              19522.37nH   114.14pf             12700nH    110pf      54.80   -182.06j   190.0   3.80 !l
  7.15MHz     4.96   -124.38j   1340.85pf   3101.38nH               1270pf    3100nH               48.27     +8.10j    48.9   1.02 !c
 10.12MHz     2.02    -54.60j   1533.39pf   1013.50nH               1270pf    1000nH               19.80    +20.96j    28.8   1.73 !c
 14.17MHz     1.92     -8.95j   1124.61pf    208.39nH               1120pf     200nH               38.19    +13.28j    40.4   1.24 
 18.11MHz     7.34    +50.40j               1082.17nH   232.01pf              1100nH    230pf      52.94     -0.92j    52.9   1.06 
 21.20MHz     8.60    -30.80j    329.50pf    372.87nH                330pf     400nH               60.14    -20.87j    63.7   1.27 
 24.94MHz     3.17    +31.10j                725.09nH   250.11pf               700nH    250pf      50.19     -4.11j    50.4   1.01 
 28.50MHz     7.35    +73.03j               1031.78nH   103.86pf              1000nH    100pf      65.61    -30.14j    72.2   1.44 

Series-InPhase.s1p
--------Measurements:--------   -----Ideal Matching Network:----   -Actual Matching Network:-   ---------Actual Impedance:--------
--Freq:--  ---R:--  ----X:---   ----C:---  ----L:----  ----C:---   ---C:--  ---L:---  ---C:--   ---R:---  ----X:---  --|Z|-  -SWR-
  3.75MHz    44.06   -430.58j    311.64pf  18961.00nH                310pf   12700nH               11.18    -68.87j    69.8   1.40 !l
  7.15MHz     3.04    -91.01j   1749.56pf   2291.88nH               1270pf    2300nH               25.65    +26.44j    36.8   1.36 !c
 10.12MHz    17.71   -177.01j    424.79pf   3159.78nH                420pf    3200nH               57.21     -1.98j    57.2   1.14 
 14.17MHz     1.54    -26.32j   1258.23pf    392.78nH               1260pf     400nH               48.52    -20.84j    52.8   1.06 
 18.11MHz     2.10     +8.31j    840.10pf     15.03nH                840pf       0nH               25.44    +15.63j    29.9   1.67 
 21.20MHz     6.17     -2.54j    400.10pf    142.55nH                400pf     100nH               21.33     +8.84j    23.1   2.17 
 24.94MHz     2.93    +42.72j               1082.70nH   183.30pf              1100nH    180pf      60.01    -11.88j    61.2   1.22 
 28.50MHz     4.03    +31.78j                564.99nH   217.28pf               600nH    220pf      45.39     +9.97j    46.5   1.08 

Single-NS.s1p
--------Measurements:--------   -----Ideal Matching Network:----   -Actual Matching Network:-   ---------Actual Impedance:--------
--Freq:--  ---R:--  ----X:---   ----C:---  ----L:----  ----C:---   ---C:--  ---L:---  ---C:--   ---R:---  ----X:---  --|Z|-  -SWR-
  3.75MHz   287.18  -1065.65j              19429.38nH    54.49pf             12700nH     50pf      55.21   -181.53j   190.0   3.79 !l
  7.15MHz     4.60   -124.89j   1398.91pf   3101.65nH               1270pf    3100nH               45.45    +13.63j    47.4   1.05 !c
 10.12MHz     2.02    -62.56j   1534.91pf   1138.56nH               1270pf    1100nH               10.63    +13.99j    17.6   2.85 !c
 14.17MHz     1.57    -20.63j   1247.44pf    329.64nH               1250pf     300nH               11.64    +12.53j    17.1   2.92 
 18.11MHz     3.27    +17.44j                423.27nH   574.68pf               400nH    570pf      52.63     -2.48j    52.7   1.05 
 21.20MHz     6.04    -12.41j    404.93pf    215.55nH                400pf     200nH               37.26     +9.22j    38.4   1.30 
 24.94MHz     2.33    +31.18j                868.49nH   244.83pf               900nH    240pf      62.03     -8.07j    62.6   1.25 
 28.50MHz     5.01    +60.86j               1040.82nH   119.09pf              1000nH    120pf      47.08     -2.17j    47.1   1.06 
```

73 de KR6ZY -Mark

# Update 2021-01-01:
Added a lot more to `make_matching_network.py`:
* Calculates the idea matching network.
* Rounds those values to the nearest 10pF and 100nH, the resolution of the RT-600 remote tuner.
* Calculates the actual impedance and SWR seen by the radio with that antenna impedance and actual matching network.

All my `.s1p` files, and the script, are here if you want to work on this yourself.  I'll save you the work, here's the data:

**NOTE: There used to be data here, but I deleted it because it was measured incorrectly.  See above about calibration.  It's still available in git history if you really want to see it.**

## Analysis: What the...
~~What the Heck?  Why are those numbers so dang close?  I'd expect the complex impedance of a single loop Z, when in parallel to be Z/2, and when in series to be 2Z.  But that's not what we're seeing.  My MATH is right, the source R+jX values are awfully close.  So either my understanding of antennas in parallel/series is wrong, or my measurements of the antenna is wrong.~~

Turns out, I was using the nVNA wrong.

More later. 73 de KR6ZY

# Update 2020-12-28:
So, apparently, I've been suckered into presenting this data and analysis at [BayCon 2021](http://www.bay-net.org/baycon-radio-conference.html) by George, KJ6VU.  Which means I need to actually do something useful with this data.  So, here goes.

## Blog Format
To keep the history, I'm changing this `README.md` to a blog-like format, with date stamp headers, and keeping historic entries below.

## Antenna Status
tl,dr: I'm making progress. I finally finished some blocker-projects (notably: running cables to the antenna), and I've got another two weeks of vacation in front of me. Getting this antenna built and usable is my top project goal.  I hope to get some better data tomorrow.

## Data Quality
The data presented in the 2020-10-17 update below is highly suspect.  I don't trust the wiring in the switch box I made, so I've rebuilt the balun/loop configuration box and, once the weather dries up (first rain of the year today! Hey, I live in California, this is a big deal...) I'll go out, hook it up, and re-measure the antenna in the various configurations.

## Automating Analysis
Today, I wrote a python script called `make_matching_network.py` which uses the S11 parameters from the NanoVNA and calculates the L matching network needed to match that to a 50+j0 ohm load.  It uses the [scikit-rf](https://github.com/scikit-rf/scikit-rf) Python module to parse the `s1p` Touchstone files from NanoVNA Saver and convert the S parameters to R+jX values.  I stole the math from [the source](view-source:https://home.sandiego.edu/~ekim/e194rfs01/jwmatcher/matcher2.html) of [this page](https://home.sandiego.edu/~ekim/e194rfs01/jwmatcher/matcher2.html).

Running `make_matching_network.py` passing it at least one `s1p` filename on the command line, it calculates the L and C vaules needed to match that configuration to a 50+j0 impedance at the center(ish) of the 80, 40, 30, 20, 17, 15, 12, and 10m bands.  (You can edit the script, and update `freqs` if you want to change the frequencies it works on.)

I'm using the data files from 2020-10-17 for testing my code, but I'll re-run it after collecting more trustworthy data, hopefully tomorrow.

## What are we Analyzing?
My goal is to identify the "best" configurations for each band, but what is "best?"
* At the very least, verifying the tuner CAN match it.  Not even being able to match the antenna is definitely not "best."
* In the best case, identify the most efficient tuner setting.

### Will It ~~Blend~~ Match?!
My remote tuner is the [LDG RT-600](https://ldgelectronics.com/index.php/products/remote/rt-600/).  "Have screwdriver, will reverse engineer."  See [RT-600.md](RT-600.md) for details of what I found, but tl,dr is: it's basically an L network with a series inductor and parallel capacitor, that can switch the capacitor to either side of the inductor.  The capacitor can be anything from 0pF to 1270pF in 10pF steps.  The inductor can be anything from 0nH to 12700nH in 100nH steps.

So any calculated L between 0nH and 12700nH, and any calculated C between 0pF and 1270pF, should be matchable by the tuner to some level of precision.

### Do You Even ~~Lift~~ Match, bro?
Making the matching network efficient is a different thing.  To be honest, I haven't looked into calculating efficiency of a matching network.  I'm going to type something now that will either make me look like a fool, or a naturally gifted genius who understands this stuff intuitively...

I think efficiency is worse the more L and C you need to match the load.  So smaller L and C values are better.

## Conclusion Goals
Given all the above, the goal is to:
* Use the NanoVNA to analyze the antenna in three different configurations:
  * Single Loop
  * Parallel Loops
  * Series Loops
* Calculate the matching network required to match each configuration to a 50+j0 load on each of the ham bands.
* Verify my tuner can handle it: L < 12700nH, C < 1270pF
* Idenfity which configuration has lower L and C values.
  * TODO: What to do if one config has a better L but the other has a better C?  Might have to break out some actual math.
* Is one configuration a clear winner for all bands?  Or is the "best" configuration different for each band?
  * If different, calculate the worst case efficiency for each configuration.  Then it's a judgement call whether that efficiency loss is worth the added switching complexity.

73 de KR6ZY
-Mark

# Update 2020-10-17
## Caveat with the data
I'm posting the first data I collected on 2020-10-17.  BUT: I think I've got some bad wiring, loose connectors, or something. It's pretty noisy when things move of jiggle. So this data is pretty suspect, even though the graphs look smooth.  That just means I managed to sit still while the collection was running.  There some pretty different data below that should be very similar, and it's not.

**UPDATE 2021-01-05: Yep, this data was very wrong.**

## How this was collected:
I used my NanoVNA-F, and [NanoVNA-Saver](https://github.com/NanoVNA-Saver/nanovna-saver) v0.3.7.  I configured Saver to scan from 3.0MHz to 30.27MHz with 27 Segments. This SHOULD have had it testing every 10kHz, but the raw data suggests otherwise.  _sigh_  Anyway.  That raw data was saved into the respective directories.  

I also wrote a script that takes the raw data and splits it out by band into individual smaller Saver files.  That raw data is included here, but Saver doesn't have a way to automate displaying and capturing data, so for the PNGs and tabular data, I'm just using the full spectrum file to minimize the number of screen captures I need to take.

The configurations I tested are:
* Both loops in parallel:
  * EW loop "in phase"
  * EW loop "out of phase"
* Both loops in series:
  * EW loop "in phase"
  * EW loop "out of phase"
* Indiviual loops:
  * NS loop
  * EW loop "in phase" (that relay in it's unenergized state)
  * EW loop "out out phase" (that relay energized. SHOULD BE no different at all.)

The configurations were switched with relays as described in the `Switching` directory parallel to this one.

## Expectations:
* I expect the Phase to not affect the impedance of the antenna much, so the "in phase" and "out of phase" version of Paralle and Series should be very similar.
* I expect the Parallel loops to be a lower impedance than the Single loops, and the Series loops to be a higher impedance than the Single loops.
* I expect the two Single loops to be about the same, though will probably have some slight difference just from differences in construction and their environment.

## Tabular data
This table just summarizes the complex impedances at the markers in each of the images below.  I THINK the R+jX values are what you need
to figure out how hard your tuner is working?  Maybe?

**UPDATE 2021-01-05: There used to be a table of data here, but it was very wrong. If you want to see it, it's still in git history.**

