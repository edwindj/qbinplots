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
  wh <- w/2

  ggplot(data, aes(x = f)) +
    geom_segment(aes(x = f-w/2, xend = f + w/2, y = max, yend = max), alpha=.2, color = color) +
    geom_segment(aes(x = f-w/2, xend = f + w/2, y = min, yend = min), alpha=.2, color = color) +
    geom_rect(
      alpha = 0.1,
      aes(
        xmin = f - wh,
        xmax = f + wh,
        ymin = hinge_low,
        ymax = q1
      ),
      fill = color,
      color = NA
    ) +
    geom_rect(
      alpha = 0.1,
      aes(
        xmin = f - wh,
        xmax = f + wh,
        ymin = q3,
        ymax = hinge_high
      ),
      fill = color,
      color = NA
    ) +
    geom_rect(
      alpha = 0.4,
      aes(
        xmin = f- wh,
        xmax = f + wh,
        ymin = q1,
        ymax = q3
      ),
      fill = color,
      color = NA
    ) +
    # geom_step(aes(y = mean), color=color) +
    # geom_step(aes(y = mean), color="black", linetype="dashed") +
    geom_step(aes(y = med), color=color, direction = "hv") +
    #geom_segment(aes(yend = med, y = med, x = f-wh, xend=f+wh), color="blue") +
    labs(y = name) +
    scale_y_continuous(position = "right") +
    coord_flip() +
    theme_minimal()
}

