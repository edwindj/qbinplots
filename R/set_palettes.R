PALS <- c("Accent", "Dark2", "Set1", "Set2", "Set3","Paired", "Pastel1", "Pastel2")

set_palettes <- function(x, cat_cols, ...){
  pals <- PALS[seq_along(cat_cols) %% length(PALS) + 1]
  names(pals) <- cat_cols

  x[cat_cols] <- lapply(cat_cols, function(cat){
    p <- x[[cat]]
    p + ggplot2::scale_fill_brewer(palette = pals[cat])
  })
  x
}
