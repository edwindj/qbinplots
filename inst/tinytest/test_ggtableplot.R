library(tinytest)
library(qbinplot)

a <- table_plot(iris, "Sepal.Length", 75)
a

table_plot(diamonds[1:4], "carat", 75)

ggsave("test.png")
