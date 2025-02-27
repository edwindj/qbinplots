% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cond_boxplot.R
\name{cond_boxplot}
\alias{cond_boxplot}
\title{Conditional quantile boxplot}
\usage{
cond_boxplot(
  data,
  x = NULL,
  n = 100,
  min_bin_size = NULL,
  color = "#002f2f",
  fill = "#2f4f4f",
  auto_fill = FALSE,
  ncols = NULL,
  xmarker = NULL,
  qmarker = NULL,
  show_bins = FALSE,
  xlim = NULL,
  connect = FALSE,
  ...
)
}
\arguments{
\item{data}{a \code{data.frame} to be binned}

\item{x}{\code{character} variable name used for the quantile binning}

\item{n}{\code{integer} number of quantile bins.}

\item{min_bin_size}{\code{integer} minimum number of rows/data points that should be
in a quantile bin. If NULL it is initially \code{sqrt(nrow(data))}}

\item{color}{The color to use for the line charts}

\item{fill}{The fill color to use for the areas}

\item{auto_fill}{If \code{TRUE}, use a different color for each category}

\item{ncols}{The number of column to be used in the layout}

\item{xmarker}{\code{numeric}, the x marker.}

\item{qmarker}{\code{numeric}, the quantile marker to use that is translated in a x value.}

\item{show_bins}{if \code{TRUE} a rug is added to the plot}

\item{xlim}{\code{numeric}, the limits of the x-axis.}

\item{connect}{if \code{TRUE} subsequent medians are connected.}

\item{...}{Additional arguments to pass to the plot functions}
}
\value{
A \code{list} of ggplot objects.
}
\description{
\code{\link[=cond_boxplot]{cond_boxplot()}} conditions all variables on \code{x} by quantile binning and
shows the boxplots for the other variables for each value of qbinned \code{x}.
}
\details{
\code{cond_boxplot} is the same function as \code{\link[=funq_plot]{funq_plot()}} but with different defaults,
namely \code{connect = FALSE} and \code{auto_fill = FALSE}.
\code{funq_plot} highlights the functional relationship between
x and the y-variables, by connecting the medians of the quantile bins.

\code{\link[=qbin_boxplot]{qbin_boxplot()}} shows the boxplots of the quantile bins on a quantile scale.
}
\examples{
cond_boxplot(
  iris, x = "Petal.Length"
)

}
\seealso{
Other conditional quantile plotting functions: 
\code{\link{cond_barplot}()},
\code{\link{cond_heatmap}()},
\code{\link{funq_plot}()}
}
\concept{conditional quantile plotting functions}
