M98 R1

if state.macroRestarted
  if !global.mmu_extruder_loaded
    if state.status == "processing"
      M291 P{"Filament not yet loaded: T" ^ global.mmu_selector_pos} R"Load Filament" S1 T0
      M98 R1
      M226
  M99

var sAxis = -1
var eAxis = -1

while (var.sAxis == -1 || var.eAxis == -1) && iterations < #move.axes
  if iterations >= #move.axes
    break
  if move.axes[iterations].letter == global.mmu_selector_axis
    set var.sAxis = iterations
  if move.axes[iterations].letter == global.mmu_extruder_axis
    set var.eAxis = iterations

if var.sAxis == -1 || var.eAxis == -1
  abort "Cannot find endstop axis: " ^ var.sAxis ^ " / " ^ var.eAxis

var gpTriggered = #sensors.gpIn > global.mmu_selector_trigger && sensors.gpIn[global.mmu_selector_trigger] != null && sensors.gpIn[global.mmu_selector_trigger].value != 0
var sAxisTriggered = sensors.endstops[var.sAxis] != null && !sensors.endstops[var.sAxis].triggered
var eAxisTriggered = sensors.endstops[var.eAxis] != null && !sensors.endstops[var.eAxis].triggered
if  var.gpTriggered || var.sAxisTriggered || var.eAxisTriggered
  var errmsg = "Filament not yet unloaded: T" ^ global.mmu_selector_pos
  echo var.errmsg
  if state.status == "processing"
    M291 P{var.errmsg} R"Load Filament" S1 T0
    M98 R1
    M226
  else
    abort "Selector/Filament endstop is is not triggered"
