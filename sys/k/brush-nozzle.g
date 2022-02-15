G90
if !exists(param.S) || param.S == 0
  G1 Y300 F18000 ; avoid hitting the probe dock
  G1 X60 F18000
  G1 Y308 F18000
  G1 Z2 F2400 ; Z2 to actually brush, anything much higher for testing

G1 X90 F5000
G1 X60 Y306 F5000
G1 X90 F5000
G1 X60 Y308 F5000