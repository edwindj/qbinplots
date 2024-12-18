plot_qbin_boxplot <- function(data, name, color = "blue", connect = TRUE){
  bin <- data$bin

  alpha <- c(0.1, 0.3)

  # to keep CRAN happy
  f <- data$f
  med <- data$med
  q1 <- data$q1
  q3 <- data$q3
  whisker_low <- data$whisker_low
  whisker_high <- data$whisker_high

  w <- ggplot2::resolution(f)
  wh <- w/2

  ggplot2::ggplot(data, aes(x = f)) +
    ggplot2::geom_segment(aes(x = f-w/2, xend = f + w/2, y = max, yend = max), alpha=.2, color = color) +
    ggplot2::geom_segment(aes(x = f-w/2, xend = f + w/2, y = min, yend = min), alpha=.2, color = color) +
    ggplot2::geom_rect(
      alpha = alpha[1],
      aes(
        xmin = f - wh,
        xmax = f + wh,
        ymin = whisker_low,
        ymax = q1
      ),
      fill = color,
      color = NA
    ) +
    ggplot2::geom_rect(
      alpha = alpha[1],
      aes(
        xmin = f - wh,
        xmax = f + wh,
        ymin = q3,
        ymax = whisker_high
      ),
      fill = color,
      color = NA
    ) +
    ggplot2::geom_rect(
      alpha = alpha[2],
      aes(
        xmin = f- wh,
        xmax = f + wh,
        ymin = q1,
        ymax = q3
      ),
      fill = color,
      color = NA
    ) +
    (if (isTRUE(connect)){
      ggplot2::geom_step(aes(y = med), color=color, direction = "hv")
    } else {
      ggplot2::geom_segment(aes(yend = med, y = med, x = f-wh, xend=f+wh), color=color)
    }) +
    ggplot2::labs(y = name, title = NULL) +
    ggplot2::scale_y_continuous(
      # position = "left",
      limits = c(min(q1), max(q3)),
      oob = scales::squish
    ) +
    ggplot2::coord_flip()
}

