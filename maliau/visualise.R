library(ncdf4)

# read results
results <- load_result("maliau/out")

soil_c_pool_maom <- get_var(results, "soil_c_pool_maom")
soil_c_pool_pom <- get_var(results, "soil_c_pool_pom")
soil_c_pool_lmwc <- get_var(results, "soil_c_pool_lmwc")

par(mfrow = (c(1, 2)))
matplot(t(soil_c_pool_maom), type = "l")
matplot(t(soil_c_pool_pom), type = "l")
matplot(t(soil_c_pool_lmwc), type = "l")
