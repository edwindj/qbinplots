
qbin_lineplot(
  iris,
  x = "Sepal.Length",
)

qbin_lineplot(
  iris,
  x = "Sepal.Length",
  xmarker = 5.5,
  auto_fill = TRUE
)

qbin_lineplot(
  iris,
  x = "Sepal.Length",
  overlap=TRUE,
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



