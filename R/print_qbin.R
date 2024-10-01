#' @export
print.qbin <- function(x, ...){
  cat("Quantile bin object\n")
  cat("Number of bins: ", max(x$bin), "\n")
  cat("Binned on variable: '", x$sort_variable, "'\n", sep="")
  cat("Variables: ", paste0("'",names(x$data),"'", collapse = ", "), "\n", sep="")
  cat("Nrows: ", length(x$bin))
  invisible(x)
}
