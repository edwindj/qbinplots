#' @import patchwork
layout <- function(p, ncol = length(p), x){
  idx <- match(x, names(p))
  p <- c(p[idx], p[-idx])
  first <- p[[1]] +
    scale_x_continuous(
      name=NULL,
      expand = c(0,0),
      labels=scales::label_percent()
    )

  rest <- p[-1] |>
    lapply(function(x){
      x +
        scale_x_continuous(name = NULL, labels=NULL, breaks=NULL, expand = c(0,0))
    })

  p <- c(list(first), rest)

  p <- Reduce(`+`, p)

  if (is.numeric(ncol)){
    p <- p + patchwork::plot_layout(ncol = ncol)
  }

  p
}

