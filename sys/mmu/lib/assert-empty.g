M98 P"mmu/lib/check-endstop.g" A{global.mmu_selector_axis}
M98 P"mmu/lib/check-endstop.g" A{global.mmu_extruder_axis}

if #sensors.gpIn > global.mmu_selector_trigger && sensors.gpIn[global.mmu_selector_trigger] != null && sensors.gpIn[global.mmu_selector_trigger].value == 0
  abort "Filament is loaded into selector"

;if global.mmu_extruder_loaded || global.mmu_selector_pos == -1
;  M98 P"mmu/lib/engage.g"
;  M98 P"mmu/lib/pulse-counting.g"
;  var pulse_count = global.mmu_pulse_count
;  M98 P"mmu/lib/buzz.g"
;  if var.pulse_count != global.mmu_pulse_count
;    M98 P"mmu/lib/disengage.g"
;    abort "Filament already loaded, unload first"
;  set global.mmu_extruder_loaded = false
;  M98 P"mmu/lib/disengage.g"
