; General preferences
;M80 C"!pson"            ; pson
G21                    	; Work in millimetres
G90                     ; send absolute coordinates...
M83                     ; ...but relative extruder moves

M669 K1                 ; select CoreXY mode

; Limit axis				
M564 S1 H1             	; Forbid axis movements when not homed

; ================================== 
; Fysetc 12864 display Color
; ==================================

M918 P2 C30 E-4 F1000000   	; Configure direct-connect display
M150 X2 R255 U128 B255 P64 S1 F1
M150 X2 R255 U0 B255 P64 S1 F1
M150 X2 R200 U128 B255 P200 S1 F0

; ================================== 
; NETWORK
; ==================================

; Network
M550 P"Raven"          ; set printer name
M552 S1                ; enable network
M586 P0 S1             ; enable HTTP (for DWC)
M586 P1 S0             ; disable FTP
M586 P2 S0             ; disable Telnet

; ================================== 
; DRIVERS
; ==================================

M569 P0.0 S0 D3 V0
M569 P0.1 S1 D3 V0
M569 P0.2 S0 D3 V0
M569 P0.3 S1 D3 V0
M569 P0.4 S0 D2
M569 P0.5 S0 D2
M569 P0.6 S0 D2

M584 X0.4 Y0.5 Z0.0:0.1:0.2:0.3 E0.6
M350 X16 Y16 Z16 E16 I1                          ; configure microstepping with interpolation
M92 X160.00 Y160.00 Z400.00 E416.67                ; set steps per mm

; Accelerations and speeds
M566 X450 Y450 Z240 E300        ; Set maximum instantaneous speed changes (mm/min) aka Jerk
M203 X18000 Y18000 Z2400 E3600 ; Set maximum speeds (mm/min)
M201 X5000 Y5000 Z350 E600     ; Set maximum accelerations (mm/s^2)
M204 P4000 T5000                ; Set printing acceleration and travel accelerations

; Stepper driver currents
; set motor currents (mA) and motor idle factor in per cent
; Drive currents
M906 X1200 Y1200 Z1200 E500 I50 ; XYZ and E current
M84 S30                        ; Idle timeout

; ==================================
; Endstops						
; ==================================

; Endstops
M574 X2 S1 P"^0.io1.in"
M574 Y2 S1 P"^0.io1.out"

; Axis travel limits
M208 X0:299 Y0:308 Z0:281

; Belt Locations
M671 X-65:-65:365:365 Y0:395:395:0 S20      ; Define Z belts locations (Front_Left, Back_Left, Back_Right, Front_Right)
											; Position of the bed leadscrews.. 4 Coordinates
											; Snn Maximum correction to apply to each leadscrew in mm (optional, default 1.0)
                                            ; S20 - 20 mm spacing
M557 X30:270 Y30:270 P5                     ; Define bed mesh grid (inductive probe, positions include the Y offset!)

; ==================================
; Bed heater
; ==================================
M308 S0 A"Bed Heater" P"temp0" Y"thermistor" T100000 B3950
M950 H0 C"out0" Q10 T0
M140 H0
M143 H0 S120 ; 120C limit on bed

; ==================================
; Hotend heater 
; ==================================
M308 S1 P"0.temp1" Y"pt1000" A"Nozzle"
M950 H1 C"0.out1" T1
M143 H1 S350 ; 350C limit on nozzle

; ==================================
; SENSORS MISC 
; ==================================

M308 S3 A"MCU" Y"mcu-temp"

; ==================================
; CHAMBER SENSOR 
; ==================================
M308 S10 A"Chamber" P"0.temp2" Y"thermistor" T10000 B3950
M950 H9 C"io6.in" Q1 T10
M141 H9 ; fake chamber heater for reporting in DWC

; ==================================
; Z probes

; quickdraw
M558 K0 P8 C"^0.io0.in" T18000 F600:180 H2 A10 S0.01
G31 K0 P500 X-2.5 Y24.5 Z7.061

; nozzle probe
M558 K1 P8 C"^0.io0.out" T18000 F1200:180 H1 A10 S0.005 R0
G31 K1 P500 X0 Y0 Z0

; =================================d
=
; Fans
; ==================================
M950 F0 C"0.out6" Q32
M106 P0 S0 H-1 C"Part Cooling"

M950 F1 C"0.out5"
M106 P1 S1 H1 T45 C"Hotend Cooling"

M950 F2 C"0.out4" Q32
M106 P2 X0.6 H3 L0.5 T35 C"Electronics Fan" 

M950 F3 C"0.out3" Q32
M106 P3 H10 T55:70 L0.2 C"Chamber Exhaust"

M950 F4 C"0.out2" Q32
M106 P4 H-1 T55 C"Nevermore" ; potential thermostatic control when ABS is loaded

; Tools
M563 P0 D0 H1                                    ; define tool 0
G10 P0 X0 Y0 Z0                                  ; set tool 0 axis offsets
G10 P0 R0 S0                                     ; set initial tool 0 active and standby temperatures to 0C

M912 P0 S-8.9 ; calibrate mcu temperature offset

M98 P"k/globals.g"

M501