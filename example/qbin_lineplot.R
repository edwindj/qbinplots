
qbin_lineplot(
  iris,
  x = "Sepal.Length",
  n = 25,
)

qbin_lineplot(
  iris,
  x = "Sepal.Length",
  n = 25,
  xmarker = 5.5,
  auto_fill = TRUE
)

data("diamonds", package="ggplot2")

qbin_lineplot(
  diamonds[1:7],
  "carat",
  auto_fill = TRUE
)

qbin_lineplot(
  diamonds[1:7],
  "price",
  auto_fill = TRUE,
)



