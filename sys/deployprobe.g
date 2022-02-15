if sensors.probes[0].value[0] == 1000
  M564 H1
  G90
  G1 X117.5 Y298 F18000
  G1 Y308
  G1 Y298
  M400
  if sensors.probes[0].value[0] == 1000
    abort "Probe attach failed"