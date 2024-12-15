funq_plot(iris, "Sepal.Length", n = 12, xmarker=5.5)

funq_plot(diamonds[1:7], "carat", xlim=c(0,2))

if (require(palmerpenguins)){
  funq_plot(
    penguins[1:7],
    x = "body_mass_g",
    n = 12,
    xmarker=4650,
    ncol = 3
  )
}

funq_plot(
  iris,
  x = "Sepal.Length",
  min_bin_size = 20,
  overlap = TRUE
)

