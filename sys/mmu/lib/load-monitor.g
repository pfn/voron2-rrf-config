M98 R1

if state.macroRestarted
  if !global.mmu_extruder_loaded
    if state.status == "processing"
      M291 P{"Filament not yet loaded: T" ^ global.mmu_selector_pos} R"Load Filament" S1 T0
      M98 R1
      M226
  M99

M98 P"mmu/lib/engage.g"

var pulse_count = global.mmu_pulse_count
M98 P"mmu/lib/buzz.g"
if var.pulse_count != global.mmu_pulse_count
  M98 P"mmu/lib/disengage.g"
  abort "Filament already loaded, unload past monitor first"

M98 P"mmu/lib/pulse-trigger.g"
M584 P{#move.axes} ; allow operating on MMU axes
set global.mmu_extruder_loaded = false

G91
while iterations < 4
  echo >{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ 0
  ; TODO set the right distance
  echo >>{global.mmu_tmp_file} "G1 H1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ 1000
  echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ 50
  echo >>{global.mmu_tmp_file} "M400"
  echo >>{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ 0
  echo >>{global.mmu_tmp_file} "M574 " ^ global.mmu_extruder_axis ^ 0


  M98 P"mmu/lib/execute-tmp.g"
  M98 P"mmu/lib/pulse-counting.g"
  set var.pulse_count = global.mmu_pulse_count
  M98 P"mmu/lib/buzz.g"
  if var.pulse_count == global.mmu_pulse_count && iterations < 3
    M98 P"mmu/lib/disengage.g"
    if state.status == "processing"
      M291 P{"Filament not yet loaded: T" ^ global.mmu_selector_pos} R"Load Filament" S1 T0
      M98 R1
      M226
    else
      abort "Could not load into filament monitor"
  else
    break

M98 P"mmu/lib/disengage.g"
;M584 P{#move.axes - 2} ; hide MMU axes
