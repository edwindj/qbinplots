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
partial_dependence_plot <- function(data, sort_variable = names(data)[1], n = 100, ncols=ncol(data), ...) {
  d <- preprocess(
    data,
    sort_variable = sort_variable,
    n = n
  )
  #TODO check if sort_variable is in data en numcol

  num_cols <- d$num_cols
  m <- match(sort_variable, num_cols)
  # remove sort_column
  num_cols <- num_cols[-m]

  x_data <- d$data[[sort_variable]]

  pn <- lapply(num_cols, function(y_name){
    y_data <- d$data[[y_name]]
    plot_num_line(
      x_data = x_data,
      y_data = y_data,
      x_name=sort_variable,
      y_name = y_name
    )
  })
  names(pn) <- num_cols

  pc <- lapply(d$cat_cols, function(y_name){
    y_data <- d$data[[y_name]]
    plot_cat_line(
      x_data,
      y_data = y_data,
      x_name = sort_variable,
      y_name = y_name
    )
  })
  names(pc) <- d$cat_cols
  p <- c(pn, pc)

  #p <- set_palettes(p, d$cat_cols)
  p <- Reduce(`+`, p)
  p
}

