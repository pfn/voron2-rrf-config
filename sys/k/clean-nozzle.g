if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  abort "Please home printer before cleaning the nozzle"

if heat.heaters[1].current < 190
  abort "Not cleaning a cold nozzle"

G1 Z5 F2400

M98 P"k/purge-bucket.g"

G0 E10 F150

M98 P"k/filament-ram.g"

G4 S2

M98 P"k/brush-nozzle.g" S0
M98 P"k/brush-nozzle.g" S1
G1 Z10 F2400
G1 Y300 F18000
