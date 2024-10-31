#' Create a quantile bin boxplot
#'
#' `qbin_boxplot` creates quantile bin boxplots from `data` using `x` as the binning
#' variable. It focuses on the change of median between qbins. It is a
#' complement to [qbin_heatmap()] which focuses on the distribution within the qbins.
#'
#' The data is binned by the `x` and a boxplot is created for each bin.
#' The median of the subsequent boxplots are connected to highlight jumps in the
#' data. It hints at the dependecy of the variable on the binning variable.
#' @param data A data.frame or data.table
#' @param x `character` The variable to bin the data by
#' @param n The number of bins to use for binning the data
#' @param ncols The number of column to be used in the layout
#' @param connect if `TRUE` subsequent boxplots are connected
#' @param color The color to use for the lines
#' @param fill The color to use for the bars
#' @param auto_fill If `TRUE`, use a different color for each category
#' @param qmarker `numeric`, the quantile marker to use.
#' @param xmarker `numeric` the x marker, i.e. the value for x that is translated into a q value.
#' @param ... Additional arguments to pass to the plot functions
#' @export
#' @example example/qbin_boxplot.R
#' @family qbin plotting functions
#' @return A `list` of ggplot objects.
qbin_boxplot <- function(
    data,
    x = NULL,
    n = 100,
    ncols=NULL,
    connect = TRUE,
    color = "#002f2f",
    fill = "#2f4f4f",
    auto_fill = FALSE,
    qmarker = NULL,
    xmarker = NULL,
    ...
  ){
  d <- qbin(
    data,
    x = x,
    n = n
  )

  x <- d$x

  pn <- lapply(d$num_cols, function(n){
    d <- d$data[[n]]
    #plot_num2(d, n)
    p <- plot_boxplot(d, n, color = color, connect= connect)
    p
    #plot_fivenum(d, n)
  })
  names(pn) <- d$num_cols

  pc <- lapply(d$cat_cols, function(n){
    #plot_cat(d$data[[n]], n)
    plot_cat_freq(
      d$data[[n]],
      n,
      fill = fill,
      auto_fill = auto_fill
    )
  })

  names(pc) <- d$cat_cols
  p <- c(pn, pc)[names(data)]

  # put x as the first column
  idx <- match(x, names(data))
  p <- c(p[idx], p[-idx])

  #TODO add xmarker
  if (length(xmarker) > 0){
    idx <- findInterval(xmarker, c(-Inf, d$data[[x]]$max))
    qmarker <- c(qmarker, d$data[[x]]$f[idx])
  }

  if (!is.null(qmarker)){
    for (i in seq_along(p)){
      p[[i]] <- p[[i]] + geom_vline(xintercept = qmarker, linetype="dashed", alpha = 0.7)
    }
  }

  if (isTRUE(auto_fill)){
    p <- set_palettes(p, d$cat_cols)
  }

  p <- qbin_plot(p, x = x, ncols = ncols, y_scale_rm = TRUE)

  p
}

