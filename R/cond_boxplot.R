#' Conditional quantile boxplot
#'
#' [cond_boxplot()] conditions all variables on `x` by quantile binning and
#' shows the boxplots for the other variables for each value of qbinned `x`.
#'
#' `cond_boxplot` is the same function as [funq_plot()] but with different defaults,
#' namely `connect = FALSE` and `auto_fill = FALSE`.
#' `funq_plot` highlights the functional relationship between
#' x and the y-variables, by connecting the medians of the quantile bins.
#'
#' [qbin_boxplot()] shows the boxplots of the quantile bins on a quantile scale.
#'
#' @export
#' @example example/cond_boxplot.R
#' @family conditional quantile plotting functions
#' @inheritParams funq_plot
#' @return A `list` of ggplot objects.
cond_boxplot <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = NULL,
    color = "#002f2f", #"darkblue",
    fill = "#2f4f4f", #"#555555",
    auto_fill = FALSE,
    ncols = NULL,
    xmarker = NULL,
    qmarker = NULL,
    show_bins = FALSE,
    xlim = NULL,
    connect = FALSE,
    ...){

  funq_plot(
    data,
    x = x,
    n = n,
    min_bin_size = min_bin_size,
    color = color,
    fill = fill,
    auto_fill = auto_fill,
    ncols = ncols,
    xmarker = xmarker,
    qmarker = qmarker,
    show_bins = show_bins,
    xlim = xlim,
    connect = connect,
    ...)
}
