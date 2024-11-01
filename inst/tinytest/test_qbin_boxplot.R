library(tinytest)

p <- qbin_boxplot( iris
            , n = 25
            )


qbin_boxplot( diamonds[1:7])

qbin_boxplot( diamonds[1:7], auto_fill = TRUE)

qbin_boxplot(iris, n = 25, auto_fill = TRUE)
qbin_boxplot(iris, n = 30, fill = "red", color = "green")

