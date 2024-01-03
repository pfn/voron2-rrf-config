if !exists(param.C) || !exists(param.S) || !exists(param.I) || !exists(param.J) || !exists(param.D) || !exists(param.U)
  abort "Missing required arguments"

M950 J{param.I} C"nil"
M950 P{param.I} C{param.C} Q1000
M581 T{param.U} P-1

; make sure we're at 0
M42 P{param.I} S0
G4 P100

;start sequence
M42 P{param.I} S255
G4 P10
M42 P{param.I} S0
G4 P10

; first nibble
M42 P{param.I} S255
G4 P10
M42 P{param.I} S0
G4 P10
M42 P{param.I} S0
G4 P10
M42 P{param.I} S255
G4 P10
;stuffing bit
M42 P{param.I} S0
G4 P10

; second nibble
M42 P{param.I} S0
G4 P40
;stuffing bit
M42 P{param.I} S255
G4 P10

M42 P{param.I} S0
; if the last stuffing bit is 0,  G4 P100 must run in order for verify_mode_switch to work
;G4 P100

M950 P{param.I} C"nil"
M98 P"mfm/settings.g" S"verify_mode_switch.g"

M950 J{param.J} C"nil"
M591 D{param.D} S1 P3 C{param.S} R40:200 L24

echo "Switched to MFM"
