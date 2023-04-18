; disassociate the pin first
M950 J{global.mmu_selector_trigger} C"nil"
M581 T{global.mmu_selector_trigger} P-1

echo >{global.mmu_tmp_file} "M574 " ^ global.mmu_selector_axis ^ 0
echo >>{global.mmu_tmp_file} "M574 " ^ global.mmu_extruder_axis ^ 0

M98 P"mmu/lib/execute-tmp.g"
M30 {"/sys/" ^ "trigger" ^ global.mmu_selector_trigger ^ ".g"}
