M561
G90
G1 Z10 F2400
M401

while iterations < 10
  if iterations == 0
    M558 K0 H8 F1000
  if iterations == 1
    M558 K0 H4 F500
  if iterations == 2
    M558 K0 H2 F120
  G30 K0 P0 X30  Y30  Z-99999
  G30 K0 P1 X30  Y270 Z-99999
  G30 K0 P2 X270 Y270 Z-99999
  G30 K0 P3 X270 Y30  Z-99999 S4
  echo "Deviation: ", move.calibration.initial.deviation, " iteration: ", iterations + 1
  if move.calibration.initial.deviation < 0.006
    break
if move.calibration.initial.deviation > 0.006
  echo "Excessive deviation"
  abort
M558 K0 H2 F1200:180
G28 Z