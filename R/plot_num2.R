#' @import ggplot2
plot_num2 <- function(data, name, color = "#555555"){
  bin <- data$bin

  # to keep CRAN happy
  f <- data$f
  med <- data$med
  q1 <- data$q1
  q3 <- data$q3

  w <- resolution(f)

  ggplot(data, aes(x = f)) +
    # geom_point(aes(y = min), color="blue", alpha=0.2) +
    # geom_point(aes(y = max), color="blue", alpha=0.2) +
    geom_rect(
      alpha = 0.1,
      aes(
        xmin = f,
        xmax = f+w,
        ymin = min,
        ymax = q1
      ),
      fill = "blue",
      color = NA
    ) +
    geom_rect(
      alpha = 0.1,
      aes(
        xmin = f,
        xmax = f+w,
        ymin = q3,
        ymax = max
      ),
      fill = "blue",
      color = NA
    ) +
    geom_rect(
      alpha = 0.4,
      aes(
        xmin = f,
        xmax = f + w,
        ymin = q1,
        ymax = q3
      ),
      fill = "blue",
      color = NA
    ) +
    # geom_step(aes(y = mean), color=color) +
    # geom_step(aes(y = mean), color="black", linetype="dashed") +
    geom_step(aes(y = med), color="blue") +
    labs(y = name) +
    scale_y_continuous(position = "right") +
    coord_flip() +
    theme_minimal()
}


#
#
# pp <- qbin(iris, "Sepal.Length", 75)
#
# n <- pp$num_cols[1]
# d <- pp$data[[n]]
#
# plot_num(d,n)
#
#
# n <- pp$cat_cols[1]
# d <- pp$data[[n]]
# plot_cat(d, n)
#
#
# pn <- lapply(pp$num_cols, function(n){
#   d <- pp$data[[n]]
#   plot_num(d, n)
# })
#
# pc <- lapply(pp$cat_cols, function(n){
#   d <- pp$data[[n]]
#   plot_cat(d, n)
# })
#
# library(patchwork)
# p2 <- Reduce(`+`, pn) + Reduce(`+`, pc)
# p2 + plot_layout(ncol = 5)
#
# p2 <- pn[[1]]
# for (p in pn[-1]){
#   p2 <- p2 + p
# }
