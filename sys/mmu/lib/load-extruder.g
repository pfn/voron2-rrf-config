if global.mmu_extruder_loaded && (!exists(param.F) || param.F != 1)
  echo "Cannot load extruder while already loaded; restarted=" ^ state.macroRestarted
  M99

G91
M98 P"mmu/lib/engage.g"
M98 P"mmu/lib/pulse-counting.g"

echo >{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ "0"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_slow_speed ^ " " ^ global.mmu_extruder_axis ^ "-2"
echo >>{global.mmu_tmp_file} "var pulse_count = global.mmu_pulse_count"
echo >>{global.mmu_tmp_file} "M302 P1"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_load_speed ^ " E" ^ {global.mmu_extruder_gear_diameter + 2} ^ " " ^ global.mmu_extruder_axis ^ {global.mmu_extruder_gear_diameter + 2}
echo >>{global.mmu_tmp_file} "M400"
echo >>{global.mmu_tmp_file} "M98 P""mmu/lib/disengage.g"""
echo >>{global.mmu_tmp_file} "set var.pulse_count = global.mmu_pulse_count"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_load_speed ^ " E" ^ {global.mmu_extruder_park}
echo >>{global.mmu_tmp_file} "M400"
echo >>{global.mmu_tmp_file} "M302 P0"
echo >>{global.mmu_tmp_file} "if global.mmu_pulse_count - var.pulse_count < 3"
echo >>{global.mmu_tmp_file} "  M84 E0 " ^ global.mmu_extruder_axis
echo >>{global.mmu_tmp_file} "  M584 P{#move.axes - 2} ; hide MMU axes"
echo >>{global.mmu_tmp_file} "  M99"
echo >>{global.mmu_tmp_file} "set global.mmu_extruder_loaded = true"
T{global.mmu_tool_number}
M98 P"mmu/lib/execute-tmp.g"
G90
M98 P"mmu/lib/save-selector-state.g"
M98 P"mmu/lib/filament-sensing.g"
M98 P"mmu/lib/filament-runout.g"
