library(terra)

# function to extract a single grid from VE input data and then save the output
extract_one_grid <- function(nc, target_lon = 0, target_lat = 0, out, ...) {
  # Load all variables as a SpatRaster
  r <- rast(nc)

  # convert to a small clipping box
  width_clip <- res(r) / 2
  ext_clip <- ext(rep(c(target_lon, target_lat), each = 2) + c(-1, 1, -1, 1) * rep(width_clip, each = 2))

  # Crop all layers at that single cell
  r_cell <- crop(r, ext_clip)

  # Write to a new NetCDF
  writeCDF(r_cell, out, ...)
}

# apply the extract grid function to Maliau input data
# elevation
extract_one_grid(
  nc = "single_grid/data/elevation_maliau_2010_2020_100m.nc",
  out = "single_grid/data_single_grid/elevation_maliau_2010_2020_100m.nc",
  overwrite = TRUE)
# climate
extract_one_grid(
  nc = "single_grid/data/era5_maliau_2010_2020_100m.nc",
  out = "single_grid/data_single_grid/era5_maliau_2010_2020_100m.nc",
  overwrite = TRUE)
# plant
extract_one_grid(
  nc = "single_grid/data/plant_input_data_Maliau_50x50.nc",
  out = "single_grid/data_single_grid/plant_input_data_Maliau_50x50.nc",
  overwrite = TRUE)
# soil
extract_one_grid(
  nc = "single_grid/data/soil_maliau.nc",
  out = "single_grid/data_single_grid/soil_maliau.nc",
  overwrite = TRUE)
# litter
extract_one_grid(
  nc = "single_grid/data/litter_maliau.nc",
  out = "single_grid/data_single_grid/litter_maliau.nc",
  overwrite = TRUE)
