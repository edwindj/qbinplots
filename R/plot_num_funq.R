#' @import ggplot2
plot_num_funq <- function(
    x_data,
    y_data,
    x_name,
    y_name,
    color = "#555555",
    show_bins = FALSE,
    connect = TRUE,
    show_mean = FALSE
  ){

  bin_bounds <- data.table(
    bin = x_data$bin,
    lb = (x_data$min + c(x_data$min[1], x_data$max[-1]))/2
  )
  bin_bounds$ub <- c(bin_bounds$lb[-1], x_data$max[length(x_data$max)])


  data <- rbind(
    data.table(
      bin = y_data$bin,
      x = bin_bounds$lb,
      y = y_data$med,
      mean = y_data$mean,
      q1 = y_data$q1,
      q3 = y_data$q3,
      whisker_low = y_data$whisker_low,
      whisker_high = y_data$whisker_high,
      xend = bin_bounds$ub
    ),
    data.table(
      bin = y_data$bin,
      x = bin_bounds$ub,
      y = y_data$med,
      mean = y_data$mean,
      q1 = y_data$q1,
      q3 = y_data$q3,
      whisker_low = y_data$whisker_low,
      whisker_high = y_data$whisker_high,
      xend = bin_bounds$ub
    )
  )[order(bin,x),]


  # to keep CRAN happy
  x <- xend <- y <- f <- med <- q1 <- q3 <- whisker_low <- whisker_high <- bin <- NULL
  #


  p <- ggplot(data) +
    geom_ribbon(
      aes(
        x = x,
        ymin = whisker_low,
        ymax = whisker_high
      ),
      fill = color,
      color = NA,
      alpha = 0.1
    ) +

    geom_ribbon(
      aes(
        x = x,
        ymin = q1,
        ymax = q3
      ),
      fill = color,
      color = NA,
      alpha = 0.15
    ) +
    labs(x = x_name, y = NULL, subtitle=paste0("P(",y_name, " | ", x_name, ")")) +
    theme_minimal()

  if (isTRUE(connect)){
    p <- p + geom_line(aes(x = x, y = y), color = color)
  } else {
    p <- p + geom_segment(aes(x = x, xend = xend, y = y), color = color)
  }


  if (isTRUE(show_mean)){
    p <- p + geom_line(aes(x = x, y = mean), color = color, linetype="dashed")
  }

  if (isTRUE(show_bins)){
    p <- p + geom_rug(data = data, aes(x = x))
  }
  p
    # geom_segment(aes(x = f-w/2, xend = f + w/2, y = max, yend = max), alpha=.2, color = color) +
    # geom_segment(aes(x = f-w/2, xend = f + w/2, y = min, yend = min), alpha=.2, color = color) +
    # geom_rect(
    #   alpha = 0.1,
    #   aes(
    #     xmin = f - w/2,
    #     xmax = f + w/2,
    #     ymin = whisker_low,
    #     ymax = q1
    #   ),
    #   fill = "blue",
    #   color = NA
    # ) +
    # geom_rect(
    #   alpha = 0.1,
    #   aes(
    #     xmin = f - w/2,
    #     xmax = f + w/2,
    #     ymin = q3,
    #     ymax = whisker_high
    #   ),
    #   fill = "blue",
    #   color = NA
    # ) +
    # geom_rect(
    #   alpha = 0.4,
    #   aes(
    #     xmin = f- w/2,
    #     xmax = f + w /2,
    #     ymin = q1,
    #     ymax = q3
    #   ),
    #   fill = "blue",
    #   color = NA
    # ) +
    # # geom_step(aes(y = mean), color=color) +
    # # geom_step(aes(y = mean), color="black", linetype="dashed") +
    # geom_step(aes(y = med), color="blue") +
    # labs(y = name) +
    # scale_y_continuous(position = "right") +
    # coord_flip() +
}

