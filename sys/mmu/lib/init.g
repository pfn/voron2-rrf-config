M98 P"mmu/lib/globals.g"
M98 P"mmu/settings.g"
M98 P{global.mmu_selector_file}
M950 S{global.mmu_servo_num} C{global.mmu_servo_pin}
echo >{global.mmu_tmp_file} "M906 " ^ global.mmu_extruder_axis ^ global.mmu_extruder_current ^ " " ^ global.mmu_selector_axis ^ global.mmu_selector_current
echo >>{global.mmu_tmp_file} "M350 " ^ global.mmu_extruder_axis ^ global.mmu_extruder_microsteps ^ " " ^ global.mmu_selector_axis ^ global.mmu_selector_microsteps
echo >>{global.mmu_tmp_file} "M92 " ^ global.mmu_extruder_axis ^ global.mmu_extruder_steps ^ " " ^ global.mmu_selector_axis ^ global.mmu_selector_steps
echo >>{global.mmu_tmp_file} "M201 " ^ global.mmu_extruder_axis ^ global.mmu_extruder_accel ^ " " ^ global.mmu_selector_axis ^ global.mmu_selector_accel
echo >>{global.mmu_tmp_file} "M203 " ^ global.mmu_extruder_axis ^ 24000 ^ " " ^ global.mmu_selector_axis ^ 24000
echo >>{global.mmu_tmp_file} "M208 S1 " ^ global.mmu_selector_axis ^ global.mmu_selector_axis_min ^ " " ^ global.mmu_extruder_axis ^ "-9999"
echo >>{global.mmu_tmp_file} "M208 S0 " ^ global.mmu_selector_axis ^ global.mmu_selector_axis_max ^ " " ^ global.mmu_extruder_axis ^ "9999"
M98 P"mmu/lib/execute-tmp.g"
M591 D0 S0 P0
M950 J{global.mmu_encoder_trigger} C"nil"
M98 P"mmu/lib/filament-sensing.g"
M98 P"mmu/lib/filament-runout.g"
