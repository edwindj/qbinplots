#' @import ggplot2
plot_num_funq <- function(
    x_data,
    y_data,
    x_name,
    y_name,
    color = "#555555",
    add_rug = FALSE,
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
      hinge_low = y_data$hinge_low,
      hinge_high = y_data$hinge_high
    ),
    data.table(
      bin = y_data$bin,
      x = bin_bounds$ub,
      y = y_data$med,
      mean = y_data$mean,
      q1 = y_data$q1,
      q3 = y_data$q3,
      hinge_low = y_data$hinge_low,
      hinge_high = y_data$hinge_high
    )
  )[order(bin,x),]


  # to keep CRAN happy
  x <- y <- f <- med <- q1 <- q3 <- hinge_low <- hinge_high <- bin <- NULL
  #


  p <- ggplot(data) +
    geom_ribbon(
      aes(
        x = x,
        ymin = hinge_low,
        ymax = hinge_high
      ),
      fill = color,
      color = NA,
      alpha = 0.2
    ) +

    geom_ribbon(
      aes(
        x = x,
        ymin = q1,
        ymax = q3
      ),
      fill = color,
      color = NA,
      alpha = 0.2
    ) +
    geom_line(aes(x = x, y = y), color = color) +
    labs(x = x_name, y = NULL, title=y_name) +
    theme_minimal()

  if (isTRUE(show_mean)){
    p <- p + geom_line(aes(x = x, y = mean), color = color, linetype="dashed")
  }

  if (isTRUE(add_rug)){
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
    #     ymin = hinge_low,
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
    #     ymax = hinge_high
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

