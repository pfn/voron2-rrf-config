; filament runout script to reduce false positives
; pulse-counting filament sensor is overly sensitive

var filamentDiameter = move.extruders[0].filamentDiameter/2
echo "Volumetric rate " ^ (pi * var.filamentDiameter * var.filamentDiameter * move.currentMove.extrusionRate) ^ "mm³/s"

if sensors.filamentMonitors[0].calibrated != null && sensors.filamentMonitors[0].calibrated.percentMin > 15
  echo "Ignoring extrusion error, not <15%"
  M591 D0
  M591 D0 S1
  M99

if sensors.filamentMonitors[0].calibrated != null
  M591 D0
  M591 D0 S1

if !exists(global.filament_error)
  global filament_error = job.rawExtrusion
  echo "Ignoring Initial"
  M99

if global.filament_error < 0
  set global.filament_error = job.rawExtrusion
  echo "Ignoring First"
  M99

if (job.rawExtrusion - global.filament_error) < 50
  M291 P{"Pausing: " ^ param.S} R"Filament Feed Problem" S1 T10
  echo "Pausing: " ^ (job.rawExtrusion - global.filament_error)
  M25
else
  echo "Ignoring: " ^ (job.rawExtrusion - global.filament_error)

set global.filament_error = job.rawExtrusion
