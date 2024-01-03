
G91 ; relative positioning
G1 Z5 F2400 ; move nozzle relative to position
G90 ; absolute positioning

M591 D0 ; print out filament sensing diagnostics
M106 P0 S0 ; layer fan off
M220 S100 ; reset speed factor to 100%
M221 D0 S100

G1 E-2 F3600

M98 P"k/purge-bucket.g"

if move.axes[2].userPosition > 265 ; safe height for Z hop when homing and preventing hitting the idler
  G1 Z265 F4800

G1 E2 F3600 ; unretract previous amount before ramming
G1 E1 F400
G1 E-15 F3600
;G1 Y300 F18000 ; move away from the probe dock to prevent collision

G10 P0 S-273.1 ; turn off T0
M144
M140 S-273.1 ; turn off bed heater
G92 E0 ; reset extrusion position
M84 ; stop all motors
var extrusion = 0
while #job.file.filament > 0
  if iterations + 1 > #job.file.filament
    break
  set var.extrusion = var.extrusion + job.file.filament[iterations]

echo >>"job-history.csv" """" ^ job.lastFileName ^ """," ^ state.time ^ "," ^ job.lastDuration ^ ",1," ^ var.extrusion
M150 E1 U255 P192 S1 F0