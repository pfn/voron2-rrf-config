M98 P"mmu/lib/filament-runout.g"
M98 P"mmu/lib/assert-endstop.g"
M98 P"mmu/lib/engage.g"
M98 P"mmu/lib/free-endstop.g"
M584 P{#move.axes} ; allow operating on MMU axes

M98 P"mmu/lib/pulse-counting.g"
var pulse_count = global.mmu_pulse_count
M98 P"mmu/lib/buzz.g"
if var.pulse_count != global.mmu_pulse_count
  M98 P"mmu/lib/disengage.g"
  abort "Filament already loaded, unload past monitor first"

echo >{global.mmu_tmp_file} "M574 S1 " ^ global.mmu_extruder_axis ^ "2" ^ " P""!" ^ global.mmu_selector_endstop_pin ^ """"
echo >>{global.mmu_tmp_file} "M208 S1 " ^ global.mmu_extruder_axis ^ "-9999"
echo >>{global.mmu_tmp_file} "M208 S0 " ^ global.mmu_extruder_axis ^ "9999"
; TODO use the correct length
echo >>{global.mmu_tmp_file} "G1 H1 F" ^ global.mmu_extruder_fast_speed ^ " " ^ global.mmu_extruder_axis ^ -700
echo >>{global.mmu_tmp_file} "M98 P""mmu/lib/assert-endstop.g"""
echo >>{global.mmu_tmp_file} "G1 F6000 " ^ global.mmu_extruder_axis ^ -15
echo >>{global.mmu_tmp_file} "M574 S1 " ^ global.mmu_extruder_axis ^ 0
echo >>{global.mmu_tmp_file} "M400"
echo >>{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ 0
echo >>{global.mmu_tmp_file} "M84 " ^ global.mmu_extruder_axis

G91
M98 P"mmu/lib/execute-tmp.g"

M98 P"mmu/lib/disengage.g"
set global.mmu_extruder_loaded = false
M98 P"mmu/lib/save-selector-state.g"
M584 P{#move.axes - 2}
