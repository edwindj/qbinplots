condplotlist <- function(l, x, ncols=NULL){
  structure(
    l,
    class="condplotlist",
    x = x,
    ncols = ncols
  )
}

#' @export
print.condplotlist <- function(x, ...){
  title <- sprintf("Conditioning on %s", attr(x, "x"))
  x[] <- lapply(x, function(p){
    p +
      ggplot2::theme_minimal()
  })

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
`[.condplotlist` <- function(x, i){
  xs <- unclass(x)[i]
  class(xs) <- class(x)

  ncols <- attr(x, "ncols")
  if (is.numeric(ncols)){
    attr(xs, "ncols") <- min(length(xs), ncols)
  }

  xs
}
