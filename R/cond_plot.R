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
  title <- sprintf("Conditioning on %s", attr(x, "x"))

  pw <- patchwork::wrap_plots(
    x,
    ncol = attr(x, "ncols"),
    axes = 'collect',
    ...
  ) + patchwork::plot_annotation(
    title=title
  )

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
