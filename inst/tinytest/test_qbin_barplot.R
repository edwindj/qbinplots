library(tinytest)
data("diamonds", package="ggplot2")

p <- qbin_barplot( iris
              , n = 25
)

exit_if_not(at_home(), "skipping plots")
qbin_barplot( diamonds[1:7])

qbin_barplot( diamonds[1:7], auto_fill = TRUE)

qbin_barplot(iris, n = 25, auto_fill = TRUE)
qbin_barplot(iris, n = 30, fill = "red", color = "green")

