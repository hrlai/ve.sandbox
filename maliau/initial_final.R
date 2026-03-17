# Compare final to initial states to find out which variables have changed a lot
# This should allow us to identify variables that need better initial values or
# parameter calibration

library(tidyverse)
library(ncdf4)
library(RcppTOML)
library(reticulate)

# load initial and final states
initial <- load_initial("maliau/out")
final   <- load_final("maliau/out")

# import the list of soil and litter variable names
soil_model <- import("virtual_ecosystem.models.soil.soil_model")
vars_soil <- unlist(soil_model$SoilModel$vars_updated)

litter_model <- import("virtual_ecosystem.models.litter.litter_model")
vars_litter <- unlist(litter_model$LitterModel$vars_updated)

vars <- c(vars_soil, vars_litter)
vars <- intersect(names(initial$var), vars)

# calculate difference between final and initial values
delta_rel <- vector("list", length(vars))
names(delta_rel) <- vars
for (i in seq_along(delta_rel)) {
  initial_val <- get_var(initial, vars[i])
  final_val <- get_var(final, vars[i])
  # delta_rel[[i]] <- (final_val - initial_val) / initial_val
  delta_rel[[i]] <- log(final_val / initial_val)
  # delta_rel[[i]] <- (final_val - initial_val) / max(c(final_val, initial_val))
}
delta_rel <-
  bind_cols(delta_rel) |>
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "value") |>
  mutate(variable = fct_reorder(variable, value, .fun = median))

# plot
ggplot(delta_rel) +
  geom_boxplot(aes(variable, value)) +
  coord_flip()
