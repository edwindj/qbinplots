#' @import ggplot2
plot_qbin_cat_freq <- function(
    data,
    name,
    scales=c("fixed", "free_x"),
    fill = "#555555",
    auto_fill = FALSE
  ){

  # CRAN checks...
  bin <- data$bin
  f <- data$f
  freq <- data$freq
  category <- data$category

  width = resolution(data$f)

  mapping <- aes(x = f, y = freq)
  geom <- geom_col(show.legend = FALSE, width=width, fill = fill)

  if (isTRUE(auto_fill)){
    mapping <- aes(x = f, y = freq, fill = category)
    geom <- geom_col(show.legend = FALSE, width=width)
  }

  ggplot(data, mapping = mapping) +
    geom +
    facet_grid(
      cols=vars(category),
      scales=match.arg(scales)
    ) +
    coord_flip() +
    labs(
      fill = NULL,
      y = name,
      color = NULL,
      title=NULL,
      subtitle = NULL
    ) +
    scale_y_continuous(
      # position = "right",
      labels = NULL
    )
}
