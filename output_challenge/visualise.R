library(tidyverse)
library(ve.utils)

# load example run
out <- load_result("output_challenge/ve_example/out")
var_names <- names(out$var)
var_names[str_detect(var_names, "soil")]
var_names[str_detect(var_names, "litter")]

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
ggsave(
  "output_challenge/fig/soil_c_pool.png",
  width = 8,
  height = 4,
  units = "in",
  dpi = 300
)

# soil nitrogen
var_names_soil_n_pool <- var_names[str_detect(var_names, "soil_n_pool_")]
soil_n_pool <- lapply(var_names_soil_n_pool, \(x) get_var(out, x))
soil_n_pool_total <- apply(simplify2array(soil_n_pool), 1:2, sum)
soil_n_pool <- c(soil_n_pool, list(soil_n_pool_total))
soil_n_pool_median <- lapply(soil_n_pool, \(x) apply(x, 2, median))
names(soil_n_pool_median) <- c(var_names_soil_n_pool, "soil_n_pool_total")
soil_n_pool_median <-
  reshape2::melt(soil_n_pool_median) %>%
  rename(Pool = L1) %>%
  mutate(Pool = str_remove(Pool, "soil_n_pool_")) %>%
  group_by(Pool) %>%
  mutate(time = row_number())

ggplot(soil_n_pool_median) +
  geom_line(aes(time, value,
                colour = Pool,
                linetype = Pool),
            size = 1) +
  scale_y_sqrt() +
  scale_colour_viridis_d(option = "cividis") +
  labs(x = "Time step [month]",
       y = expression(paste("Soil N [kg ", m^{-3}, "]"))) +
  theme_bw() +
  theme(legend.key.width = unit(1, "cm"))
ggsave(
  "output_challenge/fig/soil_n_pool.png",
  width = 8,
  height = 4,
  units = "in",
  dpi = 300
)

# soil phosphorous
var_names_soil_p_pool <- var_names[str_detect(var_names, "soil_p_pool_")]
soil_p_pool <- lapply(var_names_soil_p_pool, \(x) get_var(out, x))
soil_p_pool_total <- apply(simplify2array(soil_p_pool), 1:2, sum)
soil_p_pool <- c(soil_p_pool, list(soil_p_pool_total))
soil_p_pool_median <- lapply(soil_p_pool, \(x) apply(x, 2, median))
names(soil_p_pool_median) <- c(var_names_soil_p_pool, "soil_p_pool_total")
soil_p_pool_median <-
  reshape2::melt(soil_p_pool_median) %>%
  rename(Pool = L1) %>%
  mutate(Pool = str_remove(Pool, "soil_p_pool_")) %>%
  group_by(Pool) %>%
  mutate(time = row_number())

ggplot(soil_p_pool_median) +
  geom_line(aes(time, value,
                colour = Pool,
                linetype = Pool),
            size = 1) +
  scale_y_sqrt() +
  scale_colour_viridis_d(option = "cividis") +
  labs(x = "Time step [month]",
       y = expression(paste("Soil P [kg ", m^{-3}, "]"))) +
  theme_bw() +
  theme(legend.key.width = unit(1, "cm"))
ggsave(
  "output_challenge/fig/soil_p_pool.png",
  width = 8,
  height = 4,
  units = "in",
  dpi = 300
)

# soil enzyme
var_names_soil_enzyme <- var_names[str_detect(var_names, "soil_enzyme_")]
soil_enzyme <- lapply(var_names_soil_enzyme, \(x) get_var(out, x))
soil_enzyme_total <- apply(simplify2array(soil_enzyme), 1:2, sum)
soil_enzyme <- c(soil_enzyme, list(soil_enzyme_total))
soil_enzyme_median <- lapply(soil_enzyme, \(x) apply(x, 2, median))
names(soil_enzyme_median) <- c(var_names_soil_enzyme, "soil_enzyme_total")
soil_enzyme_median <-
  reshape2::melt(soil_enzyme_median) %>%
  rename(Pool = L1) %>%
  mutate(Pool = str_remove(Pool, "soil_enzyme_")) %>%
  group_by(Pool) %>%
  mutate(time = row_number())

ggplot(soil_enzyme_median) +
  geom_line(aes(time, value,
                colour = Pool,
                linetype = Pool),
            size = 1) +
  scale_y_sqrt() +
  scale_colour_viridis_d(option = "cividis") +
  labs(x = "Time step [month]",
       y = expression(paste("Soil enzyme [kg C ", m^{-3}, "]"))) +
  theme_bw() +
  theme(legend.key.width = unit(1, "cm"))
ggsave(
  "output_challenge/fig/soil_enzyme.png",
  width = 8,
  height = 4,
  units = "in",
  dpi = 300
)

# soil abiotic
var_names_soil_abiotic <-
  c("soil_temperature", "soil_moisture", "soil_evaporation")
soil_abiotic <- lapply(var_names_soil_abiotic, \(x) get_var(out, x))
# get soil layer 13
soil_abiotic[[1]] <- soil_abiotic[[1]][, 13, ]
soil_abiotic[[2]] <- soil_abiotic[[2]][, 13, ]
soil_abiotic_median <- lapply(soil_abiotic, \(x) apply(x, 2, median))
names(soil_abiotic_median) <- var_names_soil_abiotic
soil_abiotic_median <-
  reshape2::melt(soil_abiotic_median) %>%
  rename(Variable = L1) %>%
  mutate(Variable = str_remove(Variable, "soil_")) %>%
  group_by(Variable) %>%
  mutate(time = row_number())

ggplot(soil_abiotic_median) +
  facet_wrap(~ Variable,
             scales = "free_y") +
  geom_line(aes(time, value),
            size = 1) +
  labs(x = "Time step [month]") +
  theme_bw()
ggsave(
  "output_challenge/fig/soil_abiotic.png",
  width = 8,
  height = 4,
  units = "in",
  dpi = 300
)

# litter pools
var_names_litter_pool <- var_names[str_detect(var_names, "litter_pool_")]
litter_pool <- lapply(var_names_litter_pool, \(x) get_var(out, x))
litter_pool_total <- apply(simplify2array(litter_pool), 1:2, sum)
litter_pool <- c(litter_pool, list(litter_pool_total))
litter_pool_median <- lapply(litter_pool, \(x) apply(x, 2, median))
names(litter_pool_median) <- c(var_names_litter_pool, "litter_pool_total")
litter_pool_median <-
  reshape2::melt(litter_pool_median) %>%
  rename(Pool = L1) %>%
  mutate(Pool = str_remove(Pool, "litter_pool_")) %>%
  group_by(Pool) %>%
  mutate(time = row_number())

ggplot(litter_pool_median) +
  geom_line(aes(time, value,
                colour = Pool,
                linetype = Pool),
            linewidth = 1) +
  scale_y_sqrt() +
  scale_colour_viridis_d(option = "cividis") +
  labs(x = "Time step [month]",
       y = expression(paste("Litter [kg C ", m^{-2}, "]"))) +
  theme_bw() +
  theme(legend.key.width = unit(1, "cm"))
ggsave(
  "output_challenge/fig/litter_pool.png",
  width = 8,
  height = 4,
  units = "in",
  dpi = 300
)

# litter mineralisation
var_names_litter_mineralisation <- var_names[str_detect(var_names, "_mineralisation_")]
litter_mineralisation <- lapply(var_names_litter_mineralisation, \(x) get_var(out, x))
litter_mineralisation_median <- lapply(litter_mineralisation, \(x) apply(x, 2, median))
names(litter_mineralisation_median) <- var_names_litter_mineralisation
litter_mineralisation_median <-
  reshape2::melt(litter_mineralisation_median) %>%
  rename(Pool = L1) %>%
  mutate(Pool = str_remove(Pool, "litter_"),
         Pool = str_remove(Pool, "_mineralisation_rate")) %>%
  group_by(Pool) %>%
  mutate(time = row_number())

ggplot(litter_mineralisation_median) +
  geom_line(aes(time, value,
                colour = Pool,
                linetype = Pool),
            linewidth = 1) +
  scale_y_sqrt() +
  scale_colour_viridis_d(option = "cividis") +
  labs(x = "Time step [month]",
       y = expression(paste("Litter mineralisation [kg ", m^{-3}, day^{-1}, "]"))) +
  theme_bw() +
  theme(legend.key.width = unit(1, "cm"))
ggsave(
  "output_challenge/fig/soil_c_pool.png",
  width = 8,
  height = 4,
  units = "in",
  dpi = 300
)
