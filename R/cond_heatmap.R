#' Conditional heatmap
#'
#' `cond_heatmap` shows the conditional distribution of the `y`
#' of variables for each quantile bin of `x`. It is an alternative to
#' [cond_boxplot()], fine graining the distribution per [qbin()].
#' [cond_barplot()] highlights the median/mean of the quantile bins, while
#' [funq_plot()] highlights the functional dependency of the median.
#'
#' @param bins `integer` vector with the number of bins to use for the x and y axis.
#' @param ncols The number of column to be used in the layout.
#' @param fill The color used for categorical variables.
#' @param low The color used for low values in the heatmap.
#' @param high The color used for high values in the heatmap.
#' @param show_bins If `TRUE`, show the bin boundaries on the x-axis.
#' @param auto_fill If `TRUE`, use a different color for each category.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @inheritParams qbin
#' @example example/cond_heatmap.R
#' @family conditional quantile plotting functions
#' @return A `list` of ggplot objects.
cond_heatmap <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = 5,
    overlap = NULL,
    bins = n,
#    type = c("gradient", "size"),
    ncols=NULL,
    auto_fill = FALSE,
    show_bins = FALSE,
    fill = "#2f4f4f",
    low = "#eeeeee",
    high = "#2f4f4f",
    ...
) {

  bins <- as.integer(bins)

  d <- qbin(
    # only bin the specific x column
    data,
    x = x,
    n = bins[1],
    min_bin_size = min_bin_size,
    overlap = overlap
  )

  x <- d$x
  n <- d$n
  bins[1] <- d$n

  if (length(bins) == 1){
    bins <- c(bins, bins)
  }


  num_cols <- d$num_cols
  m <- match(x, num_cols)
  # remove sort_column
  num_cols <- num_cols[-m]

  x_name <- x
  x_data <- d$data[[x]]

  x_bin <-
    data[[x]] |>
    order() |>
    order() |>
    cut(
      bins[1],
      labels = FALSE
    )

  pn <- lapply(num_cols, function(y_name){

    y <- data[[y_name]]

    plot_cond_heatmap_gradient(
      x_data  = x_data,
      x_bin = x_bin,
      y  = y,
      bins = bins,
      x_name  = x_name,
      y_name = y_name,
      # needed for gradient
      low  = low,
      high = high,
      # needed for size
      fill = fill,
      show_bins = show_bins
    )
  })
  names(pn) <- num_cols

  pc <- lapply(d$cat_cols, function(y_name){
    #plot_cat(d$data[[n]], n)
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
  idx <- match(d$x, names(data))
  p <- c(pn, pc)[names(data)[-idx]]

  if (isTRUE(auto_fill)){
    p <- set_palettes(p, d$cat_cols)
  }

  p <- cond_plot(p, x = x, ncols = ncols)
  p
}

# data <- iris
# n <- 25
# d <- qbin(iris, n = n)
# d

# cond_heatmap(iris, n = 25)
