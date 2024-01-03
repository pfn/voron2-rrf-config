; output for controlling the sensor
; also used to detect direction when triggering on pulses
var mfm_config_pin = "0.io1.out"
; input for pulses and mfm data
var mfm_sense_pin = "124.io0.in"

; tool number e.g. 0 for T0
var mfm_tool_number = 0

; value used for M950 P and M950 J
var mfm_config_gpio_number = 1
var mfm_sense_gpio_number = 2

; RRF user triggers start at 2 and up for /sys/triggerN.g
var mfm_trigger_number = 2

if exists(param.S)
  M98 P{"/sys/mfm/" ^ param.S} S{var.mfm_sense_pin} C{var.mfm_config_pin} I{var.mfm_config_gpio_number} J{var.mfm_sense_gpio_number} D{var.mfm_tool_number} U{var.mfm_trigger_number}