library(tidyverse)
library(RNetCDF)


# Load file
nc_in <- open.nc("single_grid/data/soil_maliau.nc")
nc_in_dat <- read.nc(nc_in)

# Identify dimensions and variables
dims <- c("x", "y", "element")
vars <- setdiff(names(nc_in_dat), dims)

# create netCDF file and put arrays
ncout <-
  create.nc("single_grid/data_single_grid/soil_maliau.nc", format = "netcdf4")

# define dimensions
dim.def.nc(ncout, "x", 1)
dim.def.nc(ncout, "y", 1)
dim.def.nc(ncout, "element", 3)
var.def.nc(ncout, "x", "NC_FLOAT", "x")
var.def.nc(ncout, "y", "NC_FLOAT", "y")
var.def.nc(ncout, "element", "NC_STRING", "element")
att.put.nc(ncout, "x", "units", "NC_CHAR", "m")
att.put.nc(ncout, "y", "units", "NC_CHAR", "m")
var.put.nc(ncout, "x", 0)
var.put.nc(ncout, "y", 0)
var.put.nc(ncout, "element", c("C", "N", "P"))

# define variables and put variables from arrays to netCDF
for (i in vars) {
  if (str_detect(i, "_cnp_")) {
    var.def.nc(ncout, i, "NC_DOUBLE", rev(c("x", "y", "element")))
    var.put.nc(ncout, i, nc_in_dat[[i]][, 1, 1, drop = FALSE])
  } else {
    var.def.nc(ncout, i, "NC_DOUBLE", rev(c("x", "y")))
    var.put.nc(ncout, i, nc_in_dat[[i]][1, 1, drop = FALSE])
  }
}

close.nc(ncout)

# Repeat for litter
# Load file
nc_in <- open.nc("single_grid/data/litter_maliau.nc")
nc_in_dat <- read.nc(nc_in)

# Identify dimensions and variables
dims <- c("x", "y", "element")
vars <- setdiff(names(nc_in_dat), dims)

# create netCDF file and put arrays
ncout <-
  create.nc("single_grid/data_single_grid/litter_maliau.nc", format = "netcdf4")

# define dimensions
dim.def.nc(ncout, "x", 1)
dim.def.nc(ncout, "y", 1)
dim.def.nc(ncout, "element", 3)
var.def.nc(ncout, "x", "NC_FLOAT", "x")
var.def.nc(ncout, "y", "NC_FLOAT", "y")
var.def.nc(ncout, "element", "NC_STRING", "element")
att.put.nc(ncout, "x", "units", "NC_CHAR", "m")
att.put.nc(ncout, "y", "units", "NC_CHAR", "m")
var.put.nc(ncout, "x", 0)
var.put.nc(ncout, "y", 0)
var.put.nc(ncout, "element", c("C", "N", "P"))

# define variables and put variables from arrays to netCDF
for (i in vars) {
  if (str_detect(i, "_cnp")) {
    var.def.nc(ncout, i, "NC_DOUBLE", rev(c("x", "y", "element")))
    var.put.nc(ncout, i, nc_in_dat[[i]][, 1, 1, drop = FALSE])
  } else {
    var.def.nc(ncout, i, "NC_DOUBLE", rev(c("x", "y")))
    var.put.nc(ncout, i, nc_in_dat[[i]][1, 1, drop = FALSE])
  }
}

close.nc(ncout)
