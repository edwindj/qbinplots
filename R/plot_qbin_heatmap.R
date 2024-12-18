plot_qbin_heatmap_gradient <- function(f, y, name, bins, low = "#eeeeee", high = "#2f4f4f", ...){
  d <- data.frame(x = f, y = y)
  x <- NULL
  p <- ggplot2::ggplot(data.frame(x = f, y = y), aes(x = x, y = y)) +
    ggplot2::geom_bin_2d(show.legend = FALSE, bins = bins) +
    # scale_x_continuous(labels = scales::percent_format()) +
    ggplot2::scale_fill_gradient(low = low, high=high) +
    # scale_y_continuous( position = "right")+
    ggplot2::coord_flip() +
    ggplot2::labs(y = name, title=NULL)
  p
}


plot_qbin_heatmap_size <- function(f, y, name, bins, fill = "#2f4f4f", ...){

  # CRAN checks
  ncount <- NULL

  d <- data.frame(x = f, y = y)

  ry <- range(y, na.rm = TRUE)
  fy <- (ry[2] - ry[1]) / (bins[2] - 1)

  rx <- range(f, na.rm = TRUE)
  fx <- (rx[2] - rx[1]) / (bins[1] - 1)

  x <- NULL
  p <- ggplot2::ggplot(data.frame(x = f, y = y), aes(x = x, y = y)) +
    ggplot2::geom_bin_2d(
      show.legend = FALSE,
      aes(
        height = fy * sqrt(ggplot2::after_stat(ncount)),
        width = fx * sqrt(ggplot2::after_stat(ncount))
      ),
      fill = fill,
      bins = bins
    ) +
    # scale_x_continuous(labels = scales::percent_format()) +
    ggplot2::coord_flip() +
    ggplot2::labs(y = name, title=NULL)

  p
}
