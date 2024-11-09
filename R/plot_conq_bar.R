#' @import ggplot2
plot_conq_bar <- function(
    x_data,
    y_data,
    x_name,
    y_name,
    fill = "#555555",
    show_bins = FALSE,
    type = c("median", "mean")
){

  bin_bounds <- data.table(
    bin = x_data$bin,
    lb = (x_data$min + c(x_data$min[1], x_data$max[-1]))/2
  )
  bin_bounds$ub <- c(bin_bounds$lb[-1], x_data$max[length(x_data$max)])


  data <-
    data.table(
      bin  = y_data$bin,
      xmin = bin_bounds$lb,
      xmax = bin_bounds$ub,
      ymin = pmin(0, y_data$med),
      ymax = pmax(0, y_data$med),
      mean = y_data$mean
    )

  # to keep CRAN happy
  x <- f <- xmin <- xmax <- ymin <- ymax <- bin <- NULL
  #
  color <- NA
  if (isTRUE(show_bins)){
    color <- grDevices::adjustcolor(fill, alpha.f = 0.1)
  }

  p <- ggplot(data) +
    geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = fill, color = color) +
    labs(x = x_name, y = NULL, title=y_name) +
    theme_minimal()

  if (isTRUE(show_bins)){
    p <- p + geom_rug(data = data, aes(x = xmin))
  }
  p
}

