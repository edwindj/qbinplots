qbin_plot <- function(l, x, ncol=NULL, y_scale_rm = FALSE){
  structure(
    l,
    class="qbin_plot",
    x = x,
    ncol = ncol,
    y_scale_rm = y_scale_rm
  )
}

#' @export
print.qbin_plot <- function(x, ...){
  y_scale_rm <- attr(x, "y_scale_rm")

  if (isTRUE(y_scale_rm)){
  } else {
  }

  pw <- Reduce(`+`, x)

  ncol <- attr(x, "ncol")
  if (!is.null(ncol)){
    pw + plot_layout(ncol = ncol)
  }

  print(pw, ...)
}

#' @export
`[.qbin_plot` <- function(x, i){
  xs <- unclass(x)[i]
  class(xs) <- class(x)
  xs
}
