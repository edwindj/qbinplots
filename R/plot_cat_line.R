#' @import ggplot2
plot_cat_line <- function(x_data, y_data, x_name, y_name, ..., color = "#555555"){

  # CRAN checks...
  bin <- data$bin
  f <- data$f
  freq <- data$freq
  category <- data$category

  # CRAN checks
  . <- med <- x <- NULL

  data <- cbind(x_data[(y_data$bin),.(x = med, x_m = mean)], y_data)

  ggplot(data, aes(x = x, y=freq)) +
    geom_area(show.legend = FALSE) +
    facet_grid(
      category~.
    ) +
    # coord_flip() +
    labs(title = y_name, x = x_name) +
    scale_y_continuous(labels = NULL, breaks = NULL, name = NULL) +
    theme_minimal()
}
