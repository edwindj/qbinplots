qd_plot <- function(l){
  structure(
    l,
    class="gg_qd"
  )
}

#' @export
print.gg_qd <- function(x, ...){
  pw <- Reduce(`+`, x)
  print(pw, ...)
}

#' @export
`[.gg_qd` <- function(x, i){
  xs <- unclass(x)[i]
  class(xs) <- class(x)
  xs
}

#' @export
`+.gg_qd` <- function(e1, e2){
  e2name <- deparse(substitute(e2))
  for (i in seq_along(e1)){
    e1[[i]] <- ggplot2::ggplot_add(e1[[i]], e2, e2name)
  }
  e1
}
