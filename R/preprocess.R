#' @import data.table
preprocess <- function(x, sort_variable, n = 100){
  x <- as.data.table(x)
  setkeyv(x, sort_variable)

  bin <- x[, cut(.I, n, labels = FALSE)]

  n <- min(n, nrow(x))

  is_num <- sapply(x, is.numeric)

  num_cols <- is_num |> which() |> names()
  cat_cols <- (!is_num) |> which() |> names()

  nd <- lapply(num_cols, function(nc){
    d <- x[, calc_num(.SD[[nc]], na.rm=TRUE), by = bin]
    d$f <- d$bin/n
    d
  })
  names(nd) <- num_cols

  cd <- lapply(cat_cols, function(cc){
    d <- x[, calc_cat(.SD[[cc]]), by = bin]
    d$f <- d$bin/n
    d
  })

  names(cd) <- cat_cols

  l <- c(nd, cd)[names(x)]

  list(
    sort_variable = sort_variable,
    bin = bin,
    num_cols = num_cols,
    cat_cols = cat_cols,
    data = l
  )
}

#' @importFrom stats fivenum
calc_num <- function(x, na.rm = TRUE){
  l <-
    fivenum(x) |>
    as.list()
  names(l) <- c("min", "q1", "med", "q3", "max")
  l$mean <- mean(x, na.rm = na.rm)
  l
}

calc_cat <- function(x){
  d <- (1.0 * table(x))/length(x)
  d <- as.data.table(d)
  names(d) <- c("category", "freq")
  d
}

# d <- preprocess(iris, "Sepal.Length", n = 25)
# hist(d$data$Species$freq)
