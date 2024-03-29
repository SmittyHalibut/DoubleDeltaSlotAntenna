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
L Device:L_Core_Ferrite L1
U 1 1 603D0CF5
P 3750 2000
F 0 "L1" V 3975 2000 50  0000 C CNN
F 1 "L_Core_Ferrite" V 3884 2000 50  0000 C CNN
F 2 "Inductor_THT:L_Toroid_Vertical_L41.9mm_W19.1mm_P15.80mm_Vishay_TJ7" H 3750 2000 50  0001 C CNN
F 3 "~" H 3750 2000 50  0001 C CNN
	1    3750 2000
	0    -1   -1   0   
$EndComp
$Comp
L Device:L_Core_Ferrite L2
U 1 1 603D0D59
P 3750 2400
F 0 "L2" V 3500 2400 50  0000 C CNN
F 1 "L_Core_Ferrite" V 3600 2400 50  0000 C CNN
F 2 "Inductor_THT:L_Toroid_Vertical_L41.9mm_W19.1mm_P15.80mm_Vishay_TJ7" H 3750 2400 50  0001 C CNN
F 3 "~" H 3750 2400 50  0001 C CNN
	1    3750 2400
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C4
U 1 1 603D0DD0
P 4200 2200
F 0 "C4" H 4292 2246 50  0000 L CNN
F 1 "C_Small" H 4150 2600 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.0mm_W3.5mm_P5.00mm" H 4200 2200 50  0001 C CNN
F 3 "~" H 4200 2200 50  0001 C CNN
	1    4200 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C3
U 1 1 603D0DFA
P 3250 2200
F 0 "C3" H 3342 2246 50  0000 L CNN
F 1 "C_Small" H 3150 2650 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L13.0mm_W5.0mm_P10.00mm_FKS3_FKP3_MKS4" H 3250 2200 50  0001 C CNN
F 3 "~" H 3250 2200 50  0001 C CNN
	1    3250 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 2000 3250 2000
Wire Wire Line
	3250 2000 3250 2100
Wire Wire Line
	3900 2000 4200 2000
Wire Wire Line
	4200 2000 4200 2100
Wire Wire Line
	3250 2300 3250 2400
Wire Wire Line
	3250 2400 3600 2400
Wire Wire Line
	3900 2400 4200 2400
Wire Wire Line
	4200 2400 4200 2300
Wire Wire Line
	4200 2000 4350 2000
Wire Wire Line
	4950 2000 4950 2150
Wire Wire Line
	4950 2150 5050 2150
Connection ~ 4200 2000
Wire Wire Line
	4200 2400 4350 2400
Wire Wire Line
	4950 2400 4950 2250
Wire Wire Line
	4950 2250 5050 2250
Connection ~ 4200 2400
Wire Wire Line
	3250 2000 3100 2000
Wire Wire Line
	2550 2000 2550 2150
Wire Wire Line
	2550 2150 2400 2150
Connection ~ 3250 2000
Wire Wire Line
	2400 2250 2550 2250
Wire Wire Line
	2550 2250 2550 2400
Wire Wire Line
	2550 2400 2950 2400
Connection ~ 3250 2400
$Comp
L Device:C_Small C2
U 1 1 603D159E
P 3100 2200
F 0 "C2" H 3192 2246 50  0000 L CNN
F 1 "C_Small" H 3000 2650 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L10.0mm_W4.0mm_P7.50mm_FKS3_FKP3" H 3100 2200 50  0001 C CNN
F 3 "~" H 3100 2200 50  0001 C CNN
	1    3100 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C1
U 1 1 603D1784
P 2950 2200
F 0 "C1" H 3042 2246 50  0000 L CNN
F 1 "C_Small" H 2850 2650 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.0mm_W3.5mm_P5.00mm" H 2950 2200 50  0001 C CNN
F 3 "~" H 2950 2200 50  0001 C CNN
	1    2950 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C5
U 1 1 603D1970
P 4350 2200
F 0 "C5" H 4442 2246 50  0000 L CNN
F 1 "C_Small" H 4300 2600 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L10.0mm_W4.0mm_P7.50mm_FKS3_FKP3" H 4350 2200 50  0001 C CNN
F 3 "~" H 4350 2200 50  0001 C CNN
	1    4350 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C6
U 1 1 603D1998
P 4500 2200
F 0 "C6" H 4592 2246 50  0000 L CNN
F 1 "C_Small" H 4450 2600 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L13.0mm_W5.0mm_P10.00mm_FKS3_FKP3_MKS4" H 4500 2200 50  0001 C CNN
F 3 "~" H 4500 2200 50  0001 C CNN
	1    4500 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 2100 3100 2000
Connection ~ 3100 2000
Wire Wire Line
	3100 2000 2950 2000
Wire Wire Line
	2950 2100 2950 2000
Connection ~ 2950 2000
Wire Wire Line
	2950 2000 2550 2000
Wire Wire Line
	2950 2300 2950 2400
Connection ~ 2950 2400
Wire Wire Line
	2950 2400 3100 2400
Wire Wire Line
	3100 2300 3100 2400
Connection ~ 3100 2400
Wire Wire Line
	3100 2400 3250 2400
Wire Wire Line
	4350 2100 4350 2000
Connection ~ 4350 2000
Wire Wire Line
	4350 2000 4500 2000
Wire Wire Line
	4500 2000 4500 2100
Connection ~ 4500 2000
Wire Wire Line
	4500 2000 4950 2000
Wire Wire Line
	4500 2300 4500 2400
Connection ~ 4500 2400
Wire Wire Line
	4500 2400 4950 2400
Wire Wire Line
	4350 2400 4350 2300
Connection ~ 4350 2400
Wire Wire Line
	4350 2400 4500 2400
$Comp
L Connector_Generic:Conn_02x02_Top_Bottom J1
U 1 1 603D3618
P 2200 2150
F 0 "J1" H 2250 2367 50  0000 C CNN
F 1 "Conn_02x02_Top_Bottom" H 2250 2276 50  0000 C CNN
F 2 "Libraries:MatchingNetworkModule" H 2200 2150 50  0001 C CNN
F 3 "~" H 2200 2150 50  0001 C CNN
	1    2200 2150
	-1   0    0    -1  
$EndComp
Text GLabel 5050 2150 2    50   Input ~ 0
Out+
Text GLabel 5050 2250 2    50   Input ~ 0
Out-
Text GLabel 1900 2150 0    50   Input ~ 0
Out+
Text GLabel 1900 2250 0    50   Input ~ 0
Out-
$EndSCHEMATC
