M280 P{global.mmu_servo_num} S{global.mmu_servo_disengage}
G4 P200
M400
; servo off disabled due to truncated final pulse issue
; https://forum.duet3d.com/topic/32172/turning-off-servos-and-m42-interrupting-the-last-pulse
;M42 P{global.mmu_servo_num} S0
set global.mmu_servo_engaged = false
