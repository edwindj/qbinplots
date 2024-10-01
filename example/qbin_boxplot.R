data("diamonds", package="ggplot2")

qbin_boxplot(iris, auto_fill = TRUE)

qbin_boxplot(diamonds[1:7], "carat", auto_fill = TRUE, color = "black")
qbin_boxplot(diamonds[1:7], "price", auto_fill = TRUE, color = "black")




