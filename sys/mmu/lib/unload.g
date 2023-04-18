M98 R1

if state.macroRestarted
  if global.mmu_extruder_loaded
    if state.status == "processing"
      var errmsg = "Filament not yet unloaded: T" ^ global.mmu_selector_pos
      echo var.errmsg
      M291 P{var.errmsg} "Unload Filament" S1 T0
      M98 R1
      M226
  else
    M99

if !exists(param.F) && !global.mmu_extruder_loaded && global.mmu_selector_pos != -1
  echo "Filament is not loaded"
  M99
  
;M98 P"mmu/lib/engage.g"
M98 P"mmu/lib/pulse-counting.g"

var pulse_count = global.mmu_pulse_count
;M98 P"mmu/lib/buzz.g"

;if var.pulse_count == global.mmu_pulse_count
;  M98 P"mmu/lib/disengage.g"
;  abort "Filament already unloaded"
;M98 P"mmu/lib/disengage.g"

T{global.mmu_tool_number}
M302 P1
G1 E{-(10 + global.mmu_extruder_gear_diameter + global.mmu_extruder_park)} F{global.mmu_extruder_slow_speed}
while global.mmu_pulse_count > 0
  set global.mmu_pulse_count = 0
  G1 E-5 F{global.mmu_extruder_slow_speed}
M302 P0

M98 P"mmu/lib/engage.g"
set global.mmu_pulse_count = 0
echo >{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ "0"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ {-global.mmu_bowden_length}
echo >>{global.mmu_tmp_file} "M400"
M98 P"mmu/lib/execute-tmp.g"
var expected = floor(global.mmu_bowden_length / global.mmu_pulse_distance)
echo >{global.mmu_tmp_file} "var remaining = {global.mmu_pulse_distance * (" ^ var.expected ^ " - global.mmu_pulse_count)}"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ "{-var.remaining}"
echo >>{global.mmu_tmp_file} "M400"
G91
while global.mmu_pulse_count < var.expected
  if iterations > 2
    echo {"mmu_bowden_length too high? measured " ^ (global.mmu_pulse_distance * global.mmu_pulse_count)}
    break
  set var.pulse_count = global.mmu_pulse_count
  M98 P{global.mmu_tmp_file}
  if var.pulse_count == global.mmu_pulse_count
    M98 P"mmu/lib/disengage.g"
    var errmsg = "No filament movement detected during unload: T" ^ global.mmu_selector_pos
    echo var.errmsg
    if state.status == "processing"
      M291 P{var.errmsg} R"Filament Load" S1 T0
      M98 R1
      M226
    else
      abort var.errmsg

; a little extra to get past the filament monitor
echo >{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ -50
M98 P"mmu/lib/execute-tmp.g"
M98 P"mmu/lib/unload-selector.g"

set global.mmu_extruder_loaded = false
M98 P"mmu/lib/save-selector-state.g"

M84 E0
M98 P"mmu/lib/disengage.g"

G90

M98 P"mmu/lib/filament-sensing.g"
M98 P"mmu/lib/filament-runout.g"
