ve_run("mwe/ve_example/config",
       "mwe/ve_example/out",
       "mwe/ve_example/out/logfile.log")

# read results
results <- load_result("mwe/ve_example/out")

# plotting function
quick_plot <- function(var, ...) {
  matplot(t(var), type = "l", xlab = "Time step", ...)
}

# examine temperatures
air_temperature <- get_var(results, "air_temperature")
quick_plot(air_temperature[, 1, ], ylab = "Temperature (canopy)")
quick_plot(air_temperature[, 12, ], ylab = "Temperature (surface)")

soil_temperature <- get_var(results, "soil_temperature")
quick_plot(soil_temperature[ , 13, ], ylab = "Temperature (soil)")
