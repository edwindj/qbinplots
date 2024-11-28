#' Quantile binned bar plot
#'
#' [qbin_barplot()] shows the median or mean for each quantile bin, thereby focusing on
#' the expected value per [qbin()].
#' For a conditional plot, see [cond_barplot()].
#'
#' The `table_plot` is a specific form of `qbin_barplot`
#' with `ncols` set to `ncol(data)`.
#' @param ncols The number of column to be used in the layout.
#' @param fill The color to use for the bars.
#' @param type The type of statistic to use for the bars.
#' @param ... Additional arguments to pass to the plot functions
#' @inheritParams qbin
#' @export
#' @example example/table_plot.R
#' @family qbin plotting functions
#' @return A `list` of ggplot objects.
qbin_barplot <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = 5,
    ncols=NULL,
    fill = "#2f4f4f",
    type = c("median", "mean"),
    ...
  ) {
  type <- match.arg(type)

  d <- qbin(
    data,
    x = x,
    n = n,
    min_bin_size = min_bin_size
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

  p <- qbin_plot(p, x = x, ncols = ncols)

  # p <- layout(p, ncol = ncols, x = x)
  p
}

