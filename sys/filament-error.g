; filament runout script to reduce false positives
; pulse-counting filament sensor is overly sensitive

M591 D0

if !exists(global.filament_error)
  global filament_error = job.rawExtrusion
  echo "Ignoring Initial"
  M99

if global.filament_error == 0
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
