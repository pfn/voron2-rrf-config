M98 P{global.mmu_tmp_file}

if fileexists("/sys/" ^ global.mmu_tmp_file)
  M30 {"/sys/" ^ global.mmu_tmp_file}
