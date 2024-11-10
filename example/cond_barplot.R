# plots the expected median conditional on Sepal.Width
cond_barplot(iris, "Sepal.Width", n = 25)

# plots the expected median
cond_barplot(iris, "Sepal.Width", n = 25, show_bins = TRUE)


data("diamonds", package="ggplot2")

cond_barplot(diamonds[c(1:4, 7)], "carat", auto_fill = TRUE)

if (require(palmerpenguins)) {
  p <- cond_barplot(penguins[1:7], "body_mass_g", 25, auto_fill = TRUE)
  print(p)

  # compare with qbin_boxplot
  p <- cond_boxplot(penguins[1:7], "body_mass_g", 25, auto_fill = TRUE)
  print(p)
}
