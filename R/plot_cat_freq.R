#' @import ggplot2
plot_cat_freq <- function(data, name, scales=c("fixed", "free_x")){

  # CRAN checks...
  bin <- data$bin
  f <- data$f
  freq <- data$freq
  category <- data$category

  width = resolution(data$f)

  ggplot(data, aes(x = f, y=freq, fill = category)) +
    geom_col(show.legend = FALSE, width=width) +
    facet_grid(
      ~category,
      scales=match.arg(scales)
    ) +
    coord_flip() +
    labs(fill = NULL, y = name, color = NULL) +
    scale_y_continuous( position = "right"
                      , labels = NULL
                      ) +
    theme_minimal() +
    theme(legend.position = "bottom")
}
