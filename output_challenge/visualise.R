library(tidyverse)
library(ve.utils)

# load example run
out <- load_result("output_challenge/ve_example/out")
var_names <- names(out$var)
var_names[str_detect(var_names, "soil")]

# Visualising temporal trends in output as median across grids


# soil carbon
var_names_soil_c_pool <- var_names[str_detect(var_names, "soil_c_pool_")]
soil_c_pool <- lapply(var_names_soil_c_pool, \(x) get_var(out, x))
soil_c_pool_total <- apply(simplify2array(soil_c_pool), 1:2, sum)
soil_c_pool <- c(soil_c_pool, list(soil_c_pool_total))
soil_c_pool_median <- lapply(soil_c_pool, \(x) apply(x, 2, median))
names(soil_c_pool_median) <- c(var_names_soil_c_pool, "soil_c_pool_total")
soil_c_pool_median <-
  reshape2::melt(soil_c_pool_median) %>%
  rename(Pool = L1) %>%
  mutate(Pool = str_remove(Pool, "soil_c_pool_")) %>%
  group_by(Pool) %>%
  mutate(time = row_number())

ggplot(soil_c_pool_median) +
  geom_line(aes(time, value,
                colour = Pool,
                linetype = Pool),
            size = 1) +
  scale_y_sqrt() +
  scale_colour_viridis_d(option = "cividis") +
  labs(x = "Time step [month]",
       y = expression(paste("Soil C [kg ", m^{-3}, "]"))) +
  theme_bw() +
  theme(legend.key.width = unit(1, "cm"))
