#' conditional quantile boxplot
#'
#' Create a conditional quantile boxplot, show the boxplots of the quantile bins, with
#' on the x-axis the values of the conditional variable.
#'
#' `conq_plot` is the same function as [funq_plot()] but with a different default,
#' namely `connect = FALSE`. `funq_plot` highlights the functional relationship between
#' x and the y-variables, but connecting the medians of the quantile bins.
#' [qbin_boxplot()] shows the boxplots of the quantile bins on a quantile scale.
#'
#' @export
#' @example example/conq_plot.R
#' @inheritParams funq_plot
conq_plot <- function(
    data,
    x = NULL,
    n = 100,
    color = "#002f2f", #"darkblue",
    fill = "#2f4f4f", #"#555555",
    auto_fill = FALSE,
    ncols = NULL,
    xmarker = NULL,
    qmarker = NULL,
    add_rug = FALSE,
    xlim = NULL,
    connect = FALSE,
    ...){

  funq_plot(
    data,
    x = x,
    n = n,
    color = color,
    fill = fill,
    auto_fill = auto_fill,
    ncols = ncols,
    xmarker = xmarker,
    qmarker = qmarker,
    add_rug = add_rug,
    xlim = xlim,
    connect = connect,
    ...)
}
