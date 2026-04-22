library(tidync)


cont <- tidync("out/maliau_2/all_continuous_data.nc")

var_focal <-
  cont |>
  activate("D1,D0") |>
  hyper_array()

apply(var_focal$total_runoff, 1, min)
apply(var_focal$river_discharge_rate, 1, min)
apply(var_focal$subsurface_flow, 1, min)
apply(var_focal$baseflow, 1, min)

png(
  "fig/troubleshoot_river_discharge.png",
  res = 300,
  width = 6,
  height = 2,
  units = "in"
)
par(mfrow = c(1, 3), mar = c(4, 4, 1, 1))
matplot(t(var_focal$subsurface_flow), type = "l", ylab = "subsurface_flow")
matplot(t(var_focal$baseflow), type = "l", ylab = "baseflow")
dev.off()
