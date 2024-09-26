#' Create a tableplot from a dataset
#'
#' Create a table plot from a dataset/frame
#' @param data A data.frame or data.table
#' @param sort_variable The variable to sort the data by
#' @param n The number of bins to use for binning the data
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/ggtableplot.R
#' @return A ggplot object
ggtableplot <- function(data, sort_variable = names(data)[1], n = 100, nco=ncol(data), ...) {
  d <- preprocess(
    data,
    sort_variable = sort_variable,
    n = n
  )

  pn <- lapply(d$num_cols, function(n){
    d <- d$data[[n]]
    plot_num(d, n)
  })
  names(pn) <- d$num_cols

  pc <- lapply(d$cat_cols, function(n){
    plot_cat(d$data[[n]], n)
  })
  names(pc) <- d$cat_cols
  p <- c(pn, pc)[names(data)]

  p <- set_palettes(p, d$cat_cols)

  p <- layout(p, ncol = nco)
  p
}

