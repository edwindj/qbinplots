dependence_plot(iris, "Petal.Length", 20)

dependence_plot(diamonds, "price")
dependence_plot(diamonds, "carat")

if (require(palmerpenguins)){
  dependence_plot(penguins[1:7], "body_mass_g", 25)
  quantile_dependence_plot(penguins[1:7], c("body_mass_g"), 25)
}

