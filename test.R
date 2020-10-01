# test

library(tibble)
ex <- tibble(zcta = c('45229', '45056', '47012'),
             year = c(2015, 2001, 2019))

add_race_data(ex)
add_landcover_data(ex)
add_road_data(ex)
add_ejscreen_data(ex)
add_depindex_data(ex)
