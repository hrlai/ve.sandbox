library(tidyverse)
library(reticulate)
library(ve.utils)
library(ncdf4)

# install_example("./same_initial/")

# List all .nc files
nc_files <- list.files(path = "same_initial/ve_example/data/",
                       pattern = "\\.nc$",
                       full.names = TRUE)

# modify the grid values so they all take the mean value
for (files in nc_files) {
  ncin <- nc_open(files, write = TRUE)
  varnames <- names(ncin$var)
  # leave time untouched
  varnames <- varnames[varnames != "time"]
  for (var in varnames) {
    ncvar_put(ncin, var, ncvar_get(ncin, var) * 0 + mean(ncvar_get(ncin, var)))
  }
  nc_close(ncin)
}

# run VE
ve_run("same_initial/ve_example/config",
       "same_initial/ve_example/out",
       "same_initial/ve_example/out/logfile.log")

# read results
results <- load_result("same_initial/ve_example/out")

# check initial values
initials <- nc_open("same_initial/ve_example/out/initial_state.nc")

soil_c_pool_maom_init <- get_var(initials, "soil_c_pool_maom")
soil_c_pool_maom <- get_var(results, "soil_c_pool_maom")
soil_c_pool_maom <- cbind(soil_c_pool_maom_init, soil_c_pool_maom)

soil_c_pool_pom_init <- get_var(initials, "soil_c_pool_pom")
soil_c_pool_pom <- get_var(results, "soil_c_pool_pom")
soil_c_pool_pom <- cbind(soil_c_pool_pom_init, soil_c_pool_pom)

matplot(t(soil_c_pool_maom), type = "l")
matplot(t(soil_c_pool_pom), type = "l")
