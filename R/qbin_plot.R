qbin_plot <- function(l, x, ncols=NULL, y_scale_rm = FALSE){
  structure(
    l,
    class="qbin_plot",
    x = x,
    ncols = ncols,
    y_scale_rm = y_scale_rm
  )
}

#' @export
print.qbin_plot <- function(x, ...){
  y_scale_rm <- attr(x, "y_scale_rm")

  if (isTRUE(y_scale_rm)){
    x[] <- lapply(x, function(p){
      p + scale_x_continuous(
        name = NULL,
        expand = c(0,0),
        labels = scales::label_percent()
      )
    })
  }

  pw <- Reduce(`+`, x)

  ncols <- attr(x, "ncols")
  if (is.numeric(ncols)){
    pw <- pw + plot_layout(ncol = ncols)
  }

  print(pw, ...)
}

#' @export
`[.qbin_plot` <- function(x, i){
  xs <- unclass(x)[i]
  class(xs) <- class(x)

  ncols <- attr(x, "ncols")
  if (is.numeric(ncols)){
    attr(xs, "ncols") <- min(length(xs), ncols)
  }

  attr(xs, "y_scale_rm") <- attr(x, 'y_scale_rm')
  xs
}
