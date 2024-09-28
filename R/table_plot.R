#' Create a tableplot from a dataset
#'
#' Create a table plot from a dataset/frame
#' @param data A data.frame or data.table
#' @param sort_variable The variable to sort the data by
#' @param n The number of bins to use for binning the data
#' @param ncols The number of column to be used in the layout
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/table_plot.R
#' @return A ggplot object
table_plot <- function(data, sort_variable = NULL, n = 100, ncols=ncol(data), ...) {
  d <- preprocess(
    data,
    sort_variable = sort_variable,
    n = n
  )

  sort_variable <- d$sort_variable

  pn <- lapply(d$num_cols, function(n){
    d <- d$data[[n]]
    plot_num_bar(d, n)
  })
  names(pn) <- d$num_cols

  pc <- lapply(d$cat_cols, function(n){
    plot_cat_stacked(d$data[[n]], n)
  })
  names(pc) <- d$cat_cols
  p <- c(pn, pc)[names(data)]

  p <- set_palettes(p, d$cat_cols)

  p <- layout(p, ncol = ncols, sort_variable = sort_variable)
  p
}

