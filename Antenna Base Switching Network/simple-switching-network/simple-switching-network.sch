EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Conn_Coaxial J3
U 1 1 6096E40E
P 3700 3000
F 0 "J3" H 3850 3000 50  0000 C CNN
F 1 "VNA Test Port" H 3700 2700 50  0000 C CNN
F 2 "Connector_Coaxial:SMA_Amphenol_132134-14_Vertical" H 3700 3000 50  0001 C CNN
F 3 " ~" H 3700 3000 50  0001 C CNN
	1    3700 3000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2850 2600 3400 2600
$Comp
L Device:L_Core_Ferrite_Coupled L2
U 1 1 6096E76F
P 2650 2700
F 0 "L2" H 2650 2978 50  0000 C CNN
F 1 "1:1 Balun" H 2650 2887 50  0000 C CNN
F 2 "Libraries:Balun-FT140" H 2650 2700 50  0001 C CNN
F 3 "~" H 2650 2700 50  0001 C CNN
	1    2650 2700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2850 2800 2950 2800
Wire Wire Line
	2950 2800 2950 2700
Wire Wire Line
	2950 2700 3400 2700
Wire Wire Line
	3900 2600 3950 2600
Wire Wire Line
	3900 2700 4100 2700
Wire Wire Line
	3900 3000 3950 3000
Wire Wire Line
	3950 3000 3950 2600
Connection ~ 3950 2600
Wire Wire Line
	3950 2600 4850 2600
Wire Wire Line
	3700 3200 4100 3200
Wire Wire Line
	4100 3200 4100 2700
Connection ~ 4100 2700
Wire Wire Line
	4100 2700 4750 2700
$Comp
L Connector:TestPoint TP3
U 1 1 6096EC03
P 5200 2600
F 0 "TP3" V 5154 2787 50  0000 L CNN
F 1 "N/S +" V 5245 2787 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 5400 2600 50  0001 C CNN
F 3 "~" H 5400 2600 50  0001 C CNN
	1    5200 2600
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP4
U 1 1 6096EC46
P 5200 2800
F 0 "TP4" V 5154 2987 50  0000 L CNN
F 1 "N/S -" V 5245 2987 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 5400 2800 50  0001 C CNN
F 3 "~" H 5400 2800 50  0001 C CNN
	1    5200 2800
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP1
U 1 1 6096EE8C
P 5250 3150
F 0 "TP1" V 5204 3338 50  0000 L CNN
F 1 "E/W +" V 5295 3338 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 5450 3150 50  0001 C CNN
F 3 "~" H 5450 3150 50  0001 C CNN
	1    5250 3150
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP2
U 1 1 6096EE93
P 5250 3350
F 0 "TP2" V 5204 3538 50  0000 L CNN
F 1 "E/W -" V 5295 3538 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 5450 3350 50  0001 C CNN
F 3 "~" H 5450 3350 50  0001 C CNN
	1    5250 3350
	0    1    1    0   
$EndComp
Wire Wire Line
	4850 2600 4850 3150
Wire Wire Line
	4850 3150 5250 3150
Connection ~ 4850 2600
Wire Wire Line
	4850 2600 5200 2600
Wire Wire Line
	4750 3350 5250 3350
$Comp
L Device:D_Small D2
U 1 1 609700F6
P 5050 1950
F 0 "D2" V 5050 1800 50  0000 L CNN
F 1 "1N4001" V 4950 1650 50  0000 L CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" V 5050 1950 50  0001 C CNN
F 3 "~" V 5050 1950 50  0001 C CNN
	1    5050 1950
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 609709F2
P 1250 2600
F 0 "J1" H 1170 2817 50  0000 C CNN
F 1 "RF In" H 1170 2726 50  0000 C CNN
F 2 "Connector_Wire:SolderWirePad_1x02_P5.08mm_Drill1.5mm" H 1250 2600 50  0001 C CNN
F 3 "~" H 1250 2600 50  0001 C CNN
	1    1250 2600
	-1   0    0    -1  
$EndComp
$Comp
L Device:C_Small C3
U 1 1 60970B1C
P 2050 2600
F 0 "C3" V 2000 2850 50  0000 C CNN
F 1 ".1uF 1kV" V 2200 2600 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L10.0mm_W5.0mm_P5.00mm_P7.50mm" H 2050 2600 50  0001 C CNN
F 3 "~" H 2050 2600 50  0001 C CNN
	1    2050 2600
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C2
U 1 1 60970B60
P 2050 2450
F 0 "C2" V 2050 2700 50  0000 C CNN
F 1 ".1uF 1kV" V 2350 2450 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L10.0mm_W5.0mm_P5.00mm_P7.50mm" H 2050 2450 50  0001 C CNN
F 3 "~" H 2050 2450 50  0001 C CNN
	1    2050 2450
	0    1    1    0   
$EndComp
Wire Wire Line
	2450 2600 2200 2600
Wire Wire Line
	2150 2450 2200 2450
Wire Wire Line
	2200 2450 2200 2600
Connection ~ 2200 2600
Wire Wire Line
	2200 2600 2150 2600
Wire Wire Line
	1950 2600 1900 2600
Wire Wire Line
	1950 2450 1900 2450
Wire Wire Line
	1900 2450 1900 2600
Connection ~ 1900 2600
Wire Wire Line
	1900 2600 1550 2600
Wire Wire Line
	1650 2700 1650 2800
Wire Wire Line
	1650 2800 1700 2800
$Comp
L Device:L_Core_Ferrite L1
U 1 1 60973AD5
P 2050 1700
F 0 "L1" V 2275 1700 50  0000 C CNN
F 1 "RF Choke" V 2184 1700 50  0000 C CNN
F 2 "Inductor_THT:L_Toroid_Vertical_L35.6mm_W17.8mm_P12.70mm_Pulse_E" H 2050 1700 50  0001 C CNN
F 3 "~" H 2050 1700 50  0001 C CNN
	1    2050 1700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1550 2600 1550 1700
Wire Wire Line
	1550 1700 1900 1700
Connection ~ 1550 2600
Wire Wire Line
	1550 2600 1450 2600
$Comp
L Device:LED_Small D1
U 1 1 60976271
P 4000 2050
F 0 "D1" V 4046 1982 50  0000 R CNN
F 1 "Phase Swapped" V 3955 1982 50  0000 R CNN
F 2 "LED_THT:LED_D5.0mm" V 4000 2050 50  0001 C CNN
F 3 "~" V 4000 2050 50  0001 C CNN
	1    4000 2050
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small R1
U 1 1 609763BF
P 4000 1850
F 0 "R1" H 4059 1896 50  0000 L CNN
F 1 "2.2k" H 4059 1805 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal" H 4000 1850 50  0001 C CNN
F 3 "~" H 4000 1850 50  0001 C CNN
	1    4000 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 2700 1650 2700
Wire Wire Line
	2200 1700 2300 1700
Wire Wire Line
	1650 2700 1650 2200
Wire Wire Line
	1650 2200 2300 2200
Connection ~ 1650 2700
Wire Wire Line
	4000 1700 4000 1750
Wire Wire Line
	4000 2150 4000 2200
$Comp
L Device:CP_Small C4
U 1 1 6097BC1E
P 2300 1950
F 0 "C4" H 2388 1996 50  0000 L CNN
F 1 "10uF" H 2388 1905 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P2.50mm_P5.00mm" H 2300 1950 50  0001 C CNN
F 3 "~" H 2300 1950 50  0001 C CNN
	1    2300 1950
	1    0    0    -1  
$EndComp
Connection ~ 2300 1700
Wire Wire Line
	2300 1700 2650 1700
Wire Wire Line
	2300 1700 2300 1850
Wire Wire Line
	2300 2050 2300 2200
Connection ~ 2300 2200
Wire Wire Line
	2300 2200 2650 2200
$Comp
L Device:C_Small C5
U 1 1 6097DE88
P 2650 1950
F 0 "C5" V 2400 1950 50  0000 C CNN
F 1 ".1uF" V 2500 1950 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L7.0mm_W3.5mm_P2.50mm_P5.00mm" H 2650 1950 50  0001 C CNN
F 3 "~" H 2650 1950 50  0001 C CNN
	1    2650 1950
	-1   0    0    1   
$EndComp
Wire Wire Line
	2650 1850 2650 1700
Connection ~ 2650 1700
Wire Wire Line
	2650 1700 4000 1700
Wire Wire Line
	2650 2050 2650 2200
Connection ~ 2650 2200
Wire Wire Line
	2650 2200 4000 2200
Wire Wire Line
	4000 2200 5050 2200
Connection ~ 4000 2200
Wire Wire Line
	4000 1700 5050 1700
Connection ~ 4000 1700
Wire Wire Line
	5050 1850 5050 1700
Wire Wire Line
	5050 2050 5050 2200
Connection ~ 5050 2200
Wire Wire Line
	5050 2200 5200 2200
$Comp
L Device:C_Small C1
U 1 1 6098F754
P 2050 2300
F 0 "C1" V 2050 2550 50  0000 C CNN
F 1 ".1uF 1kV" V 2500 2300 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L10.0mm_W5.0mm_P5.00mm_P7.50mm" H 2050 2300 50  0001 C CNN
F 3 "~" H 2050 2300 50  0001 C CNN
	1    2050 2300
	0    1    1    0   
$EndComp
Wire Wire Line
	1950 2300 1900 2300
Wire Wire Line
	1900 2300 1900 2450
Connection ~ 1900 2450
Wire Wire Line
	2150 2300 2200 2300
Wire Wire Line
	2200 2300 2200 2450
Connection ~ 2200 2450
Wire Wire Line
	4750 2700 4750 2800
Wire Wire Line
	5200 2800 4750 2800
Connection ~ 4750 2800
Wire Wire Line
	4750 2800 4750 3350
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 6099A9C1
P 5550 1700
F 0 "J4" H 5629 1692 50  0000 L CNN
F 1 "Phase Reversal Relay Coil" H 5629 1601 50  0000 L CNN
F 2 "Connector_Wire:SolderWirePad_1x02_P5.08mm_Drill1.5mm" H 5550 1700 50  0001 C CNN
F 3 "~" H 5550 1700 50  0001 C CNN
	1    5550 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 1700 5350 1700
Connection ~ 5050 1700
Wire Wire Line
	5200 2200 5200 1800
Wire Wire Line
	5200 1800 5350 1800
$Comp
L Connector:TestPoint TP6
U 1 1 6099F833
P 2200 3900
F 0 "TP6" H 2258 4020 50  0000 L CNN
F 1 "Mount Hole" H 2258 3929 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 2400 3900 50  0001 C CNN
F 3 "~" H 2400 3900 50  0001 C CNN
	1    2200 3900
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP5
U 1 1 6099F961
P 2200 3700
F 0 "TP5" H 2258 3820 50  0000 L CNN
F 1 "Mount Hole" H 2258 3729 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 2400 3700 50  0001 C CNN
F 3 "~" H 2400 3700 50  0001 C CNN
	1    2200 3700
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP7
U 1 1 6099F9A1
P 2200 4100
F 0 "TP7" H 2258 4220 50  0000 L CNN
F 1 "Mount Hole" H 2258 4129 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 2400 4100 50  0001 C CNN
F 3 "~" H 2400 4100 50  0001 C CNN
	1    2200 4100
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP8
U 1 1 6099F9E7
P 2200 4300
F 0 "TP8" H 2258 4420 50  0000 L CNN
F 1 "Mount Hole" H 2258 4329 50  0000 L CNN
F 2 "MountingHole:MountingHole_3.2mm_M3_Pad" H 2400 4300 50  0001 C CNN
F 3 "~" H 2400 4300 50  0001 C CNN
	1    2200 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 2800 1700 3700
Wire Wire Line
	1700 3700 2200 3700
Connection ~ 1700 2800
Wire Wire Line
	1700 2800 2450 2800
Wire Wire Line
	2200 3900 1700 3900
Wire Wire Line
	1700 3900 1700 3700
Connection ~ 1700 3700
Wire Wire Line
	2200 4100 1700 4100
Wire Wire Line
	1700 4100 1700 3900
Connection ~ 1700 3900
Wire Wire Line
	2200 4300 1700 4300
Wire Wire Line
	1700 4300 1700 4100
Connection ~ 1700 4100
$Comp
L Connector_Generic:Conn_02x02_Top_Bottom J2
U 1 1 609A49B6
P 3600 2600
F 0 "J2" H 3650 2817 50  0000 C CNN
F 1 "Matching Network" H 3650 2726 50  0000 C CNN
F 2 "Libraries:MatchingNetworkModule" H 3600 2600 50  0001 C CNN
F 3 "~" H 3600 2600 50  0001 C CNN
	1    3600 2600
	1    0    0    -1  
$EndComp
$EndSCHEMATC