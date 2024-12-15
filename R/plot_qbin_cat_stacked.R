#'@importFrom ggplot2 aes
plot_qbin_cat_stacked <- function(data, name){

  # CRAN checks...
  bin <- data$bin
  f <- data$f
  freq <- data$freq
  category <- data$category

  width = ggplot2::resolution(data$f)

  ggplot2::ggplot(data, aes(x = f, y=freq, fill = category)) +
    ggplot2::geom_col(width=width) +
    ggplot2::coord_flip() +
    ggplot2::labs(fill = NULL, y = name) +
    ggplot2::scale_y_continuous(
      # position = "right",
      labels = scales::label_percent(),
      n.breaks = 3
    )
}
