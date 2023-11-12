M98 R1

if !exists(global.probe_block_detach)
  global probe_block_detach = false
set global.probe_block_detach = false

G21 ;metric values
G90 ;absolute positioning
M83 ;relative extrusion
M107 ;start with the fan off
G92 E0 ;zero the extruded length
;G10 P0 S{param.T} R50; start preheat hotend_0
M140 S{param.H} ; start preheating the bed

var mmu = false
if exists(param.S)
  set var.mmu = true
  M98 P"mmu/lib/load-tool.g" T{param.S}

M190 S{param.H}
var rollingAverage = heat.heaters[0].avgPwm
var sampleCount = 60

if heat.heaters[0].state == "active" && heat.heaters[0].active >= 100
  while iterations < 10 || var.rollingAverage > 0.28
    G4 S1
    set var.rollingAverage = var.rollingAverage - var.rollingAverage / var.sampleCount + heat.heaters[0].avgPwm / var.sampleCount
    if mod(iterations, 60) == 0
      echo "Waiting for bed heater to settle: " ^ var.rollingAverage ^ " > 0.28"

set global.probe_block_detach = true

var need_g32 = false

if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  set var.need_g32 = true
  G28
  if result != 0
    abort "Homing failed"
else
  G28 Z
  if result != 0
    abort "Homing failed"

if var.need_g32
  set global.probe_block_detach = false
  M402
  M98 P"k/brush-nozzle.g"
  M401
  set global.probe_block_detach = true
  G32
  if result != 0
    abort "QGL failed"

set global.probe_block_detach = false

G10 P0 S{param.T} R50; start preheat hotend_0 can be later because rapido heats so rapidly

if var.need_g32
  G29
M402

if result != 0
  abort "Mesh failed"

M116 P0

if var.mmu
  G1 E50 F300

M98 P"k/clean-nozzle.g"
G1 X297 Y150 Z1 F12000
G1      Y50 Z{param.L} E30 F500 ;intro line
G92 E0 ;zero the extruded length again
