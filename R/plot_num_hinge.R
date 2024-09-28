#' @import ggplot2
plot_hinge <- function(data, name, color = "blue"){
  bin <- data$bin

  # to keep CRAN happy
  f <- data$f
  med <- data$med
  q1 <- data$q1
  q3 <- data$q3
  hinge_low <- data$hinge_low
  hinge_high <- data$hinge_high

  w <- resolution(f)

  ggplot(data, aes(x = f)) +
    geom_segment(aes(x = f-w/2, xend = f + w/2, y = max, yend = max), alpha=.2, color = color) +
    geom_segment(aes(x = f-w/2, xend = f + w/2, y = min, yend = min), alpha=.2, color = color) +
    geom_rect(
      alpha = 0.1,
      aes(
        xmin = f - w/2,
        xmax = f + w/2,
        ymin = hinge_low,
        ymax = q1
      ),
      fill = "blue",
      color = NA
    ) +
    geom_rect(
      alpha = 0.1,
      aes(
        xmin = f - w/2,
        xmax = f + w/2,
        ymin = q3,
        ymax = hinge_high
      ),
      fill = "blue",
      color = NA
    ) +
    geom_rect(
      alpha = 0.4,
      aes(
        xmin = f- w/2,
        xmax = f + w /2,
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
# pp <- preprocess(iris, "Sepal.Length", 75)
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
