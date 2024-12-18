
qbin_heatmap(
  iris,
  "Sepal.Length",
  auto_fill = TRUE
)

qbin_heatmap(
  iris,
  "Sepal.Length",
  auto_fill = TRUE,
  type = "size"
)

qbin_heatmap(
  iris,
  "Sepal.Length",
  overlap = TRUE,
  auto_fill = TRUE
)

data("diamonds", package="ggplot2")

qbin_heatmap(
  diamonds[c(1,7:9)],
  x = "price",
  n = 150
)



