#' @import ggplot2
plot_cat_line <- function(
    x_data,
    y_data,
    x_name,
    y_name,
    auto_fill = FALSE,
    ...,
    fill = "#555555"
  ){

  # CRAN checks
  . <- x <- freq <- category <- med <- NULL

  data <- cbind(x_data[(y_data$bin),.(x = med, x_m = mean)], y_data)

  geom <- geom_area(show.legend = FALSE, fill = fill)
  if (isTRUE(auto_fill)){
    geom <- geom_area(show.legend = FALSE, aes(fill=category))
  }

  ggplot(data, aes(x = x, y=freq)) +
    geom +
    facet_grid(
      category~.
    ) +
    # coord_flip() +
    labs(title = y_name, x = x_name) +
    scale_y_continuous(
      labels = NULL,
      breaks = NULL,
      name = NULL
    ) +
    theme_minimal()
}
