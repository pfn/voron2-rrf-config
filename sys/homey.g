if !move.axes[0].homed
	; raise Z a bit
	G91
	G1 H2 Z5 F2400
	G90

; reset current position to 0
G92 Y0

; Move quickly to Y axis endstop and stop there (first pass)
G1 Y315 F9000 H1

G91
; Go back a few mm
G1 Y-5 F18000

; Move slowly to Y axis endstop once more (second pass)
G1 Y10 F360 H1
G90
