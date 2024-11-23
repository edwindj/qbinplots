#' Conditional quantile barplot
#'
#' [cond_barplot()] conditions all variables on `x` by quantile binning and
#' shows the median or mean of the other variables for each `x`.
#'
#' @param ncols The number of column to be used in the layout.
#' @param fill The color to use for the bars.
#' @param auto_fill If `TRUE`, use a different color for each category
#' @param type The type of statistic to use for the bars.
#' @param show_bins If `TRUE`, show the bins on the x-axis.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/cond_barplot.R
#' @inheritParams qbin
#' @family conditional quantile plotting functions
#' @return A `list` of ggplot objects.
cond_barplot <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = 5,
    ncols=NULL,
    fill = "#2f4f4f",
    auto_fill = FALSE,
    show_bins = FALSE,
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
  x_data <- d$data[[x]]

  pn <- lapply(d$num_cols, function(y){
    plot_cond_bar(
      x_data = x_data,
      y_data = d$data[[y]],
      x_name= d$x,
      y_name = y,
      fill = fill,
      type = type,
      show_bins = show_bins
    )
  })

  names(pn) <- d$num_cols

  pc <- lapply(d$cat_cols, function(y_name){
    y_data <- d$data[[y_name]]
    plot_cat_area(
      x_data,
      y_data = y_data,
      x_name = x,
      y_name = y_name,
      fill = fill,
      auto_fill = auto_fill
    )
  })

  names(pc) <- d$cat_cols
  p <- c(pn, pc)[names(data)]

  # remove x
  idx <- match(x, names(data))
  p <- p[-idx]

  p <- set_palettes(p, d$cat_cols)

  p <- cond_plot(p, x = x, ncols = ncols)

  p
}

