funq_plot(iris, "Petal.Length", n = 20, auto_fill = TRUE)

funq_plot(diamonds[1:7], "carat")
funq_plot(diamonds[1:7], x = "carat", color = "black", auto_fill=TRUE)

funq_plot(diamonds[1:7], x = "depth", color = "black", auto_fill=TRUE)

if (require(palmerpenguins)){
  funq_plot(penguins[1:7], "body_mass_g", n = 25, auto_fill = TRUE)
}

