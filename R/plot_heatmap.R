plot_heatmap_gradient <- function(f, y, name, bins, low = "#eeeeee", high = "#2f4f4f", ...){
  d <- data.frame(x = f, y = y)
  x <- NULL
  p <- ggplot(data.frame(x = f, y = y), aes(x = x, y = y)) +
    geom_bin_2d(show.legend = FALSE, bins = bins) +
    # scale_x_continuous(labels = scales::percent_format()) +
    scale_fill_gradient(low = low, high=high) +
    scale_y_continuous( position = "right")+
    coord_flip() +
    labs(y = name) +
    theme_minimal()

  p
}


plot_heatmap_size <- function(f, y, name, bins, fill = "#2f4f4f", ...){

  # CRAN checks
  ncount <- NULL

  d <- data.frame(x = f, y = y)

  ry <- range(y, na.rm = TRUE)
  fy <- (ry[2] - ry[1]) / (bins[2] - 1)

  rx <- range(f, na.rm = TRUE)
  fx <- (rx[2] - rx[1]) / (bins[1] - 1)

  x <- NULL
  p <- ggplot(data.frame(x = f, y = y), aes(x = x, y = y)) +
    geom_bin_2d(
      show.legend = FALSE,
      aes(
        height = fy * sqrt(after_stat(ncount)),
        width = fx * sqrt(after_stat(ncount))
      ),
      fill = fill,
      bins = bins
    ) +
    # scale_x_continuous(labels = scales::percent_format()) +
    scale_y_continuous( position = "right")+
    coord_flip() +
    labs(y = name) +
    theme_minimal()

  p
}
