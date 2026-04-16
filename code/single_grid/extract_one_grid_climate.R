library(ncdf4)


# Load file
nc_in <- nc_open("single_grid/data/era5_maliau_2010_2020_100m.nc")

# Identify dimensions and variables
dims <- nc_in$dim
vars <- names(nc_in$var)[5:13]

# define dimensions
xdim <- ncdim_def("x", "m", 0)
ydim <- ncdim_def("y", "m", 0)
timedim <- ncdim_def("time_index", "", dims$time_index$vals)

# define variables
vardef <- vector("list", length(vars))
for (i in 1:(length(vardef)-1)) {
  vardef[[i]] <-
    ncvar_def(
      vars[i],
      nc_in$var[[vars[i]]]$units,
      list(timedim, ydim, xdim)
    )
}
vardef[[length(vars)]] <-
  ncvar_def(
    vars[length(vars)],
    nc_in$var[[vars[length(vars)]]]$units,
    list(ydim, xdim)
  )

# extract data
array_list <- vector("list", length(vars))
for (i in 1:(length(array_list)-1)) {
  array_list[[i]] <-
    ncvar_get(
      nc_in,
      vars[i],
      start = c(1, 1, 1),
      count = c(-1, 1, 1)
    )
}
array_list[[length(vars)]] <-
  ncvar_get(
    nc_in,
    vars[length(vars)],
    start = c(1, 1),
    count = c(1, 1)
  )

# create netCDF file and put arrays
ncout <-
  nc_create("single_grid/data_single_grid/era5_maliau_2010_2020_100m.nc",
            vardef, force_v4 = TRUE)

# put variables
for (i in seq_along(vars)) {
  ncvar_put(ncout, vardef[[i]], array_list[[i]])
}


# Get a summary of the created file:
ncout

# close the file, writing data to disk
nc_close(ncout)
