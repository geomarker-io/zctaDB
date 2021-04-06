
<!-- README.md is generated from README.Rmd. Please edit that file -->

# zctaDB

<!-- badges: start -->

[![R build
status](https://github.com/geomarker-io/zctaDB/workflows/R-CMD-check/badge.svg)](https://github.com/geomarker-io/zctaDB/actions)
[![R-CMD-check](https://github.com/geomarker-io/zctaDB/workflows/R-CMD-check/badge.svg)](https://github.com/geomarker-io/zctaDB/actions)
<!-- badges: end -->

The goal of zctaDB is to add ZIP code-level geomarkers to your data.

Available geomarkers include

| Category                          | Variables                                                                                                                                                                                                         | More information                                                                                                                                                                                                                                                                                                     |
|:----------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Population and racial composition | total population of ZCTA <br /> number and percentage of white non-Hispanic residents <br /> number and percentage of black non-Hispanic residents <br /> racial index of concentration at the extremes (ICE)     | [racial ICE published](https://doi.org/10.1111/ajt.16186)                                                                                                                                                                                                                                                            |
| Road proximity                    | length and density of primary roads <br /> length and density of secondary roads                                                                                                                                  | [DeGAUSS roads container](https://degauss.org/roads/)                                                                                                                                                                                                                                                                |
| EJ Screen                         | traffic proximity <br /> ozone concentration <br /> PM<sub>2.5</sub> concentration <br /> diesel PM concentration <br /> respiratory hazard index                                                                 | [EJ Screen](https://www.epa.gov/ejscreen/overview-environmental-indicators-ejscreen)                                                                                                                                                                                                                                 |
| Land Cover                        | percent impervious land <br /> percent green land <br /> percent tree canopy <br />                                                                                                                               | [MRLC](mrlc.gov)                                                                                                                                                                                                                                                                                                     |
| Community Deprivation             | fraction assisted income <br /> fraction high school education <br /> median household income <br /> fraction no health insurance <br /> fraction poverty <br /> fraction vacant housing <br /> deprivation index | [deprivation index](https://geomarker.io/dep_index/)                                                                                                                                                                                                                                                                 |
| NARR Cell Identifier              | narr cell                                                                                                                                                                                                         | \*Note that this is based on centroids of 2010 ZCTAs, but there are alternative ways to join these spatial datasets that may be better, such as all overlapping cells and corresponding area-based weights or using the the cell that most overlaps the ZCTA <br /> [addNarrData](https://geomarker.io/addNarrData/) |

For more information on these variables and how they are used in this
package, please view the documentation for the corresponding function
(e.g., `?zctaDB::add_road_data`).

## Installation

You can install zctaDB from from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("geomarker-io/zctaDB")
```

## Example

Each function in `zctaDB` adds variables to your data based on a column
named `zcta` that contains a 5-digit ZIP code.

``` r
library(zctaDB)
d <- data.frame(id = c('abc', 'def', 'ghi'),
            zcta = c('45229', '45056', '47012'))

add_road_data(data = d)
#> no column called 'year' -- assuming 2010 ZCTAs.
#>    id  zcta year primary_road_length primary_road_density secondary_road_length
#> 1 abc 45229 2018            3721.548         5.263361e-04              8508.693
#> 2 def 45056 2018               0.000         0.000000e+00             97575.410
#> 3 ghi 47012 2018            8783.797         2.049049e-05             69904.720
#>   secondary_road_density
#> 1           0.0012033790
#> 2           0.0004956594
#> 3           0.0001630709
```
