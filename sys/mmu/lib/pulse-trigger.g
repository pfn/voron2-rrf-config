M98 P"mmu/lib/free-endstop.g"
; disassociate the pin first
M950 J{global.mmu_encoder_trigger} C"nil"
M591 D0 S0 P0
M581 T{global.mmu_encoder_trigger} P-1

M950 J{global.mmu_encoder_trigger} C{global.mmu_encoder_pin}
M581 T{global.mmu_encoder_trigger} P{global.mmu_encoder_trigger}

var triggerValue = sensors.gpIn[global.mmu_encoder_trigger].value != 0

M950 J{global.mmu_encoder_trigger} C"nil"
M581 T{global.mmu_encoder_trigger} P-1

var pinName = global.mmu_encoder_pin
if var.triggerValue
  set var.pinName = "!" ^ var.pinName

echo >{global.mmu_tmp_file} "M574 S1 " ^ global.mmu_extruder_axis ^ "2" ^ " P""" ^ var.pinName ^ """"

M98 P"mmu/lib/execute-tmp.g"
