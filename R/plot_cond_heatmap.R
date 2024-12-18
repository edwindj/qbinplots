plot_cond_heatmap_gradient <- function(
    x_data,
    x_bin,
    y,
    x_name,
    y_name,
    show_bins = FALSE,
    bins,
    low = "#eeeeee",
    high = "#2f4f4f", ...
  ){

  y_bin_breaks <- seq(
    from = min(y, na.rm = TRUE),
    to = max(y, na.rm = TRUE),
    length.out = bins[2] + 1
  )

  y_data <- data.table(
    bin = x_bin,
    y_bin = cut(y, breaks = bins[2], labels = FALSE)
  )[,.(n = .N), keyby = .(bin, y_bin)]

  y_data[, d := n/sum(n), by = .(bin)]


  y_bin_bounds <- data.table(
    y_bin = seq_len(bins[2]),
    ymin = y_bin_breaks[-(bins[2] + 1)],
    ymax = y_bin_breaks[-1]
  )

  x_bin_bounds = x_data[, .(
    bin = bin,
    xmin = (min + c(min[1], max[-bins[1]]))/2,
    xmax = (max + c(min[-1], max[bins[1]]))/2
  )]


  data <- y_data[x_bin_bounds, on = "bin"]
  data <- data[y_bin_bounds, on = "y_bin", nomatch = 0]

  xmin <- xmax <- ymin <- ymax <- fill <- . <- bin <- y_bin <- d <- n <-  NULL

  subtitle <- sprintf("%s", y_name)

  p <- ggplot2::ggplot(data) +
    ggplot2::geom_rect(
      aes(
        xmin = xmin,
        xmax = xmax,
        ymin = ymin,
        ymax = ymax,
        fill = d
      ),
      # color = "white",
      show.legend = FALSE) +
    ggplot2::scale_fill_gradient(low = low, high=high) +
    ggplot2::labs(
      x = x_name,
      y = NULL,
      subtitle=subtitle
    )

  if (isTRUE(show_bins)){
    p <- p + ggplot2::geom_rug(data = x_bin_bounds, aes(x = xmin))
  }

  p
}
