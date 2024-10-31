#' Create a qbin_heatmap from a dataset
#'
#' `qbin_heatmap` from a dataset/frame. Shows the distribution
#' of variables for each quantile bin of `x`. It is a complement to
#' [qbin_boxplot()], focussing on the distribution per [qbin()].
#'
#' @param data A data.frame or data.table
#' @param x The variable that generates the quantile bins.
#' @param n The number of bins to use for binning the data, is overruled by `bins`
#' @param bins `integer` vector with the number of bins to use for the x and y axis.
#' @param type The type of heatmap to use. Either "gradient" or "size".
#' @param ncols The number of column to be used in the layout.
#' @param fill The color used for categorical variables.
#' @param low The color used for low values in the heatmap.
#' @param high The color used for high values in the heatmap.
#' @param auto_fill If `TRUE`, use a different color for each category.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/qbin_heatmap.R
#' @family qbin plotting functions
#' @return A ggplot object
qbin_heatmap <- function(
    data,
    x = NULL,
    n = 100,
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
    n = bins[1]
  )

  n <- d$n
  bins[1] <- d$n

  if (length(bins) == 1){
    bins <- c(bins, bins)
  }


  o <- order(data[[d$x]])
  f <- order(o) |> cut(n, labels = FALSE)
  f <- (f-1)/(n-1)

  plot_heatmap <- switch(
    match.arg(type),
    gradient = plot_heatmap_gradient,
    size = plot_heatmap_size
  )

  pn <- lapply(d$num_cols, function(nc){
    y <- data[[nc]]
    plot_heatmap(
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
    #plot_cat(d$data[[n]], n)
    plot_cat_freq(
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

  p <- qbin_plot(p, x = x, ncols = ncols, y_scale_rm = TRUE)
  p
}

