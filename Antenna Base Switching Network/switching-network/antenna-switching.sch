EESchema Schematic File Version 4
LIBS:switching-network-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 4
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
L Relay:RT42xxxx K9
U 1 1 602687AB
P 3200 2100
F 0 "K9" V 3967 2100 50  0000 C CNN
F 1 "N/S Disable" V 3876 2100 50  0000 C CNN
F 2 "Relay_THT:Relay_DPDT_Schrack-RT2-FormC_RM5mm" H 3200 2100 50  0001 C CNN
F 3 "http://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FRT2%7F1014%7Fpdf%7FEnglish%7FENG_DS_RT2_1014.pdf%7F6-1393243-3" H 3850 2250 50  0001 C CNN
	1    3200 2100
	0    1    -1   0   
$EndComp
Text GLabel 2300 1700 0    50   Input ~ 0
MatchedRFOut+
Text GLabel 2300 2100 0    50   Input ~ 0
MatchedRFOut-
$Comp
L Relay:RT42xxxx K10
U 1 1 60268890
P 3200 3600
F 0 "K10" V 3967 3600 50  0000 C CNN
F 1 "E/W Disable" V 3876 3600 50  0000 C CNN
F 2 "Relay_THT:Relay_DPDT_Schrack-RT2-FormC_RM5mm" H 3200 3600 50  0001 C CNN
F 3 "http://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FRT2%7F1014%7Fpdf%7FEnglish%7FENG_DS_RT2_1014.pdf%7F6-1393243-3" H 3850 3750 50  0001 C CNN
	1    3200 3600
	0    1    -1   0   
$EndComp
Wire Wire Line
	2300 1700 2600 1700
Wire Wire Line
	2300 2100 2500 2100
Wire Wire Line
	2600 1700 2600 3200
Wire Wire Line
	2600 3200 2900 3200
Connection ~ 2600 1700
Wire Wire Line
	2600 1700 2900 1700
Wire Wire Line
	2500 2100 2500 3600
Wire Wire Line
	2500 3600 2900 3600
Connection ~ 2500 2100
Wire Wire Line
	2500 2100 2900 2100
$Comp
L Relay:RT42xxxx K11
U 1 1 60268959
P 4750 2800
F 0 "K11" V 5517 2800 50  0000 C CNN
F 1 "Series Enable" V 5426 2800 50  0000 C CNN
F 2 "Relay_THT:Relay_DPDT_Schrack-RT2-FormC_RM5mm" H 4750 2800 50  0001 C CNN
F 3 "http://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FRT2%7F1014%7Fpdf%7FEnglish%7FENG_DS_RT2_1014.pdf%7F6-1393243-3" H 5400 2950 50  0001 C CNN
	1    4750 2800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3500 1800 4650 1800
Wire Wire Line
	4650 1800 4650 1600
Wire Wire Line
	4650 1600 5700 1600
$Comp
L Relay:RT42xxxx K12
U 1 1 60268C87
P 6300 4100
F 0 "K12" V 7067 4100 50  0000 C CNN
F 1 "E/W Reverse" V 6976 4100 50  0000 C CNN
F 2 "Relay_THT:Relay_DPDT_Schrack-RT2-FormC_RM5mm" H 6300 4100 50  0001 C CNN
F 3 "http://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FRT2%7F1014%7Fpdf%7FEnglish%7FENG_DS_RT2_1014.pdf%7F6-1393243-3" H 6950 4250 50  0001 C CNN
	1    6300 4100
	0    1    -1   0   
$EndComp
Wire Wire Line
	6600 3800 6700 3800
Wire Wire Line
	6600 4000 6700 4000
Wire Wire Line
	6700 4000 6700 3800
Connection ~ 6700 3800
Wire Wire Line
	6700 3800 7300 3800
Wire Wire Line
	6600 3600 6800 3600
Wire Wire Line
	6800 3600 6800 3900
Wire Wire Line
	6800 3900 7300 3900
Wire Wire Line
	6600 4200 6800 4200
Wire Wire Line
	6800 4200 6800 3900
Connection ~ 6800 3900
Wire Wire Line
	5200 1700 5700 1700
Wire Wire Line
	3500 3300 4150 3300
Wire Wire Line
	3500 2200 4050 2200
Wire Wire Line
	4450 2300 4250 2300
Wire Wire Line
	4250 2300 4250 2700
Wire Wire Line
	4250 2700 4450 2700
$Comp
L power:+12V #PWR018
U 1 1 6026ABAE
P 4350 3200
F 0 "#PWR018" H 4350 3050 50  0001 C CNN
F 1 "+12V" H 4365 3373 50  0000 C CNN
F 2 "" H 4350 3200 50  0001 C CNN
F 3 "" H 4350 3200 50  0001 C CNN
	1    4350 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR019
U 1 1 6026ABC5
P 6700 4500
F 0 "#PWR019" H 6700 4350 50  0001 C CNN
F 1 "+12V" H 6715 4673 50  0000 C CNN
F 2 "" H 6700 4500 50  0001 C CNN
F 3 "" H 6700 4500 50  0001 C CNN
	1    6700 4500
	1    0    0    -1  
$EndComp
Text GLabel 2900 2500 0    50   Input ~ 0
NSDisable
Text GLabel 2900 4000 0    50   Input ~ 0
EWDisable
Text GLabel 5050 3200 2    50   Input ~ 0
SeriesEnable
Text GLabel 5600 4500 0    50   Input ~ 0
EWReverse
Wire Wire Line
	4350 3200 4450 3200
Wire Wire Line
	6700 4500 6600 4500
$Comp
L Connector_Generic:Conn_01x02 J9
U 1 1 603B9DDB
P 6000 4700
F 0 "J9" H 6080 4692 50  0000 L CNN
F 1 "Simple Bias Tee Rotation Control" H 6080 4601 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 6000 4700 50  0001 C CNN
F 3 "~" H 6000 4700 50  0001 C CNN
	1    6000 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 4500 5700 4500
Wire Wire Line
	5800 4700 5700 4700
Wire Wire Line
	5700 4700 5700 4500
Connection ~ 5700 4500
Wire Wire Line
	5700 4500 6000 4500
$Comp
L power:GND #PWR020
U 1 1 603BB103
P 5700 4800
F 0 "#PWR020" H 5700 4550 50  0001 C CNN
F 1 "GND" H 5705 4627 50  0000 C CNN
F 2 "" H 5700 4800 50  0001 C CNN
F 3 "" H 5700 4800 50  0001 C CNN
	1    5700 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 4800 5800 4800
$Comp
L Connector_Generic:Conn_01x01 J18
U 1 1 603C83AD
P 7500 3900
F 0 "J18" H 7450 3800 50  0000 L CNN
F 1 "EW+" H 7600 3900 50  0000 L CNN
F 2 "Connector:Banana_Jack_1Pin" H 7500 3900 50  0001 C CNN
F 3 "~" H 7500 3900 50  0001 C CNN
	1    7500 3900
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J19
U 1 1 603C8436
P 7500 3800
F 0 "J19" H 7450 3900 50  0000 L CNN
F 1 "EW-" H 7600 3800 50  0000 L CNN
F 2 "Connector:Banana_Jack_1Pin" H 7500 3800 50  0001 C CNN
F 3 "~" H 7500 3800 50  0001 C CNN
	1    7500 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J8
U 1 1 603C87A4
P 5900 1600
F 0 "J8" H 5850 1750 50  0000 L CNN
F 1 "NS+" H 6000 1600 50  0000 L CNN
F 2 "Connector:Banana_Jack_1Pin" H 5900 1600 50  0001 C CNN
F 3 "~" H 5900 1600 50  0001 C CNN
	1    5900 1600
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J10
U 1 1 603C87AB
P 5900 1700
F 0 "J10" H 5850 1600 50  0000 L CNN
F 1 "NS-" H 6000 1700 50  0000 L CNN
F 2 "Connector:Banana_Jack_1Pin" H 5900 1700 50  0001 C CNN
F 3 "~" H 5900 1700 50  0001 C CNN
	1    5900 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 2500 4450 2500
Wire Wire Line
	4150 2500 4150 3300
Wire Wire Line
	4050 2900 4450 2900
Wire Wire Line
	4050 2200 4050 2900
Wire Wire Line
	5200 2800 5050 2800
Wire Wire Line
	5200 1700 5200 2800
Wire Wire Line
	5050 2400 5800 2400
Wire Wire Line
	5800 4100 6000 4100
Wire Wire Line
	5800 2400 5800 4100
Wire Wire Line
	3500 3700 6000 3700
$Comp
L power:+12V #PWR0105
U 1 1 604379DB
P 3600 4000
F 0 "#PWR0105" H 3600 3850 50  0001 C CNN
F 1 "+12V" H 3615 4173 50  0000 C CNN
F 2 "" H 3600 4000 50  0001 C CNN
F 3 "" H 3600 4000 50  0001 C CNN
	1    3600 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 4000 3500 4000
$Comp
L power:+12V #PWR0106
U 1 1 6043833C
P 3600 2500
F 0 "#PWR0106" H 3600 2350 50  0001 C CNN
F 1 "+12V" H 3615 2673 50  0000 C CNN
F 2 "" H 3600 2500 50  0001 C CNN
F 3 "" H 3600 2500 50  0001 C CNN
	1    3600 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 2500 3500 2500
$EndSCHEMATC
