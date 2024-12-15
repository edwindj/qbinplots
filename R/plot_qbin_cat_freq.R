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

  width = ggplot2::resolution(data$f)

  mapping <- aes(x = f, y = freq)
  geom <- ggplot2::geom_col(show.legend = FALSE, width=width, fill = fill)

  if (isTRUE(auto_fill)){
    mapping <- aes(x = f, y = freq, fill = category)
    geom <- ggplot2::geom_col(show.legend = FALSE, width=width)
  }

  ggplot2::ggplot(data, mapping = mapping) +
    geom +
    ggplot2::facet_grid(
      cols=ggplot2::vars(category),
      scales=match.arg(scales)
    ) +
    ggplot2::coord_flip() +
    ggplot2::labs(
      fill = NULL,
      y = name,
      color = NULL,
      title=NULL,
      subtitle = NULL
    ) +
    ggplot2::scale_y_continuous(
      # position = "right",
      labels = NULL
    )
}
