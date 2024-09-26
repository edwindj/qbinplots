#' @import ggplot2
plot_cat <- function(data, name){
  ggplot(data, aes(x= bin, y=freq, fill = category)) +
    geom_col() +
    coord_flip() +
    labs(fill = NULL, y = name) +
    theme_minimal() +
    theme(legend.position = "bottom")
}
