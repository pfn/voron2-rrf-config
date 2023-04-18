echo >{global.mmu_tmp_file} "G92 " ^ global.mmu_extruder_axis ^ "0"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_slow_speed ^ " " ^ global.mmu_extruder_axis ^ "5"
echo >>{global.mmu_tmp_file} "M400"
echo >>{global.mmu_tmp_file} "G1 F" ^ global.mmu_extruder_slow_speed ^ " " ^ global.mmu_extruder_axis ^ "-5"
echo >>{global.mmu_tmp_file} "M400"
echo >>{global.mmu_tmp_file} "M84 " ^ global.mmu_extruder_axis


G91
M98 P"mmu/lib/execute-tmp.g"
G90
