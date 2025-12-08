install_example("./fruiting/")

ve_run("fruiting/ve_example/config",
       "fruiting/ve_example/out",
       "fruiting/ve_example/out/logfile.log")

results <- load_result("fruiting/ve_example/out")
