#' @import ggplot2
plot_cat <- function(data, name){

  # CRAN checks...
  bin <- data$bin
  f <- data$f
  freq <- data$freq
  category <- data$category

  width = resolution(data$f)

  ggplot(data, aes(x = f, y=freq, fill = category)) +
    geom_col(width=width) +
    coord_flip() +
    labs(fill = NULL, y = name) +
    scale_y_continuous(position = "right", labels = scales::label_percent(), n.breaks = 3) +
    theme_minimal() +
    theme(legend.position = "bottom")
}
