#' @export
#' @rdname qbin_barplot
table_plot <- function(
    data,
    x = NULL,
    n = 100,
    ncols=ncol(data),
    fill = "#555555",
    ...
  ) {
  qbin_barplot(
    data,
    x = x,
    n = n,
    type = "mean",
    ncols = ncols,
    fill = fill,
    ...
  )
}

