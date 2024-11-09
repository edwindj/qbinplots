
qbin_boxplot(
  iris,
  x = "Sepal.Length",
  n = 25,
  connect = FALSE,
)

qbin_boxplot(
  iris,
  x = "Sepal.Length",
  n = 25,
  connect = TRUE,
  xmarker = 5.5,
  auto_fill = TRUE
)

data("diamonds", package="ggplot2")

qbin_boxplot(
  diamonds[1:7],
  "carat",
  auto_fill = TRUE
)

qbin_boxplot(
  diamonds[1:7],
  "price",
  auto_fill = TRUE,
)



