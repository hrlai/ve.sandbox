library(ve.utils)

# run VE
# ve_run single_grid/config_single_grid --out single_grid/out --logfile single_grid/out/logfile.log
ve_run("single_grid/config",
       "single_grid/out",
       "single_grid/out/logfile.log")





# read results
results <- load_result("single_grid/out")

# names(results$var)

soil_cnp_pool_maom <- get_var(results, "soil_cnp_pool_maom")

matplot(t(soil_cnp_pool_maom),
     ylim = c(0, 1800),
     type = "l",
     ylab = "soil_c_pool_maom",
     xlab = "month")




library(tidyverse)

animal <- read_csv("single_grid/out/animal_cohort_data.csv")
