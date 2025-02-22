\donttest{
  data("diamonds", package="ggplot2")

  table_plot(diamonds[c(1:4, 7)], "carat")

  qbin_barplot(iris, "Sepal.Length", n = 12)

  table_plot(iris, "Sepal.Length", n=12)
  table_plot(
    iris,
    x = "Sepal.Length",
    min_bin_size=20,
    overlap=TRUE
  )

  if (require(palmerpenguins)) {
    table_plot(penguins[1:7], "body_mass_g", 19)
  }
}
