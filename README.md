
<!-- README.md is generated from README.Rmd. Please edit that file -->

# quantdepplot

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/quantdepplot)](https://CRAN.R-project.org/package=quantdepplot)
[![R-CMD-check](https://github.com/edwindj/quantdepplot/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/edwindj/quantdepplot/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

This package is in its early stages, not ready for production yet.

## Installation

You can install the development version of quantdepplot from
[GitHub](https://github.com/) with:

``` r
remotes::install_github("edwindj/quantdepplot")
```

## Example

``` r
library(quantdepplot)
#> Loading required package: ggplot2
## basic example code
```

A quantile dependence plot

``` r
quantile_dependence_plot(iris, "Sepal.Length", 25)
```

<img src="man/figures/README-percentile_iris-1.png" width="100%" />

vs

``` r
table_plot(iris, "Sepal.Length", 25)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r
quantile_dependence_plot(iris, "Petal.Width", 25)
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r
library(palmerpenguins)
quantile_dependence_plot(penguins[1:7], c("body_mass_g"), 25)
```

<img src="man/figures/README-percentile_plot_penguins-1.png" width="100%" />

``` r
table_plot(iris, "Sepal.Length", 75)
#> 'n' is larger then nrows/5 ('min_bin_size'), setting 'n' to: 30
```

<img src="man/figures/README-cars-1.png" width="100%" />

Or the well-known `diamonds` dataset

``` r
data("diamonds", package = "ggplot2")
table_plot(diamonds, "carat", ncols=4)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r
data("diamonds", package = "ggplot2")
quantile_dependence_plot(diamonds[1:6], "carat", ncols=3)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

``` r
dependence_plot(diamonds, "price")
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />
