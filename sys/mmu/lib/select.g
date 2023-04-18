if global.mmu_selector_pos == -1 && (!exists(param.H) || param.H != 1)
  abort "Home selector first"

if !exists(param.S)
  abort "No Slot selected"

if !exists(param.H) || param.H != 1
  M98 P"mmu/lib/assert-empty.g"

if global.mmu_servo_engaged
  M98 P"mmu/lib/disengage.g"

M584 P{#move.axes} ; allow operating on MMU axes
var axis = -1

while var.axis == -1
  if iterations >= #move.axes
    break
  if move.axes[iterations].letter == global.mmu_selector_axis
    set var.axis = iterations

if var.axis == -1
  abort "Cannot find selector axis"

echo >{global.mmu_tmp_file} "var slot_position = 0"
echo >>{global.mmu_tmp_file} "if !exists(global.mmu_slot" ^ param.S ^ "_pos)"
echo >>{global.mmu_tmp_file} "  abort ""Invalid slot selected: " ^ param.S ^ """"
echo >>{global.mmu_tmp_file} "set var.slot_position = global.mmu_slot" ^ param.S ^ "_pos"
echo >>{global.mmu_tmp_file} "set global.mmu_selector_pos = " ^ param.S
echo >>{global.mmu_tmp_file} "G92 " ^ global.mmu_selector_axis ^ move.axes[var.axis].userPosition
echo >>{global.mmu_tmp_file} "G1 F18000 " ^ global.mmu_selector_axis ^ "{var.slot_position}"
echo >>{global.mmu_tmp_file} "M84 " ^ global.mmu_selector_axis

G90
M98 P"mmu/lib/execute-tmp.g"
M98 P"mmu/lib/save-selector-state.g"
M98 P"mmu/lib/filament-sensing.g"
M98 P"mmu/lib/filament-runout.g"
M584 P{#move.axes - 2} ; hide MMU axes
