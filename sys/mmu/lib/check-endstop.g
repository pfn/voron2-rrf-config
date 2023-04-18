var axis = -1

if !exists(param.A)
  abort "(A)xis not specified for check-endstop.g"


while var.axis == -1 && iterations < #move.axes
  if iterations >= #move.axes
    break
  if move.axes[iterations].letter == param.A
    set var.axis = iterations

if var.axis == -1
  abort "Cannot find endstop axis: " ^ param.A

if sensors.endstops[var.axis] != null && sensors.endstops[var.axis].triggered
  abort "Selector/Filament endstop is already triggered"
