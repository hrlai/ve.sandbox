library(ve.utils)

# run VE
# ve_run maliau/config_dev --out maliau/out_dev --logfile maliau/out_dev/logfile.log --config core.debug.truncate_run_at_update=2
ve_run("maliau/config", "maliau/out", "maliau/out/logfile.log")
