library(tinytest)


b <- qbin(iris, "Sepal.Length", n = 12)
expect_equal(b$x, "Sepal.Length")
expect_equal(b$n, 12)

b <- qbin(iris, "Sepal.Width", n = 25, min_bin_size = 5)
expect_equal(b$x, "Sepal.Width")
expect_equal(b$n, 25)

expect_equal(b$cat_cols, "Species")
expect_equal(b$num_cols, names(iris)[1:4])

expect_equal(length(b$bin), nrow(iris))
expect_true(all(b$bin <= b$n))
expect_true(all(seq_len(b$n) %in% b$bin))

expect_equal(
  names(b$data$Species),
  c("bin", "category", "freq", "f")
)

expect_equal(names(b$data), names(iris))

expect_message(
  b <- qbin(iris, n = 10),
  "x` variable not specified, using first numeric column: 'Sepal.Length'")

expect_equal(b$n, 10)
expect_equal(b$x, "Sepal.Length")

expect_message(
  b <- qbin(iris, x = "Sepal.Length")
)

expect_equal(b$n, 12)
expect_equal(b$x, "Sepal.Length")


expect_message(
  b <- qbin(iris, x = "Sepal.Length", n = 20, min_bin_size = 10, overlap = FALSE),
  "`min_bin_size`=10, using `n=15`"
)

expect_equal(b$n, 15)

expect_message({
  b <- qbin(
    iris,
    x = "Sepal.Length",
    min_bin_size = NULL,
    overlap = FALSE
  )
  },
  "`min_bin_size`=12, using `n=12`"
)

b <- qbin(
  iris,
  x = "Sepal.Length",
  overlap = TRUE
)

expect_equal(b$n, 100)

expect_message(
  b <- qbin(iris, x = "Sepal.Width", min_bin_size = 25, overlap = TRUE, n = 150),
  "Overlapping bins, setting 'n' to: 125"
)

expect_equal(b$n, 125)


# good error message when binning categorical column
expect_error({
  b <- qbin(iris, "Species", n = 10)
})
