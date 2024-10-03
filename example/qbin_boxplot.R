
qbin_boxplot(iris, "Sepal.Length", n = 25)

data("diamonds", package="ggplot2")
qbin_boxplot(
  diamonds[1:7],
  "carat",
  color = "#333",
  auto_fill = TRUE
)




