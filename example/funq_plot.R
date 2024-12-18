funq_plot(iris, "Sepal.Length", xmarker=5.5)

funq_plot(
  iris,
  x = "Sepal.Length",
  xmarker=5.5,
  overlap = TRUE
)


data("diamonds", package="ggplot2")
funq_plot(diamonds[1:7], "carat", xlim=c(0,2))

if (require(palmerpenguins)){
  funq_plot(
    penguins[1:7],
    x = "body_mass_g",
    xmarker=4650,
    ncol = 3
  )
}


