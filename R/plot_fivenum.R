plot_fivenum <- function(data, name, color = "#555555"){
  bin <- data$bin

  f <- data$f
  med <- data$med
  q1 <- data$q1
  q3 <- data$q3


  data |>
    ggplot() +
    geom_boxplot(
      aes(
        x = f,
        group=f,
        ymin = min,
        lower = q1,
        middle = med,
        upper = q3,
        ymax = max
      ),
      stat = "identity",
      color=color,
      fill="grey"
    ) +
    coord_flip() +
    theme_minimal()
}


