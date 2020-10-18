#!/usr/bin/python3.7
import logging
import sys
from pprint import pformat

#all_bands_file = 'H422.s1p'
all_bands_file = sys.argv[1]

logging.basicConfig()
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

#bands_ini=["2200 m;135700;137800", "630 m;472000;479000", "160 m;1800000;2000000", "80 m;3500000;4000000", "60 m;5250000;5450000", "40 m;7000000;7300000", "30 m;10100000;10150000", "20 m;14000000;14350000", "17 m;18068000;18168000", "15 m;21000000;21450000", "12 m;24890000;24990000", "10 m;28000000;29700000", "6 m;50000000;54000000", "2 m;144000000;148000000", "1.25 m;219000000;225000000", "70 cm;420000000;450000000", "33 cm;902000000;928000000", "23 cm;1240000000;1300000000"]
#
#bands = {}
#for band_ini in bands_ini:
#    (name, lower, upper) = band_ini.split(';')
#    bands[name] = { "name": name, "lower": lower, "upper": upper }

bands = [
    {'lower': 135700, 'name': '2200 m', 'upper': 137800},
    {'lower': 472000, 'name': '630 m', 'upper': 479000},
    {'lower': 1800000, 'name': '160 m', 'upper': 2000000},
    {'lower': 3500000, 'name': '80 m', 'upper': 4000000},
    {'lower': 5250000, 'name': '60 m', 'upper': 5450000},
    {'lower': 7000000, 'name': '40 m', 'upper': 7300000},
    {'lower': 10100000, 'name': '30 m', 'upper': 10150000},
    {'lower': 14000000, 'name': '20 m', 'upper': 14350000},
    {'lower': 18068000, 'name': '17 m', 'upper': 18168000},
    {'lower': 21000000, 'name': '15 m', 'upper': 21450000},
    {'lower': 24890000, 'name': '12 m', 'upper': 24990000},
    {'lower': 28000000, 'name': '10 m', 'upper': 29700000},
    {'lower': 50000000, 'name': '6 m', 'upper': 54000000},
    {'lower': 144000000, 'name': '2 m', 'upper': 148000000},
    {'lower': 219000000, 'name': '1.25 m', 'upper': 225000000},
    {'lower': 420000000, 'name': '70 cm', 'upper': 450000000},
    {'lower': 902000000, 'name': '33 cm', 'upper': 928000000},
    {'lower': 1240000000, 'name': '23 cm', 'upper': 1300000000},
]

logger.debug(bands)

output_file_template = all_bands_file.strip('.s1p') + '-{}.s1p'

all_bands_data = []
with open(all_bands_file, 'r') as all_bands:
    header_line = all_bands.readline()
    all_bands_data = [line for line in all_bands]
    #for line in all_bands:
    #    freq = line.split(' ')[0]
    #    all_bands_data.append({freq: line})

logger.debug("Header: %s", header_line)

# This is NOT efficient, but we're only talking about a few thousand lines, so we can get away with this.
output_data = {}
for line in all_bands_data:
    freq = int(line.split(' ')[0])
    for band in bands:
        # Eww... O(n^2)
            if freq >= band['lower'] and freq <= band['upper']:
                if band['name'] not in output_data:
                    output_data[band['name']] = []
                output_data[band['name']].append(line)


#logger.debug(pformat(output_data))

for band, lines in output_data.items():
    output_file_name = output_file_template.format(band)
    with open(output_file_name, 'w') as output_file:
        output_file.write(header_line)
        for line in lines:
            output_file.write(line)
    logger.info("Wrote %d lines to %s.", len(lines), output_file_name)






























