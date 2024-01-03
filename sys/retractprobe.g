if !exists(global.probe_block_detach)
  global probe_block_detach = false

if !global.probe_block_detach && sensors.probes[0].value[0] == 0
  M564 H1
  G90
  G1 X115.3 Y298 F18000
  G1 Y309
  G1 X150
  G1 Y298
  M400
  if sensors.probes[0].value[0] == 0
    abort "Probe detach failed"
