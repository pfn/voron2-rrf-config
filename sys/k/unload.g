T0
M116 P0
M83 ; ensure relative extrusion
M98 P"k/purge-bucket.g"

G1 E10 F300    ; extrude a little to get the hot bits out
;M98 P"k/filament-ram.g"
G1 E-10 F3600
G0 E-80 F300       ;Continue extraction slowly, allow the filament time to cool solid before it reaches the gears