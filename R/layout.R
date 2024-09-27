#' @import patchwork
layout <- function(p, ncol = length(p)){
  first <- p[[1]] +
    scale_x_continuous(
      name=NULL,
      expand = c(0,0),
      label=scales::label_percent()
    )

  rest <- p[-1] |>
    lapply(function(x){
      x +
        scale_x_continuous(name = NULL, label=NULL, breaks=NULL, expand = c(0,0))
    })

  p <- c(list(first), rest)

  p <- Reduce(`+`, p)

  if (is.numeric(ncol)){
    p <- p + patchwork::plot_layout(ncol = ncol)
  }

  p
}

PALS <- c("Accent", "Dark2", "Set1", "Set2", "Set3","Paired", "Pastel1", "Pastel2")

set_palettes <- function(x, cat_cols, ...){
  pals <- PALS[seq_along(cat_cols) %% length(PALS) + 1]
  names(pals) <- cat_cols

  x[cat_cols] <- lapply(cat_cols, function(cat){
    p <- x[[cat]]
    p + scale_fill_brewer(palette = pals[cat])
  })
  x
}
