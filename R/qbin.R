#' Bin a data.frame into quantile bins
#'
#' Bins a data.frame into quantile bins for variable `x` in `data`.
#'
#' Each numeric variable in the data.frame is binned into `n` quantile bins, for
#' which the [fivenum()] and [mean()] is calculated.
#'
#' When `n/nrow(data)` is less than `min_bin_size`, `qbin` gives a warning and
#' `n` is adjusted to `nrow(data)/min_bin_size`.
#' Each categorical variable is binned into `n` quantile bins, for which the
#' level frequency is calculated.
#' @param data a `data.frame` to be binned
#' @param x `character` variable name used for the quantile binning
#' @param n `integer` number of quantile bins.
#' @param min_bin_size `integer` minimum number of rows/data points that should be
#' in a quantile bin. If NULL it is initially `sqrt(nrow(data))`
#' @param overlap `logical` if `TRUE` the quantile bins will overlap. Default value will be
#' `FALSE`.
#' @param ... reserved for future use
#' @export
#' @return a `qbin` object with:
#' - $x the variable name used for binning
#' - $bin a vector of bin numbers
#' - $n the number of bins
#' - $num_cols a vector of numeric column names
#' - $cat_cols a vector of categorical column names
#' - $data a list of data.tables with the collected information
#' @import data.table
qbin <- function(
    data,
    x = NULL,
    n = 100,
    min_bin_size = NULL,
    overlap = NULL,
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
    message("`x` variable not specified, using first numeric column: '", num_cols[1], "'")
  }

  if (is.null(min_bin_size)){
    min_bin_size <- sqrt(nrow(data))
  }

  min_bin_size <- floor(min_bin_size)

  if (min_bin_size < 2){
    min_bin_size <- 2
    message("Setting 'min_bin_size' to 2")
  }


  data <- as.data.table(data)
  setkeyv(data, x)

  overlap_idx <- NULL

  if ((nrow(data) / n) < min_bin_size){

    if (is.null(overlap)){
      overlap <- FALSE
      message("`overlap` not specified, using `overlap=", overlap,"`")
    }

    if (isTRUE(overlap)){
      end <- nrow(data) - min_bin_size
      if (end < n){
        n <- end
        message("Overlapping bins, setting 'n' to: ", n)
      }
      start <-
        seq_len(min_bin_size) |>
        sapply(function(i){
          seq(i, end + i, length.out = n) |> as.integer()
        })
      # create overlapping qbins
      bin <- row(start) |> as.integer()
      overlap_idx <- as.integer(start)
      data <- data[overlap_idx,]
    } else {
      n <- trunc(nrow(data)/min_bin_size)
      message("`min_bin_size`=",min_bin_size,", using `n=", n, "`")
      bin <- data[, cut(.I, n, labels = FALSE)]
    }
  } else {
    bin <- data[, cut(.I, n, labels = FALSE)]
  }


  nd <- lapply(num_cols, function(nc){
    d <- data[, calc_num(.SD[[nc]], na.rm=TRUE), by = bin]
    d$f <- (d$bin-1)/(n-1)
    iqr <-  d$q3 - d$q1
    # TODO rename whisker
    d$whisker_low <- pmax(d$min,d$q1 - 1.5 * iqr)
    d$whisker_high <- pmin(d$q3 + 1.5 * iqr, d$max)
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
      overlap_idx = overlap_idx,
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
  if (!is.null(lev <- levels(x))){
    d$category <- factor(d$category, levels = lev)
  }
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
