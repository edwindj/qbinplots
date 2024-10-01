library(tinytest)

qbin_barplot( iris
              , n = 25
)

qbin_barplot( diamonds[1:7])

qbin_barplot( diamonds[1:7], auto_fill = TRUE)

qbin_barplot(iris, n = 25, auto_fill = TRUE)
qbin_barplot(iris, n = 30, fill = "red", color = "green")

