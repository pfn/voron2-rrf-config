set global.mmu_pulse_count = 0

; disassociate the pin first
M950 J{global.mmu_encoder_trigger} C"nil"
M591 D0 S0 P0
M581 T{global.mmu_encoder_trigger} P-1

M950 J{global.mmu_encoder_trigger} C{global.mmu_encoder_pin}
M581 T{global.mmu_encoder_trigger} P{global.mmu_encoder_trigger}
echo >{"trigger" ^ global.mmu_encoder_trigger ^ ".g"} "set global.mmu_pulse_count = global.mmu_pulse_count + 1"

M584 P{#move.axes} ; allow operating on MMU axes
