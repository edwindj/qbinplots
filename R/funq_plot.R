#' Plot variables as a function of another variable
#'
#' Plot the median and interquartile range of numerical variables and frequency of
#' other variables as a function the `x` variable.
#'
#' The statistics are derived by binning the `x` variable into `n` bins or quantiles and
#' calculating the statistics for each bin, hence the name `funq_plot`.
#' @param data A data.frame or data.table
#' @param x `character` name of variable that should be plotted in the x-axis.
#' @param n The number of bins to use for binning the data
#' @param ncols The number of column to be used in the layout
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/funq_plot.R
#' @return A ggplot object with the plots
funq_plot <- function(
    data,
    x = NULL,
    n = 100,
    color = "#555555",
    color_cat = FALSE,
    ncols = NULL,
    ...
  ) {
  d <- preprocess(
    data,
    sort_variable = x,
    n = n
  )

  sort_variable <- d$sort_variable

  num_cols <- d$num_cols
  m <- match(sort_variable, num_cols)
  # remove sort_column
  num_cols <- num_cols[-m]

  x_data <- d$data[[sort_variable]]

  pn <- lapply(num_cols, function(y_name){
    y_data <- d$data[[y_name]]
#    plot_num_line(
    plot_num_pdp_hinge(
      x_data = x_data,
      y_data = y_data,
      x_name=sort_variable,
      y_name = y_name,
      color = color
    )
  })
  names(pn) <- num_cols

  pc <- lapply(d$cat_cols, function(y_name){
    y_data <- d$data[[y_name]]
    plot_cat_line(
      x_data,
      y_data = y_data,
      x_name = sort_variable,
      y_name = y_name,
      color = color,
      color_cat = color_cat
    )
  })
  names(pc) <- d$cat_cols

  nms <- names(data)
  idx <- match(sort_variable, nms)
  nms <- nms[-idx]

  p <- c(pn, pc)[nms]
  # qd_plot(p)

  if(color_cat){
    p <- set_palettes(p, d$cat_cols)
  }

  p <- Reduce(`+`, p)

  if (!is.null(ncols)) {
    p <- p + plot_layout(ncol = ncols)
  }

  p
}

