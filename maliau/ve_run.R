library(ve.utils)

# run VE
# ve_run maliau/config --out maliau/out --logfile maliau/out/logfile.log --config core.debug.truncate_run_at_update=20
ve_run("maliau/config",
       "maliau/out",
       "maliau/out/logfile.log")
