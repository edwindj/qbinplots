data("diamonds", package="ggplot2")

ggtableplot(diamonds, "carat")

ggtableplot(diamonds[c(1:4, 7)], "carat")

ggtableplot(iris, "Sepal.Length", 50)


if (require(palmerpenguins)) {
  ggtableplot(penguins[1:7], "body_mass_g", 25)
}
