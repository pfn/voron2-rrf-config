M98 R1

if state.macroRestarted
  if !global.mmu_extruder_loaded
    if state.status == "processing"
      M291 P{"Filament not yet loaded: T" ^ global.mmu_selector_pos} R"Load Filament" S1 T0
      M98 R1
      M226
  M99

if global.mmu_extruder_loaded
  echo "Extruder already loaded, skipping; restarted=" ^ state.macroRestarted
  M99

if global.mmu_selector_pos == -1
  abort "Home selector first"

M98 P"mmu/lib/assert-empty.g"
M98 P"mmu/lib/load-monitor.g"

M98 P"mmu/lib/engage.g"
M98 P"mmu/lib/pulse-counting.g"

var pulse_count = global.mmu_pulse_count

G91

set global.mmu_pulse_count = 0
echo >{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ "0"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ global.mmu_bowden_length
echo >>{global.mmu_tmp_file} "M400"
M98 P"mmu/lib/execute-tmp.g"

var expected = floor(global.mmu_bowden_length / global.mmu_pulse_distance)
echo >{global.mmu_tmp_file} "var remaining = {global.mmu_pulse_distance * (" ^ var.expected ^ " - global.mmu_pulse_count)}"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ "{var.remaining}"
echo >>{global.mmu_tmp_file} "M400"
while global.mmu_pulse_count < var.expected
  if iterations > 2
    echo {"mmu_bowden_length too high? measured " ^ (global.mmu_pulse_distance * global.mmu_pulse_count)}
    break
  set var.pulse_count = global.mmu_pulse_count
  M98 P{global.mmu_tmp_file}
  if var.pulse_count == global.mmu_pulse_count
    echo "No filament movement detected during load: T" ^ global.mmu_selector_pos ^ " " ^ var.expected ^ " :: " ^ global.mmu_pulse_count
    break

echo >{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_slow_speed ^ " " ^ global.mmu_extruder_axis ^ "5"
echo >>{global.mmu_tmp_file} "M400"
while var.pulse_count != global.mmu_pulse_count
  set var.pulse_count = global.mmu_pulse_count
  M98 P{global.mmu_tmp_file}

M98 P"mmu/lib/load-extruder.g"
if !global.mmu_extruder_loaded
  var errmsg = "Load into extruder not detected: T" ^ global.mmu_selector_pos
  if state.status == "processing"
    echo var.errmsg
    M291 P{var.errmsg} R"Load Filament" S1 T0
    M98 R1
    M226
  else
    abort var.errmsg

echo >{global.mmu_tmp_file} "M84 E0 " ^ global.mmu_extruder_axis
M98 P"mmu/lib/execute-tmp.g"
M98 P"mmu/lib/disengage.g"

G90
