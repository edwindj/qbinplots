#' Plot variables as a function of another variable
#'
#' Plot the median and interquartile range of numerical variables and level frequency
#' of the other variables as a function the `x` variable using quantile bins,
#' hence the name `funq_plot`.
#'
#' It `qbin`s the `x` variable and plots the medians of the qbins vs the other variables, thereby
#' creating a functional view of `x` to the rest of the data,
#' calculating the statistics for each bin, hence the name `funq_plot`.
#' @param data A data.frame or data.table
#' @param x `character` name of variable that should be plotted in the x-axis.
#' @param n The number of bins to use for binning the data
#' @param color The color to use for the line charts
#' @param fill The fill color to use for the areas
#' @param auto_fill If `TRUE`, use a different color for each category
#' @param ncols The number of column to be used in the layout
#' @param xmarker `numeric`, the x marker.
#' @param add_rug if `TRUE` a rug is added to the plot
#' @param qmarker `numeric`, the quantile marker to use that is translated in a x value.
#' @param xlim `numeric`, the limits of the x-axis.
#' @param connect if `TRUE` subsequent medians are connected.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/funq_plot.R
#' @seealso [conq_boxplot()]
#' @return A ggplot object with the plots
funq_plot <- function(
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
    connect = TRUE,
    ...
  ) {
  d <- qbin(
    data,
    x = x,
    n = n
  )

  x <- d$x

  num_cols <- d$num_cols
  m <- match(x, num_cols)
  # remove sort_column
  num_cols <- num_cols[-m]

  x_data <- d$data[[x]]

  pn <- lapply(num_cols, function(y_name){
    y_data <- d$data[[y_name]]
#    plot_num_line(
    plot_num_funq(
      x_data = x_data,
      y_data = y_data,
      x_name= x,
      y_name = y_name,
      color = color,
      add_rug = add_rug,
      connect = connect
    )
  })
  names(pn) <- num_cols

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

  nms <- names(data)
  idx <- match(x, nms)
  nms <- nms[-idx]

  p <- c(pn, pc)[nms]

  if (length(qmarker) > 0){
    idx <- findInterval(qmarker, c(-Inf, x_data$f))
    xmarker <- c(xmarker, x_data$med[idx])
  }

  if (!is.null(xmarker)){
    for (i in seq_along(p)){
      p[[i]] <- p[[i]] + geom_vline(xintercept = xmarker, linetype="dashed", alpha = 0.7)
    }
  }

  if (!is.null(xlim)){
    for (i in seq_along(p)){
      p[[i]] <- p[[i]] + coord_cartesian(xlim = xlim)
    }
  }

  # qd_plot(p)

  if(isTRUE(auto_fill)){
    p <- set_palettes(p, d$cat_cols)
  }

  p <- qbin_plot(
    p,
    x = x,
    ncols = ncols
  )

  # p <- Reduce(`+`, p)
  #
  # if (!is.null(ncols)) {
  #   p <- p + plot_layout(ncol = ncols)
  # }

  p
}

