cond_heatmap(
  iris,
  x = "Petal.Length",
  n = 12
)

\donttest{

  data("diamonds", package="ggplot2")

  cond_heatmap(
    diamonds,
    x = "carat",
    bins <- c(100,100)
  )[6:8]
}
