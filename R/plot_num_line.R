#' @import ggplot2
plot_num_line <- function(x_data, y_data, x_name, y_name){
  data <- data.frame(
    x = x_data$med,
    x_m = x_data$mean,
    y = y_data$med,
    y_m = y_data$mean
  )

  # CRAN checks
  x_m <- y_m <- x <- y <- NULL

  ggplot(data) +
    geom_line(aes(x = x_m, y = y_m)) +
    geom_line(aes(x = x, y = y), linetype="dashed") +
    labs(y = NULL, x = x_name, title = y_name) +
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
