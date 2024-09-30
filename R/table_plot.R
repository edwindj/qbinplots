#' @export
#' @rdname qbin_barplot
table_plot <- function(data, x = NULL, n = 100, ncols=ncol(data), ...) {
  d <- preprocess(
    data,
    sort_variable = x,
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

