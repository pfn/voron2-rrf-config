; reset current position to 0
G92 X0

if !move.axes[1].homed
	; raise Z a bit
	G91
	G1 H2 Z5 F2400
	G90

; move Y forward to avoid hitting the probe dock
G91
G1 Y10 X-10 H2 F9000
;G1 Y-10 H2 F2400

; Move quickly to X axis endstop and stop there (first pass)
G1 X305 F9000 H1
; Go back a few mm
;M119
G1 X-5 F18000
; Move slowly to X axis endstop once more (second pass)
G1 X10 F360 H1
G90