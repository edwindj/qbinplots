#' Create a qbin_heatmap from a dataset
#'
#' Create qbin_heatmap from a dataset/frame. Shows the distribution
#' of variables for each quantile bin of `x`.
#'
#' @param data A data.frame or data.table
#' @param x The variable that generates the quantile bins.
#' @param n The number of bins to use for binning the data
#' @param ncols The number of column to be used in the layout.
#' @param fill The color to use for the heatmap.
#' @param auto_fill If `TRUE`, use a different color for each category.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/qbin_heatmap.R
#' @return A ggplot object
qbin_heatmap <- function(
    data,
    x = NULL,
    n = 100,
    ncols=NULL,
    auto_fill = FALSE,
    fill = "#2f4f4f",
    ...
) {

  d <- qbin(
    data,
    x = x,
    n = n
  )

  o <- order(data[[d$x]])
  f <- order(o) |> cut(n, labels = FALSE)
  f <- (f-1)/(n-1)

  pn <- lapply(d$num_cols, function(nc){
    y <- data[[nc]]
    plot_heatmap(f, y, nc, fill = fill)
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

plot_heatmap <- function(f, y, name, fill = "#2f4f4f", ...){
  d <- data.frame(x = f, y = y)
  x <- NULL
  p <- ggplot(data.frame(x = f, y = y), aes(x = x, y = y)) +
    geom_bin_2d(show.legend = FALSE) +
    # scale_x_continuous(labels = scales::percent_format()) +
    scale_fill_gradient(low = "#eeeeee", high=fill) +
    scale_y_continuous( position = "right")+
    coord_flip() +
    labs(y = name) +
    theme_minimal()

  p
}
