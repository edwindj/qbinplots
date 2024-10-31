#' Bin a data.frame into quantile bins
#'
#' Bins a data.frame into quantile bins for variable `x`
#' @param data a `data.frame` to be binned
#' @param x `character` variable name used for the quantile binning
#' @param n `integer` number of quantile bins.
#' @param min_bin_size `integer` minimum number of rows/data points that should be
#' in a quantile bin.
#' @param ... reserved for future use
#' @export
#' @import data.table
qbin <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = 5,
    ...
  ){
  # TODO check if data.frame

  is_num <- sapply(data, is.numeric)
  num_cols <- is_num |> which() |> names()
  cat_cols <- (!is_num) |> which() |> names()

  if (length(num_cols) == 0){
    stop("No numeric columns found", call. = FALSE)
  }

  if (is.null(x)){
    x <- num_cols[1]
    message("No `x` variable specified, using first numeric column: '", num_cols[1], "'")
  }

  data <- as.data.table(data)
  setkeyv(data, x)

  # TODO add check
  if ((nrow(data) / n) < min_bin_size){
    n <- trunc(nrow(data)/min_bin_size)
    message("Bin size < min_bin_size, setting 'n' to: ", n)
  }

  bin <- data[, cut(.I, n, labels = FALSE)]

  nd <- lapply(num_cols, function(nc){
    d <- data[, calc_num(.SD[[nc]], na.rm=TRUE), by = bin]
    d$f <- (d$bin-1)/(n-1)
    iqr <-  d$q3 - d$q1
    # TODO rename hinge
    d$hinge_low <- pmax(d$min,d$q1 - 1.5 * iqr)
    d$hinge_high <- pmin(d$q3 + 1.5 * iqr, d$max)
    d
  })
  names(nd) <- num_cols

  cd <- lapply(cat_cols, function(cc){
    d <- data[, calc_cat(.SD[[cc]]), by = bin]
    d$f <- (d$bin-1)/(n-1)
    d
  })

  names(cd) <- cat_cols

  l <- c(nd, cd)[names(data)]

  structure(
    list(
      x = x,
      bin = bin,
      n = n,
      num_cols = num_cols,
      cat_cols = cat_cols,
      data = l
    ),
    class="qbin"
  )
}

#' @importFrom stats fivenum
calc_num <- function(x, na.rm = TRUE){
  l <-
    fivenum(x) |>
    as.list()
  names(l) <- c("min", "q1", "med", "q3", "max")
  l$mean <- mean(x, na.rm = na.rm)
  l$count <- length(x)
  l
}

calc_cat <- function(x){
  d <- (1.0 * table(x))/length(x)
  d <- as.data.table(d)
  names(d) <- c("category", "freq")
  d
}

calc_bin_bounds <- function(x){
  . <- bin <- NULL

  bin_bounds <- x[,.(
    bin = bin,
    lb  = (min + c(min[1], max[-nrow(x)]))/2,
    ub  = (max + c(min[-1], max[nrow(x)]))/2
  )]

  bin_bounds$count <- x$count
  bin_bounds$density <- (bin_bounds$ub - bin_bounds$lb)/bin_bounds$count
  bin_bounds$density <- 1 - (bin_bounds$density / max(bin_bounds$density))
  bin_bounds
}

# qbin.qbin <- function(
#     data,
#     x = NULL,
#     n = 100,
#     min_bin_size = 5,
#     ...
# ){
#
#   if (!missing(x) && !is.null(x) && data$x != x){
#     warning("`x` is different from `data$x`"
#             , call. = FALSE
#             )
#   }
#
#   }
# }
#
# d <- qbin(iris, "Sepal.Length", n = 25)
# hist(d$data$Species$freq)
