testthat::test_that("Input has to be numeric",{
  testthat::expect_error(logsumexp(c(TRUE,FALSE))) # boolean input
  testthat::expect_error(logsumexp(c(2,"3"))) # string input
})

testthat::test_that("Output behaves as expected",{
  testthat::expect_equal(3,logsumexp(3)) # logsumexp(float) = float
  testthat::expect_length(logsumexp(1:100),1) # logsumexp(vector) is float
  testthat::expect_gt(logsumexp(-10^(10:15)),-Inf) # handles large negative numbers
})
