cond_plot <- function(l, x, ncols=NULL){
  structure(
    l,
    class="cond_plot",
    x = x,
    ncols = ncols
  )
}

#' @export
print.cond_plot <- function(x, ...){
  pw <- Reduce(`+`, x)

  ncols <- attr(x, "ncols")
  if (is.numeric(ncols)){
    pw <- pw + plot_layout(ncol = ncols)
  }

  print(pw, ...)
}

#' @export
`[.cond_plot` <- function(x, i){
  xs <- unclass(x)[i]
  class(xs) <- class(x)

  ncols <- attr(x, "ncols")
  if (is.numeric(ncols)){
    attr(xs, "ncols") <- min(length(xs), ncols)
  }

  xs
}
