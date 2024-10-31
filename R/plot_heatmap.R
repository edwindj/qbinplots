plot_heatmap <- function(f, y, name, bins, low = "#eeeeee", high = "#2f4f4f", ...){
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
