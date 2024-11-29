library(tinytest)


b <- qbin(iris, "Sepal.Length", n = 20)
expect_equal(b$x, "Sepal.Length")
expect_equal(b$n, 20)

b <- qbin(iris, "Sepal.Width", n = 25)
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
  b <- qbin(iris, n = 20),
  "No `x` variable specified, using first numeric column: 'Sepal.Length'"
)

expect_message(
  b <- qbin(iris, x = "Sepal.Length"),
  "Bin size < min_bin_size, setting 'n' to: 30"
)

expect_message(
  b <- qbin(iris, x = "Sepal.Length", n = 20, min_bin_size = 10),
  "Bin size < min_bin_size, setting 'n' to: 15"
)

expect_equal(b$n, 15)


b <- qbin(iris, x = "Sepal.Length", min_bin_size = 5, overlap = TRUE)

b
