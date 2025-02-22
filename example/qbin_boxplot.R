qbin_boxplot(
  iris,
  x = "Sepal.Length",
)

\donttest{
  qbin_boxplot(
    iris,
    x = "Sepal.Length",
    connect = TRUE,
    overlap = TRUE
  )

  qbin_boxplot(
    iris,
    x = "Sepal.Length",
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
}
