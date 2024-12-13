qbinplotlist <- function(l, x, ncols=NULL){
  structure(
    l,
    class="qbinplotlist",
    x = x,
    ncols = ncols
  )
}

#' @export
print.qbinplotlist <- function(x, ...){
  x[] <- lapply(x, function(p){
    p + scale_x_continuous(
      name = NULL,
      expand = c(0,0),
      labels = scales::label_percent()
    )
  })

  ncols <- attr(x, "ncols")
  title <- sprintf("Quantile bins: %s", attr(x, "x"))

  pw <- patchwork::wrap_plots(
    x,
    ncol = ncols,
    axes = 'collect',
    ...
  ) + patchwork::plot_annotation(
    title=title
  )
  print(pw, ...)
}

#' @export
`[.qbinplotlist` <- function(x, i){
  xs <- unclass(x)[i]
  class(xs) <- class(x)

  ncols <- attr(x, "ncols")
  if (is.numeric(ncols)){
    attr(xs, "ncols") <- min(length(xs), ncols)
  }

  attr(xs, "x") <- attr(x, 'x')
  xs
}
