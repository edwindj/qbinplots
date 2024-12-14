#' Quantile binned heatmap
#'
#' `qbin_heatmap` shows the distribution of the `y`
#' of variables for each quantile bin of `x`. It is an alternative to
#' [qbin_boxplot()], fine graining the distribution per [qbin()].
#' [qbin_barplot()] highlights the median/mean of the quantile bins, while
#'
#' @param bins `integer` vector with the number of bins to use for the x and y axis.
#' @param type The type of heatmap to use. Either "gradient" or "size".
#' @param ncols The number of column to be used in the layout.
#' @param fill The color used for categorical variables.
#' @param low The color used for low values in the heatmap.
#' @param high The color used for high values in the heatmap.
#' @param auto_fill If `TRUE`, use a different color for each category.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @inheritParams qbin
#' @example example/qbin_heatmap.R
#' @family qbin plotting functions
#' @return A `list` of ggplot objects.
qbin_heatmap <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = 5,
    overlap = NULL,
    bins = n,
    type = c("gradient", "size"),
    ncols=NULL,
    auto_fill = FALSE,
    fill = "#2f4f4f",
    low = "#eeeeee",
    high = "#2f4f4f",
    ...
) {

  bins <- as.integer(bins)

  d <- qbin(
    data,
    x = x,
    n = bins[1],
    min_bin_size = min_bin_size,
    overlap = overlap
  )

  n <- d$n
  bins[1] <- d$n
  x <- d$x

  if (length(bins) == 1){
    bins <- c(bins, bins)
  }


  o <- order(data[[d$x]])
  f <- order(o) |> cut(n, labels = FALSE)
  f <- (f-1)/(n-1)

  plot_qbin_heatmap <- switch(
    match.arg(type),
    gradient = plot_qbin_heatmap_gradient,
    size = plot_qbin_heatmap_size
  )

  pn <- lapply(d$num_cols, function(nc){
    y <- data[[nc]]
    plot_qbin_heatmap(
      f,
      y    = y,
      name = nc,
      bins = bins,
      # needed for gradient
      low  = low,
      high = high,
      # needed for size
      fill = fill
    )
  })
  names(pn) <- d$num_cols

  pc <- lapply(d$cat_cols, function(n){
    plot_qbin_cat_freq(
      d$data[[n]],
      n,
      fill = fill,
      auto_fill = auto_fill
    )
  })

  names(pc) <- d$cat_cols
  p <- c(pn, pc)[names(data)]

  # put x as the first column
  idx <- match(d$x, names(data))
  p <- c(p[idx], p[-idx])

  if (isTRUE(auto_fill)){
    p <- set_palettes(p, d$cat_cols)
  }

  p <- qbinplotlist(p, x = x, ncols = ncols)
  p
}

