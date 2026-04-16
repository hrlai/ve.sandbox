library(ve.utils)

# run VE
# ve_run config/maliau_2 --out out/maliau_2 --logfile out/maliau_2/logfile.log

ve_run("maliau/config", "maliau/out", "maliau/out/logfile.log")
