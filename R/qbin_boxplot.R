#' Create a quantile dependence plot
#'
#' Create a quantile dependence plot
#' @param data A data.frame or data.table
#' @param sort_variable The variable to sort the data by
#' @param n The number of bins to use for binning the data
#' @param ncols The number of column to be used in the layout
#' @param color The color to use for the lines
#' @param fill The color to use for the bars
#' @param auto_fill If `TRUE`, use a different color for each category
#' @param qmarker `numeric`, the quantile marker to use.
#' @param xmarker `numeric` the x marker, i.e. the value for x that is translated into a q value.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/qbin_boxplot.R
#' @return A ggplot object
qbin_boxplot <- function(
    data,
    sort_variable = NULL,
    n = 100,
    ncols=NULL,
    color = "darkblue",
    fill = "#555555",
    auto_fill = FALSE,
    qmarker = NULL,
    xmarker = NULL,
    ...
  ){
  d <- preprocess(
    data,
    sort_variable = sort_variable,
    n = n
  )

  sort_variable <- d$sort_variable

  pn <- lapply(d$num_cols, function(n){
    d <- d$data[[n]]
    #plot_num2(d, n)
    p <- plot_hinge(d, n, color = color)
    p
    #plot_fivenum(d, n)
  })
  names(pn) <- d$num_cols

  pc <- lapply(d$cat_cols, function(n){
    #plot_cat(d$data[[n]], n)
    plot_cat_freq(
      d$data[[n]],
      n,
      fill = fill,
      auto_fill = auto_fill
    )
  })
  names(pc) <- d$cat_cols
  p <- c(pn, pc)[names(data)]

  #TODO add xmarker

  if (!is.null(qmarker)){
    for (i in seq_along(p)){
      p[[i]] <- p[[i]] + geom_vline(xintercept = qmarker, linetype="dashed", alpha = 0.7)
    }
  }

  p <- set_palettes(p, d$cat_cols, sort_variable = sort_variable)

  p <- layout(p, ncol = ncols, sort_variable = sort_variable)
  p
}

