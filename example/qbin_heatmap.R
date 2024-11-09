
qbin_heatmap(
  iris,
  "Sepal.Length",
  n = 25,
  auto_fill = TRUE
)

qbin_heatmap(
  iris,
  "Sepal.Length",
  n = 25,
  auto_fill = TRUE,
  type = "size"
)


data("diamonds", package="ggplot2")

qbin_heatmap(
  diamonds[c(1,7:9)],
  "carat",
)

qbin_heatmap(
  diamonds[c(1,7:9)],
  x = "price",
  n = 150
)



