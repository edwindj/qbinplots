library(tinytest)
data("diamonds", package="ggplot2")

p <- qbin_boxplot( iris
            , n = 25
            )

exit_if_not(at_home())
qbin_boxplot( diamonds[1:7])

qbin_boxplot( diamonds[1:7], auto_fill = TRUE)

qbin_boxplot(iris, n = 25, auto_fill = TRUE)
qbin_boxplot(iris, n = 30, fill = "red", color = "green")

