M591 D0
M220 S100 ; restore speed to 100%
M221 S100 ; restore extrusion flow to 100%

M106 P0 S0 ; layer fan off
;G1 Y300 F18000
;G1 E2 F3600 ; unretract filament from pause.g
G1 E2 F3600 ; unretract previous amount before ramming
G1 E5 F400
G1 E-15 F3600

echo >>"job-history.csv" global.cancel_statistics