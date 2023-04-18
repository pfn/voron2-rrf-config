M98 P"mmu/lib/free-endstop.g"

M950 J{global.mmu_selector_trigger} C{"!" ^ global.mmu_selector_endstop_pin}
M581 T{global.mmu_selector_trigger} P{global.mmu_selector_trigger}

echo >{"trigger" ^ global.mmu_selector_trigger ^ ".g"} "if state.status == ""processing"""
echo >>{"trigger" ^ global.mmu_selector_trigger ^ ".g"} "  M291 P""Selector sensor triggered"" R""Pause"" T5 S1"
echo >>{"trigger" ^ global.mmu_selector_trigger ^ ".g"} "  M25"
echo >>{"trigger" ^ global.mmu_selector_trigger ^ ".g"} "else"
echo >>{"trigger" ^ global.mmu_selector_trigger ^ ".g"} "  echo ""Selector sensor triggered"""
