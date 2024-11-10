#' Quantile binned lineplot
#'
#' `qbin_lineplot` creates quantile binned boxplots from `data` using `x` as the binning
#' variable and connects the medians: it focuses on the change of median between qbins.
#'
#' The data is binned by the `x` and a boxplot is created for each bin.
#' The median of the subsequent boxplots are connected to highlight jumps in the
#' data. It hints at the dependecy of the variable on the binning variable.
#' @export
#' @example example/qbin_lineplot.R
#' @inheritParams qbin_boxplot
#' @family qbin plotting functions
#' @return A `list` of ggplot objects.
qbin_lineplot <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = 5,
    ncols=NULL,
    connect = TRUE,
    color = "#002f2f",
    fill = "#2f4f4f",
    auto_fill = FALSE,
    qmarker = NULL,
    xmarker = NULL,
    ...
){
  qbin_boxplot(
    data = data,
    x = x,
    n = n,
    min_bin_size = min_bin_size,
    ncols = ncols,
    connect = connect,
    color = color,
    fill = fill,
    auto_fill = auto_fill,
    qmarker = qmarker,
    xmarker = xmarker,
    ...
  )
}

