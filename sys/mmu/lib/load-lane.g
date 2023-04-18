M98 P"mmu/lib/assert-empty.g"
M98 P"mmu/lib/free-endstop.g"
M98 P"mmu/lib/engage.g"
M584 P{#move.axes} ; allow operating on MMU axes
set global.mmu_extruder_loaded = false

G91
echo >{global.mmu_tmp_file} "M574 S1 " ^ global.mmu_extruder_axis ^ "2" ^ " P""" ^ global.mmu_selector_endstop_pin ^ """"
echo >>{global.mmu_tmp_file} "M208 S1 " ^ global.mmu_extruder_axis ^ "-9999"
echo >>{global.mmu_tmp_file} "M208 S0 " ^ global.mmu_extruder_axis ^ "9999"
echo >>{global.mmu_tmp_file} "G91"
echo >>{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ 0
echo >>{global.mmu_tmp_file} "G1 H1 F600 " ^ global.mmu_extruder_axis ^ 600
echo >>{global.mmu_tmp_file} "M98 P""mmu/lib/assert-endstop.g"""
echo >>{global.mmu_tmp_file} "G1 F6000 " ^ global.mmu_extruder_axis ^ -15
echo >>{global.mmu_tmp_file} "M400"
echo >>{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ 0
echo >>{global.mmu_tmp_file} "M574 " ^ global.mmu_extruder_axis ^ 0
echo >>{global.mmu_tmp_file} "M84 " ^ global.mmu_extruder_axis

;G91               ; relative positioning
M98 P"mmu/lib/execute-tmp.g"
;G90               ; absolute positioning
M98 P"mmu/lib/disengage.g"
M584 P{#move.axes - 2} ; hide MMU axes
