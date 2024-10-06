#' Create a qbin_barplot from a dataset
#'
#' Create qbin_barplot/table_plot from a dataset/frame. Shows the distribution
#' of variables for each quantile bin of `x`.
#'
#' The `table_plot` calls `qbin_barplot` with `ncols` set to `ncol(data)`
#' @param data A data.frame or data.table
#' @param x The variable that generates the quantile bins.
#' @param n The number of bins to use for binning the data
#' @param ncols The number of column to be used in the layout.
#' @param fill The color to use for the bars.
#' @param type The type of statistic to use for the bars.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/table_plot.R
#' @return A ggplot object
qbin_barplot <- function(
    data,
    x = NULL,
    n = 100,
    ncols=NULL,
    fill = "#2f4f4f",
    type = c("median", "mean"),
    ...
  ) {
  type <- match.arg(type)

  d <- qbin(
    data,
    x = x,
    n = n
  )

  x <- d$x

  pn <- lapply(d$num_cols, function(n){
    d <- d$data[[n]]
    plot_num_bar(d, n, fill = fill, type = type)
  })

  names(pn) <- d$num_cols

  pc <- lapply(d$cat_cols, function(n){
    plot_cat_stacked(d$data[[n]], n)
  })

  names(pc) <- d$cat_cols
  p <- c(pn, pc)[names(data)]

  # put x as the first column
  idx <- match(x, names(data))
  p <- c(p[idx], p[-idx])

  p <- set_palettes(p, d$cat_cols)

  p <- qbin_plot(p, x = x, ncols = ncols, y_scale_rm = TRUE)

  # p <- layout(p, ncol = ncols, x = x)
  p
}

