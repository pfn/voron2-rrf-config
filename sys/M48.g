var samples = 10

var x = 100
var y = 100

if exists(param.X)
  set var.x = param.X
if exists(param.Y)
  set var.y = param.Y

G1 Z10 F6000
var probe = 0

if exists(param.K)
  set var.probe = param.K

var attach_probe = var.probe == 0

if var.probe == 1
  set var.x = 206
  set var.y = 307.7
  M402

if var.probe == 2
  ; probe switch body to endstop
  set var.x = 203.1
  set var.y = 284
  set var.probe = 1
  set var.attach_probe = true
  M401
  
M558 K{var.probe} A1

if var.attach_probe
  M401

G1 X{var.x} Y{var.y} F18000
G92 Z20
G30 K{var.probe} X{var.x} Y{var.y}

if var.attach_probe
  M402
while iterations < var.samples
  M400
  ;echo "Probe Sample " ^ {iterations + 1}
  if var.attach_probe
    M401
  if iterations < var.samples - 1
    G30 K{var.probe} P{iterations} X{var.x} Y{var.y} Z-9999
  else
    G30 K{var.probe} P{iterations} X{var.x} Y{var.y} Z-9999 S-1
  if var.attach_probe
    M402

G28 Z

M558 K{var.probe} A10