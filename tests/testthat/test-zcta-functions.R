input_data <- function() {
  data.frame(id = c('abc', 'def', 'ghi'),
             zcta = c('45229', '45056', '47012'))
}

test_that("add_race_data", {
  expect_equal(
    data.frame(
      stringsAsFactors = FALSE,
      id = c("abc", "def", "ghi"),
      zcta = c("45229", "45056", "47012"),
      total = c(13090, 27957, 9959),
      wnh = c(2223, 23682, 9845),
      bnh = c(10349, 1008, 25),
      racial_ice = c(-0.620779220779221, 0.811031226526451, 0.986042775379054),
      pct_wnh = c(17, 84.7, 98.9),
      pct_bnh = c(79.1, 3.6, 0.3)
    ),
    add_race_data(input_data())
    )
})

test_that("add_road_data", {
  expect_equal(
    data.frame(
      stringsAsFactors = FALSE,
      id = c("abc", "def", "ghi"),
      zcta = c("45229", "45056", "47012"),
      year = c("2018", "2018", "2018"),
      primary_road_length = c(3721.548, 0, 8783.797),
      primary_road_density = c(0.0005263361, 0, 2.049049e-05),
      secondary_road_length = c(8508.693, 97575.41, 69904.72),
      secondary_road_density = c(0.001203379, 0.0004956594, 0.0001630709)
    ),
    add_road_data(input_data())
  )
})

test_that("add_ejscreen_data", {
  expect_equal(
    data.frame(
      stringsAsFactors = FALSE,
      id = c("abc", "def", "ghi"),
      zcta = c("45229", "45056", "47012"),
      year = c("2018", "2018", "2018"),
      zcta_year = c("2010", "2010", "2010"),
      ej_year = c("2018", "2018", "2018"),
      traffix_proximity = c(537.774486612059,19.0453673760082,
                            24.4676492266925),
      ozone_conc = c(47.2313941313664,45.9943427640262,
                     44.9088528210117),
      pm_conc = c(12.1285397093921,11.4516891697872,
                  11.1824643249975),
      diesel_pm = c(2.01574825501059,
                    0.535991003564363,0.4159663308984),
      resp_hazard_ind = c(3.24789306953898,1.20723747201616,
                          0.993634440543535)
    ),
    add_ejscreen_data(input_data())
  )
})

test_that("add_landcover_data", {
  expect_equal(
    data.frame(
      stringsAsFactors = FALSE,
      id = c("abc", "def", "ghi"),
      zcta = c("45229", "45056", "47012"),
      year = c("2016", "2016", "2016"),
      zcta_year = c(2010, 2010, 2010),
      nlcd_year = c(2016, 2016, 2016),
      pct_green = c(64.1593483517882, 98.0502394522643, 96.3675478711398),
      pct_impervious = c(37.9350897289042, 2.32382959739243, 0.737480911529131),
      pct_treecanopy = c(17.7276314114802, 19.7857084327257, 30.1589828158011),
      treecanopy_year = as.double(c(NA, NA, NA))
    ),
    add_landcover_data(input_data())
  )
})

test_that("add_depindex_data", {
  expect_equal(
    data.frame(
      stringsAsFactors = FALSE,
      id = c("abc", "def", "ghi"),
      zcta = c("45229", "45056", "47012"),
      year = c("2018", "2018", "2018"),
      zcta_year = c("2010", "2010", "2010"),
      dep_year = c("2018", "2018", "2018"),
      fraction_assisted_income = c(0.325856261481025,0.0807499717684245,0.0819231608567711),
      fraction_high_school_edu = c(0.813923407625667,0.951599541998469,0.889407004616129),
      median_income = c(33559.0893494831,64890.3691083464,54018.0964781521),
      fraction_no_health_ins = c(0.133318596054678,0.064583160581612,0.0713147508901384),
      fraction_poverty = c(0.35420987662226,0.0856288235079211,0.0736882842816506),
      fraction_vacant_housing = c(0.269891800498152,0.109998968109712,0.0594838720694787),
      dep_index = c(0.536550395727124,0.285501996862475,0.307902948186302)
    ),
    add_depindex_data(input_data())
  )
})
