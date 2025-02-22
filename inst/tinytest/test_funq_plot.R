library(tinytest)

funq_plot(iris)

expect_message({
  p <- funq_plot(iris, n = 20)
})

expect_equal(names(p), tail(names(iris), -1))

exit_if_not(at_home())

p <- funq_plot(iris, "Sepal.Width", auto_fill = TRUE, xmarker = 3, n = 25)

qbin_boxplot(iris, "Sepal.Width", auto_fill = TRUE, xmarker = 3, n = 25)

funq_plot(iris, "Sepal.Width", xlim = c(2,4))

funq_plot(iris, "Sepal.Width", xmarker=3)

funq_plot(iris, "Sepal.Width", qmarker=0.2)

qbin_heatmap(iris, "Sepal.Width", bins=c(25,30), type="size")

