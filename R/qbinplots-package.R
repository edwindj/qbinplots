#' qbinplots
#'
#' This package creates plots using quantile binning.
#'
#' Quantile binning is an exploratory data analysis tool that helps to see
#' the distribution of the variables in a dataset as a function of the variable
#' that is binned.
#'
#' A data.frame is quantile binned on a variable `x` using [qbin()] and then
#' plotted with one of the available plot functions.
#'
#' `qbinplots` offers various types of plots:
#'
#' - `qbin_*` quantile binned plots that show the distribution of the variables in the quantile bins.
#' - `cond_*` conditional quantile plots that show the distribution of the variables conditional on the `x` variable.
#'
#' @section Quantile binned plots:
#'
#' - [qbin_lineplot()] highlights the change in median between qbins, shows the distribution within qbins.
#' - [qbin_barplot()] shows the size of medians or expected value of qbins.
#' - [qbin_boxplot()] shows the distribution within qbins.
#' - [qbin_heatmap()] shows the distribution within the qbins.
#'
#' @section Conditional (quantile binned) plots:
#' - [cond_boxplot()] shows the distribution of the variables conditional on the x variable.
#' - [cond_barplot()] shows the expected median/mean of the variables conditional on the x variable.
#' - [funq_plot()] shows a functional view of the data, plotting the median and
#' interquartile range of numerical variables and level frequency of the other
#' variables as a function of the `x` variable using quantile bins.
"_PACKAGE"


## usethis namespace: start
## usethis namespace: end
NULL
