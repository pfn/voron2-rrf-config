M98 P"mmu/lib/assert-empty.g"
M98 P"mmu/lib/free-endstop.g"
M98 P"mmu/lib/disengage.g"
M584 P{#move.axes} ; allow operating on MMU axes
set global.mmu_extruder_loaded = false

var hominglimit = -global.mmu_selector_axis_max - 5
echo >{global.mmu_tmp_file} "M574 S1 " ^ global.mmu_selector_axis ^ "1" ^ " P""" ^ global.mmu_selector_endstop_pin ^ """"
echo >>{global.mmu_tmp_file} "G1 H1 F6000 " ^ global.mmu_selector_axis ^ var.hominglimit
echo >>{global.mmu_tmp_file} "M98 P""mmu/lib/assert-endstop.g"""
echo >>{global.mmu_tmp_file} "G1 F6000 " ^ global.mmu_selector_axis ^ "5"
echo >>{global.mmu_tmp_file} "G1 H1 F300 " ^ global.mmu_selector_axis ^ -10
echo >>{global.mmu_tmp_file} "M98 P""mmu/lib/assert-endstop.g"""
echo >>{global.mmu_tmp_file} "M574 " ^ global.mmu_selector_axis ^ 0

G91               ; relative positioning
M98 P"mmu/lib/execute-tmp.g"
G90               ; absolute positioning
M98 P"mmu/lib/select.g" S0 H1
M584 P{#move.axes - 2} ; hide MMU axes
