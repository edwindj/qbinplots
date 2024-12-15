library(tinytest)
data("diamonds", package="ggplot2")

a <- table_plot(iris, "Sepal.Length", 75)
table_plot(diamonds[1:4], "carat", 75)
