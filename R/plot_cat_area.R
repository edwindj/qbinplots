#' @import ggplot2
plot_cat_area <- function(
    x_data,
    y_data,
    x_name,
    y_name,
    auto_fill = FALSE,
    ...,
    fill = "#555555"
  ){

  # CRAN checks
  . <- x <- freq <- category <- bin <- med <- lb <- ub <-  NULL

  bin_bounds <- data.table(
    bin = x_data$bin,
    lb = (x_data$min + c(x_data$min[1], x_data$max[-1]))/2
  )
  bin_bounds$ub <- c(bin_bounds$lb[-1], x_data$max[length(x_data$max)])

  data <- rbind(
    cbind(bin_bounds[(y_data$bin),.(x = lb)], y_data),
    cbind(bin_bounds[(y_data$bin),.(x = ub)], y_data)
  )[order(category, bin,x),]

  geom <- geom_area(show.legend = FALSE, fill = fill)
  if (isTRUE(auto_fill)){
    geom <- geom_area(show.legend = FALSE, aes(fill=category))
  }

  subtitle <- sprintf("%s | %s", y_name, x_name)
  ggplot(data, aes(x = x, y=freq)) +
    geom +
    facet_grid(
      category~.
    ) +
    # coord_flip() +
    labs(
      subtitle = subtitle,
      x = x_name
    ) +
    scale_y_continuous(
      labels = NULL,
      breaks = NULL,
      name = NULL
    ) +
    theme_minimal()
}
