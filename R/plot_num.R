#' @import ggplot2
plot_num <- function(data, name, color = "#555555"){
  bin <- data$bin
  f <- data$f

  width <- resolution(f) * 1.0

  ggplot(data, aes(x = f, y = mean)) +
    geom_col(fill=color, width = width) +
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
