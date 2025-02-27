% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qbinplots-package.R
\docType{package}
\name{qbinplots-package}
\alias{qbinplots}
\alias{qbinplots-package}
\title{qbinplots}
\description{
This package creates plots using quantile binning.
}
\details{
Quantile binning is an exploratory data analysis tool that helps to see
the distribution of the variables in a dataset as a function of the variable
that is binned.

A data.frame is quantile binned on a variable \code{x} using \code{\link[=qbin]{qbin()}} and then
plotted with one of the available plot functions.

\code{qbinplots} offers various types of plots:
\itemize{
\item \verb{qbin_*} quantile binned plots that show the distribution of the variables in the quantile bins.
\item \verb{cond_*} conditional quantile plots that show the distribution of the variables conditional on the \code{x} variable.
}
}
\section{Quantile binned plots}{

\itemize{
\item \code{\link[=qbin_lineplot]{qbin_lineplot()}} highlights the change in median between qbins, shows the distribution within qbins.
\item \code{\link[=qbin_barplot]{qbin_barplot()}} shows the size of medians or expected value of qbins.
\item \code{\link[=qbin_boxplot]{qbin_boxplot()}} shows the distribution within qbins.
\item \code{\link[=qbin_heatmap]{qbin_heatmap()}} shows the distribution within the qbins.
}
}

\section{Conditional (quantile binned) plots}{

\itemize{
\item \code{\link[=cond_boxplot]{cond_boxplot()}} shows the distribution of the variables conditional on the x variable.
\item \code{\link[=cond_barplot]{cond_barplot()}} shows the expected median/mean of the variables conditional on the x variable.
\item \code{\link[=funq_plot]{funq_plot()}} shows a functional view of the data, plotting the median and
interquartile range of numerical variables and level frequency of the other
variables as a function of the \code{x} variable using quantile bins.
}
}

\seealso{
Useful links:
\itemize{
  \item \url{https://edwindj.github.io/qbinplots/}
  \item Report bugs at \url{https://github.com/edwindj/qbinplots/issues}
}

}
\author{
\strong{Maintainer}: Edwin de Jonge \email{edwindjonge@gmail.com} (\href{https://orcid.org/0000-0002-6580-4718}{ORCID})

Other contributors:
\itemize{
  \item Martijn Tennekes \email{mtennekes@gmail.com} [contributor]
}

}
