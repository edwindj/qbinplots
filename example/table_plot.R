data("diamonds", package="ggplot2")

table_plot(diamonds, "carat")

table_plot(diamonds[c(1:4, 7)], "carat")

table_plot(iris, "Sepal.Length", 50)


if (require(palmerpenguins)) {
  table_plot(penguins[1:7], "body_mass_g", 25)
}
