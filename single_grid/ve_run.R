library(ve.utils)

# run VE
# ve_run single_grid/config_single_grid --out single_grid/out --logfile single_grid/out/logfile.log
ve_run("single_grid/config",
       "single_grid/out",
       "single_grid/out/logfile.log")
