library(tinytest)
library(ggtableplot)

a <- ggtableplot(iris, "Sepal.Length", 75)
a


ggtableplot(diamonds[1:4], "carat", 75)

ggsave("test.png")
