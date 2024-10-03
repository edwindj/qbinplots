funq_plot(iris, "Petal.Length", n = 20, auto_fill = TRUE)

funq_plot(diamonds[1:7], "carat")

if (require(palmerpenguins)){
  funq_plot(penguins[1:7], "body_mass_g", n = 25, auto_fill = TRUE)
}

