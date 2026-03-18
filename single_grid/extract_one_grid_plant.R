library(tidyverse)
library(RNetCDF)
library(ncdf4)


# Load file
nc_in <- nc_open("single_grid/data/plant_input_data_Maliau_50x50.nc")

# Identify dimensions and variables
dims <- nc_in$dim
vars <- names(nc_in$var)[1:4]

# create netCDF file and put arrays
ncout <-
  create.nc("single_grid/data_single_grid/plant_input_data_Maliau_50x50.nc",
            format = "netcdf4")


# define dimensions
dim.def.nc(ncout, "cell_id", 1)
dim.def.nc(ncout, "pft", length(dims$pft$vals))
dim.def.nc(ncout, "time_index", length(dims$time_index$vals))

# define variables
var.def.nc(ncout, "plant_pft_propagules", "NC_INT", c("pft", "cell_id"))
var.def.nc(ncout, "downward_shortwave_radiation", "NC_DOUBLE", c("time_index", "cell_id"))
var.def.nc(ncout, "subcanopy_vegetation_biomass", "NC_FLOAT", "cell_id")
var.def.nc(ncout, "subcanopy_seedbank_biomass", "NC_FLOAT", "cell_id")
var.def.nc(ncout, "cell_id", "NC_INT", "cell_id")
var.def.nc(ncout, "pft", "NC_STRING", "pft")
var.def.nc(ncout, "time_index", "NC_INT", "time_index")

# extract data
var.put.nc(ncout, "plant_pft_propagules", cbind(ncvar_get(
  nc_in,
  "plant_pft_propagules",
  start = c(1, 1),
  count = c(-1, 1)
)))
var.put.nc(ncout, "downward_shortwave_radiation", cbind(ncvar_get(
  nc_in,
  "downward_shortwave_radiation",
  start = c(1, 1),
  count = c(-1, 1)
)))
var.put.nc(ncout, "subcanopy_vegetation_biomass", (ncvar_get(
  nc_in,
  "subcanopy_vegetation_biomass",
  start = c(1),
  count = c(1)
)))
var.put.nc(ncout, "subcanopy_seedbank_biomass", (ncvar_get(
  nc_in,
  "subcanopy_seedbank_biomass",
  start = c(1),
  count = c(1)
)))
var.put.nc(ncout, "cell_id", 0)
var.put.nc(ncout, "pft", dims$pft$vals)
var.put.nc(ncout, "time_index", dims$time_index$vals)

# Sync data to file and close.
sync.nc(ncout)
close.nc(ncout)





# Now filter the plant cohort data...
plant_cohort_single_grid <-
  read_csv("single_grid/data/plant_cohort_data_Maliau_50x50.csv") |>
  filter(plant_cohorts_cell_id == 0)
write_csv(plant_cohort_single_grid,
          "single_grid/data_single_grid/plant_cohort_data_Maliau_50x50.csv")
