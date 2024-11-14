funq_plot(iris, "Sepal.Length", n = 25, xmarker=5.5)

funq_plot(diamonds[1:7], "carat", xlim=c(0,2))

if (require(palmerpenguins)){
  funq_plot(
    penguins[1:7],
    x = "body_mass_g",
    n = 25,
    xmarker=4650,
    ncol = 2
  )
}

