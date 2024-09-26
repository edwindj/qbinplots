#' @import ggplot2
plot_cat <- function(data, name){

  # CRAN checks...
  bin <- data$bin
  freq <- data$freq
  category <- data$category

  ggplot(data, aes(x = bin, y=freq, fill = category)) +
    geom_col() +
    coord_flip() +
    labs(fill = NULL, y = name) +
    theme_minimal() +
    theme(legend.position = "bottom")
}
