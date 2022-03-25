M98 R1
G21 ;metric values
G90 ;absolute positioning
M83 ;relative extrusion
M107 ;start with the fan off
G92 E0 ;zero the extruded length
G10 P0 S{param.T} R50; start preheat hotend_0
M140 S{param.H} ; start preheating the bed
M190 S{param.H}

if param.H >= 100
  while heat.heaters[0].avgPwm > 0.28
    G4 S60

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28
  if result != 0
    abort "Homing failed"

if global.need_g32
  G32
  if result != 0
    abort "QGL failed"

G29

M116 P0

M98 P"k/clean-nozzle.g"
G1 X297 Y150 Z1 F12000
G1      Y50 Z{param.L} E30 F500 ;intro line
G92 E0 ;zero the extruded length again