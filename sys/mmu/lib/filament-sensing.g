M584 P{#move.axes - 2} ; hide MMU axes

;M591 D0 S0 P0
;M581 T{global.mmu_encoder_trigger} P-1
;M950 J{global.mmu_encoder_trigger} C"nil"
if fileexists("/sys/trigger" ^ global.mmu_encoder_trigger ^ ".g")
  M30 {"/sys/trigger" ^ global.mmu_encoder_trigger ^ ".g"}
;M591 D0 P7 C{global.mmu_encoder_pin} S1 R30:1000 E5 A0 L{global.mmu_pulse_distance}
M98 P"mfm/settings.g" S"filament_monitoring.g"