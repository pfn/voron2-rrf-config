; configure drivers and toolboard
M569 P1.0 S0
M569 P1.1 S1
M584 U1.0
M584 V1.1 R0 S0 P3

set global.mmu_selector_axis = "U"
set global.mmu_extruder_axis = "V"

set global.mmu_bowden_length = 984
set global.mmu_extruder_gear_diameter = 7.3 ; bmg filament gear diameter
set global.mmu_extruder_steps = 425.42
set global.mmu_extruder_microsteps = 8
set global.mmu_extruder_accel = 300
set global.mmu_extruder_slow_speed = 2400
set global.mmu_extruder_fast_speed = 9000
set global.mmu_extruder_load_speed = 1200
set global.mmu_extruder_current = 800
set global.mmu_selector_current = 565
set global.mmu_extruder_park = 20
set global.mmu_selector_endstop_pin = "^io3.in"
set global.mmu_servo_num = 2
set global.mmu_servo_pin = "out6"
set global.mmu_encoder_pin = "io2.in"
