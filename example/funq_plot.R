funq_plot(iris, "Petal.Length", 20)

funq_plot(diamonds, "price")
funq_plot(diamonds, "carat")

if (require(palmerpenguins)){
  funq_plot(penguins[1:7], "body_mass_g", 25)
  quantile_dependence_plot(penguins[1:7], c("body_mass_g"), 25)
}

