; global declarations, some relatively sane defaults included
; value overrides should go in mmu/settings.g
if !exists(global.mmu_settings_loaded)
  ;
  ; general settings
  ;
  global mmu_bowden_length = 525
  global mmu_tool_number = 0
  ;
  ; selector axis settings
  ;
  global mmu_selector_axis = "U"
  global mmu_selector_endstop_pin = "xstop"
  global mmu_selector_current = 750
  global mmu_selector_steps = 80
  global mmu_selector_microsteps = 16
  global mmu_selector_accel = 2000
  global mmu_selector_axis_min = 0
  global mmu_selector_axis_max = 200
  ;
  ; filament drive settings
  ;
  global mmu_extruder_axis = "V"
  global mmu_extruder_current = 565
  global mmu_extruder_steps = 415
  global mmu_extruder_microsteps = 16
  global mmu_extruder_accel = 600
  global mmu_extruder_gear_diameter = 7.35
  ; calculated as gear bottom to stopping location
  ; this should be where the filament can be moved while cold
  global mmu_extruder_park = 40
  global mmu_extruder_retract_park = 35
  global mmu_extruder_load_speed = 300
  global mmu_extruder_slow_speed = 1200
  global mmu_extruder_fast_speed = 2400
  ;
  ; selector servo settings
  ;
  global mmu_servo_pin = "exp.heater3"
  global mmu_servo_num = 0
  global mmu_servo_disengage = 100
  global mmu_servo_engage = 0
  ;
  ; filament block positions, additional blocks can be added and removed
  ; additional definitions can go here or in settings.g
  ; removed blocks should be commented/deleted out of this file
  ;
  global mmu_slot0_pos = 1
  global mmu_slot1_pos = 18.3
  global mmu_slot2_pos = 35.6
  global mmu_slot3_pos = 52.9
  global mmu_slot4_pos = 70.1
  global mmu_slot5_pos = 87.4
  global mmu_slot6_pos = 104.7
  global mmu_slot7_pos = 122.0
  global mmu_slot8_pos = 139.3
  global mmu_slot9_pos = 156.6
  ;
  ; filament sensor settings
  ;
  global mmu_encoder_pin = "e0stop"
  global mmu_encoder_trigger = 2
  global mmu_selector_trigger = 3
  global mmu_pulse_distance = 1.415
  ;
  ; DO NOT EDIT
  ; non-configurable system state variables
  ;
  global mmu_pulse_count = 0
  global mmu_extruder_loaded = false
  global mmu_tmp_file = "mmu/lib/tmp.g"
  global mmu_selector_file = "mmu/lib/selector-state.g"
  global mmu_selector_pos = -1
  global mmu_servo_engaged = false
  global mmu_settings_loaded = true
