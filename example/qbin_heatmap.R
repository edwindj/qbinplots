
qbin_heatmap(iris, "Sepal.Length", n = 25)

data("diamonds", package="ggplot2")

qbin_heatmap(
  diamonds[c(1:4, 7)],
  "carat",
  color = "#333",
  auto_fill = TRUE
)




