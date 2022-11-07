#' Get Racial Composition Data
#'
#' @description
#' adds numbers and percentages of white non-Hispanic
#' and black non-Hispanic residents from the 2018 ACS for given ZIP codes,
#' as well as a racial index of concentration at the extremes (ICE). Data is
#' available for 2010 ZCTAs in the contiguous United States.
#'
#' @param data data.frame or tibble with column called 'zcta' at minimum.
#'
#' @return the input data.frame with the following columns appended
#'
#'  \code{total} total population of ZCTA
#'
#'  \code{wnh} number of white non-Hispanic residents
#'
#'  \code{bnh} number of black non-Hispanic residents
#'
#'  \code{racial_ice} racial index of concentration at the extremes \code{(wnh-bnh)/total)}
#'
#'  \code{pct_wnh} percent white \code{wnh/totalx100}
#'
#'  \code{pct_bnh} percent black \code{bnh/totalx100}
#'
#' @examples
#' my_data <- data.frame(zcta = c('45229', '45056', '47012'))
#' add_race_data(data = my_data)
#' @export

add_race_data <- function(data) {
  if(!"zcta" %in% colnames(data)) {stop("input dataframe must have a column called 'zcta'")}
  if(is.numeric(data$zcta)) {data$zcta <- as.character(data$zcta)}
  data <- dplyr::left_join(data, race_data, by = 'zcta')
  return(data)
}

#' Get Length and Density of Roads
#'
#' @description
#' adds length (m) and density (m/km2) of primary and
#' secondary roads as defined by 2018 TIGER Line files. Data is available for
#' 2000 and 2010 ZCTAs.
#'
#' @param data data.frame or tibble with column called 'zcta' at minimum.
#' Optionally, another column called 'year', with possible values 2000 to
#' 2019. Years 2000 to 2009 will be matched to 2000 ZCTAs and years 2010 to
#' 2019 will be matched to 2010 ZCTAs. If no year is given, defaults to 2018.
#'
#' @return the input data.frame with the following columns appended
#'
#'  \code{primary_road_length} length (m) of primary roads in ZCTA
#'
#'  \code{primary_road_density} length(m) of primary roads in ZCTA divided by area of ZCTA (km2)
#'
#'  \code{secondary_road_length} length (m) of secondary roads in ZCTA
#'
#'  \code{secondary_road_density} length(m) of secondary roads in ZCTA divided by area of ZCTA (km2)
#'
#' @examples
#' my_data <- data.frame(zcta = c('45229', '45056', '47012'))
#' add_road_data(data = my_data)
#' @export

add_road_data <- function(data) {
  if(!"zcta" %in% colnames(data)) {stop("input dataframe must have a column called 'zcta'")}
  if(is.numeric(data$zcta)) {data$zcta <- as.character(data$zcta)}
  # if no column called year, use most recent -- give warning
  if(!"year" %in% colnames(data)) {
    message("no column called 'year' -- assuming 2010 ZCTAs.")
    data$year <- '2018'
  }
  if(is.numeric(data$year)) {data$year <- as.character(data$year)}

  data <- dplyr::left_join(data, road_data, by = c('zcta', 'year'))
  return(data)
}

#' Get EJ Screen Data
#'
#' @description
#' adds traffic proximity index, ozone concentration,
#' particulate matter (PM) concentration, PM from diesel traffic, and a
#' respiratory hazard index from the EPA EJ Screen database. Data is available for
#' 2000 and 2010 ZCTAs and for years 2015 to 2018.
#'
#' @param data data.frame or tibble with column called 'zcta' at minimum.
#' Optionally, another column called 'year', with possible values 2000 to
#' 2019. If no year is given, defaults to 2018.
#'
#' @return the input data.frame with the following columns appended
#'
#'  \code{zcta_year} the ZCTA boundary year matched to the input year (2000 or 2010)
#'
#'  \code{ej_year} the EJ Screen data year matched to the input year (2015 - 2018)
#'
#'  \code{traffic_proximity} count of vehicles (AADT, avg. annual daily traffic) at
#'  major roads within 500 meters, divided by distance in meters
#'
#'  \code{ozone_conc} ozone summer seasonal avg. of daily maximum 8-hour concentration
#'  in air in parts per billion
#'
#'  \code{pm_conc} PM2.5 levels in air, µg/m3 annual avg
#'
#'  \code{diesel_pm} diesel particulate matter level in air, ug/m3
#'
#'  \code{resp_hazard_ind} air toxics respiratory hazard index (ratio of exposure
#'  concentration to health-based reference concentration)
#'
#' @references https://www.epa.gov/ejscreen/overview-environmental-indicators-ejscreen
#'
#' @examples
#' my_data <- data.frame(zcta = c('45229', '45056', '47012'))
#' add_ejscreen_data(data = my_data)
#' @export

add_ejscreen_data <- function(data) {
  if(!"zcta" %in% colnames(data)) {stop("input dataframe must have a column called 'zcta'")}
  if(is.numeric(data$zcta)) {data$zcta <- as.character(data$zcta)}
  # if no column called year, use most recent -- give warning
  if(!"year" %in% colnames(data)) {
    message("no column called 'year' -- using 2018 data.")
    data$year <- '2018'
  }
  if(is.numeric(data$year)) {data$year <- as.character(data$year)}
  data <- dplyr::left_join(data, ejscreen_data, by = c('zcta', 'year'))
  return(data)
}

#' Get Land Cover Data
#'
#' @description
#' adds percentage of land classified as 'green',
#' percentage impervious land, and percentage of land covered by tree canopy
#' from the National Landcover Database. Data is available for
#' 2000 and 2010 ZCTAs and for years 2001, 2006, 2011, and 2016.
#'
#' @param data data.frame or tibble with column called 'zcta' at minimum.
#' Optionally, another column called 'year', with possible values 2000 to
#' 2019. If no year is given, defaults to 2016.
#'
#' @return the input data.frame with the following columns appended
#'
#'  \code{zcta_year} the ZCTA boundary year matched to the input year (2000 or 2010)
#'
#'  \code{nlcd_year} the National Landcover data year matched to the input year (2001, 2006, 2011, or 2016)
#'
#'  \code{treecanopy_year} if tree canopy data was not available in the nlcd_year, the
#'  year of the tree canopy data, otherwise NA
#'
#'  \code{pct_green} percentage of pixels within ZCTA classified as green (defined as all NLCD land cover
#'  codes except water, ice/snow, developed medium intensity, developed high intensity, and rock/sand/clay)
#'
#'  \code{pct_impervious} average percent impervious for pixels within ZCTA
#'
#'  \code{pct_treecanopy} average percent tree canopy for pixels within ZCTA
#'
#' @references https://www.mrlc.gov/
#'
#' @examples
#' my_data <- data.frame(zcta = c('45229', '45056', '47012'))
#' add_landcover_data(data = my_data)
#' @export

add_landcover_data <- function(data) {
  if(!"zcta" %in% colnames(data)) {stop("input dataframe must have a column called 'zcta'")}
  if(is.numeric(data$zcta)) {data$zcta <- as.character(data$zcta)}
  # if no column called year, use most recent -- give warning
  if(!"year" %in% colnames(data)) {
    message("no column called 'year' -- using 2016 data.")
    data$year <- '2016'
  }
  if(is.numeric(data$year)) {data$year <- as.character(data$year)}
  data <- dplyr::left_join(data, landcover_data, by = c('zcta', 'year'))
  return(data)
}

#' Get Community Deprivation Data
#'
#' @description
#' adds community deprivation index and
#' related variables from the American Community Survey (ACS). Data is
#' available for 2000 and 2010 ZCTAs and for years 2015 and 2018.
#'
#' @param data data.frame or tibble with column called 'zcta' at minimum.
#' Optionally, another column called 'year', with possible values 2000 to
#' 2019. If no year is given, defaults to 2018
#'
#' @return the input data.frame with the following columns appended
#'
#'  \code{zcta_year} the ZCTA boundary year matched to the input year (2000 or 2010)
#'
#'  \code{dep_year} the ACS data year matched to the input year (2015 or 2018)
#'
#'  \code{fraction_assisted_income} fraction of households receiving public assistance income
#'  or food stamps or SNAP in the past 12 months
#'
#'  \code{fraction_high_school_edu} fraction of population 25 and older with educational attainment
#'  of at least high school graduation (includes GED equivalency)
#'
#'  \code{median_income} median household income in the past 12 months in 2015 inflation-adjusted dollars
#'
#'  \code{fraction_no_health_ins} fraction of poulation with no health insurance coverage
#'
#'  \code{fraction_poverty} fraction of population with income in past 12 months below poverty level
#'
#'  \code{fraction_vacant_housing} fraction of houses that are vacant
#'
#'  \code{dep_index} a composite measure of the other 6 variables
#'
#' @references https://geomarker.io/dep_index/
#'
#' @examples
#' my_data <- data.frame(zcta = c('45229', '45056', '47012'))
#' add_depindex_data(data = my_data)
#' @export

add_depindex_data <- function(data) {
  if(!"zcta" %in% colnames(data)) {stop("input dataframe must have a column called 'zcta'")}
  if(is.numeric(data$zcta)) {data$zcta <- as.character(data$zcta)}
  # if no column called year, use most recent -- give warning
  if(!"year" %in% colnames(data)) {
    message("no column called 'year' -- using 2018 data.")
    data$year <- '2018'
  }
  if(is.numeric(data$year)) {data$year <- as.character(data$year)}

  data <- dplyr::left_join(data, dep_index, by = c('zcta', 'year'))
  return(data)
}

#' Get NARR Cell ID for ZCTA Centroid
#'
#' @description
#' adds NARR cell identifier based on ZCTA centroid for subsequent
#' use with the {addNarrData} package
#'
#' @param data data.frame or tibble with column called 'zcta' at minimum.
#'
#' @return the input data.frame with the following columns appended
#'
#'  \code{narr_cell} NARR cell indentifier corresponding to the
#'  NARR cell that intersects the ZCTA centroid
#'
#' @references https://geomarker.io/addNarrData/
#'
#' @examples
#' my_data <- data.frame(zcta = c('45229', '45056', '47012'))
#' add_narr_cell_zcta(data = my_data)
#' @export

add_narr_cell_zcta <- function(data) {
  if(!"zcta" %in% colnames(data)) {stop("input dataframe must have a column called 'zcta'")}
  if(is.numeric(data$zcta)) {data$zcta <- as.character(data$zcta)}
  data <- dplyr::left_join(data, narr_cell_data, by = c('zcta'))
  return(data)
}

#' Get Traffic Data
#'
#' @description
#' adds Average Annual Daily Traffic Density. AADT data
#' is from 2017 and corresponds to 2010 ZCTA vintages.
#'
#' @param data data.frame or tibble with column called 'zcta' at minimum.
#'
#' @return the input data.frame with the following columns appended
#'
#'  \code{moving_roads_density} density of roads with moving traffic
#'  (meters of road per square meter of area)
#'
#'  \code{stop_go_roads_density} density of roads with stop and go
#'  traffic (meters of road per square meter of area)
#'
#'  \code{moving_traffic_density} moving traffic density (vehicle-meters
#'  per square meter of area)
#'
#'  \code{stop_go_traffic_density} stop and go traffic density
#'  (vehicle-meters per square meter of area)
#'
#'  \code{moving_truck_density} moving truck traffic density
#'  (truck-meters per square meter of area)
#'
#'  \code{stop_go_truck_density} stop and go truck traffic
#'  density (truck-meters per square meter of area)
#'
#' @references https://degauss.org/aadt
#'
#' @examples
#' my_data <- data.frame(zcta = c('45229', '45056', '47012'))
#' add_aadt_data(data = my_data)
#' @export

add_aadt_data <- function(data) {
  if(!"zcta" %in% colnames(data)) {stop("input dataframe must have a column called 'zcta'")}
  if(is.numeric(data$zcta)) {data$zcta <- as.character(data$zcta)}

  data <- dplyr::left_join(data, aadt_data, by = c('zcta'))
  return(data)
}
