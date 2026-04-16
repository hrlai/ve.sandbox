library(ncdf4)


# function to extract a single grid from VE input data and then save the output
extract_one_grid <- function(nc, out) {
  # Load file
  nc_in <- nc_open(nc)

  # Identify dimensions and variables
  dims <- nc_in$dim
  vars <- names(nc_in$var)
  vars <- setdiff(vars, c("longitude_UTM50N", "latitude_UTM50N"))

  # define dimensions
  xdim <- ncdim_def("x", "m", 0)
  ydim <- ncdim_def("y", "m", 0)

  # define variables
  vardef <- vector("list", length(vars))
  for (i in seq_along(vardef)) {
    vardef[[i]] <-
      ncvar_def(
        vars[i],
        nc_in$var[[vars[i]]]$units,
        list(ydim, xdim)
      )
  }

  # extract data
  array_list <- vector("list", length(vars))
  for (i in seq_along(vardef)) {
    array_list[[i]] <-
      ncvar_get(
        nc_in,
        vars[i],
        start = c(1, 1),
        count = c(1, 1)
      )
  }

  # create netCDF file and put arrays
  ncout <-
    nc_create(out, vardef, force_v4 = TRUE)

  # put variables
  for (i in seq_along(vars)) {
    ncvar_put(ncout, vardef[[i]], array_list[[i]])
  }


  # Get a summary of the created file:
  ncout

  # close the file, writing data to disk
  nc_close(ncout)
}



# apply the extract grid function to Maliau input data
# elevation
extract_one_grid(
  nc = "single_grid/data/elevation_maliau_2010_2020_100m.nc",
  out = "single_grid/data_single_grid/elevation_maliau_2010_2020_100m.nc")
# soil
extract_one_grid(
  nc = "single_grid/data/soil_maliau.nc",
  out = "single_grid/data_single_grid/soil_maliau.nc")
# litter
extract_one_grid(
  nc = "single_grid/data/litter_maliau.nc",
  out = "single_grid/data_single_grid/litter_maliau.nc")
