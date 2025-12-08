library(tidyverse)
library(reticulate)
library(ve.utils)

# install_example("./")

# run VE based on the example data
# but run time has been increased to 10 years
# the ve_example/config/ve_run.toml had been modified
# also the time object in generation_scripts/common.py
# then the data files are updated by re-running the generation scripts
# NB: I updated the relative paths in the generation scripts because I'm
# sourcing them from this R script
use_python("C:/Users/hrl23/.pyenv/pyenv-win/versions/3.12.0")
gen_files <- list.files(
  "ve_example/generation_scripts",
  pattern = "\\.py$",
  full.names = TRUE
)
sapply(gen_files, source_python, convert = FALSE)

# (re)run VE
ve_run("mwe/ve_example/config",
       "mwe/ve_example/out",
       "mwe/ve_example/out/logfile.log")

# read results
results <- load_result("ve_example/out")

# names(results$var)

subsurface_runoff_routed_plus_local <- get_var(results, "subsurface_runoff_routed_plus_local")
matplot(t(subsurface_runoff_routed_plus_local), type = "l", ylab = "subsurface_runoff_routed_plus_local", xlab = "month")
image(matrix(subsurface_runoff_routed_plus_local[, 48], 9, 9))

river_discharge_rate <- get_var(results, "river_discharge_rate")
matplot(t(river_discharge_rate), type = "l", ylab = "river_discharge_rate", xlab = "month")

precipitation_surface <- get_var(results, "precipitation_surface")
matplot(t(precipitation_surface), type = "l")

air_temperature <- get_var(results, "air_temperature")
matplot(t(air_temperature[, 1, ]), type = "l")
matplot(t(air_temperature[, 12, ]), type = "l")

soil_temperature <- get_var(results, "soil_temperature")
matplot(t(soil_temperature[ , 13, ]), type = "l")

soil_evaporation <- get_var(results, "soil_evaporation")
matplot(t(soil_evaporation), type = "l")

soil_c_pool_maom <- get_var(results, "soil_c_pool_maom")
soil_c_pool_lmwc <- get_var(results, "soil_c_pool_lmwc")
soil_c_pool_pom <- get_var(results, "soil_c_pool_pom")
matplot(t(soil_c_pool_maom), type = "l")
matplot(t(soil_c_pool_lmwc), type = "l")
matplot(t(soil_c_pool_pom), type = "l")

soil_moisture <- get_var(results, "soil_moisture")
matplot(t(soil_moisture[ , 13, ]), type = "l")
matplot(t(soil_moisture[ , 14, ]), type = "l")

# phase diagram
plot(soil_c_pool_maom[1, ], soil_c_pool_lmwc[1, ], type = "n", xlim = c(0, 12), ylim = c(0, 7))
for (i in seq_len(ncol(soil_c_pool_maom))) {
  lines(soil_c_pool_maom[i, ], soil_c_pool_lmwc[i, ])
}

plot(soil_c_pool_maom[1, ], soil_c_pool_pom[1, ], type = "n", xlim = c(0, 12), ylim = c(0, 3))
for (i in seq_len(ncol(soil_c_pool_maom))) {
  lines(soil_c_pool_maom[i, ], soil_c_pool_pom[i, ])
}

# close connection to the netCDF file
# ncdf4::nc_close(results)

