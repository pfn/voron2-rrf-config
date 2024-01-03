if !exists(param.C) || !exists(param.S) || !exists(param.I) || !exists(param.J) || !exists(param.D) || !exists(param.U)
  abort "Missing required arguments"

M950 J{param.I} C{param.C}
M591 D{param.D} S0 P0
M950 J{param.J} C{param.S}
;M950 P0 C"nil"
M581 T{param.U} P-1

var last_value = sensors.gpIn[param.I].value
var change_count = 0
var bad_check_count = 0

if sensors.gpIn[param.I] == null
  M950 J{param.I} C"nil"
  abort "J0 is null"

while iterations < 5
  if sensors.gpIn[param.J].value != var.last_value
    set var.last_value = sensors.gpIn[param.J].value
    set var.change_count = var.change_count + 1
  if sensors.gpIn[param.I].value == sensors.gpIn[param.J].value
    set var.bad_check_count = var.bad_check_count + 1
    echo iterations ^ " bad check " ^ state.msUpTime ^ " -> " ^ sensors.gpIn[param.J].value
;  else
;    echo iterations ^ " check OK " ^ state.msUpTime
  G4 P25

M950 J{param.I} C"nil"

if var.change_count < 1 || var.bad_check_count > 0
  abort "Change and check counts not expected: changes=" ^ var.change_count ^ " bad=" ^ var.bad_check_count