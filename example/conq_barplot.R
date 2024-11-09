# plots the expected median conditional on Sepal.Width
conq_barplot(iris, "Sepal.Width", n = 25)

# plots the expected median
conq_barplot(iris, "Sepal.Width", n = 25, show_bins = TRUE)


data("diamonds", package="ggplot2")

conq_barplot(diamonds[c(1:4, 7)], "carat", auto_fill = TRUE)

if (require(palmerpenguins)) {
  p <- conq_barplot(penguins[1:7], "body_mass_g", 25, auto_fill = TRUE)
  print(p)

  # compare with qbin_boxplot
  p <- conq_boxplot(penguins[1:7], "body_mass_g", 25, auto_fill = TRUE)
  print(p)
}
