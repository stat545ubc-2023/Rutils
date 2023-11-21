testthat::test_that("Input has to be numeric",{
  testthat::expect_error(Log1p(c(TRUE,FALSE))) # boolean input
  testthat::expect_error(Log1p(c(2,"3"))) # string input
})

testthat::test_that("Output behaves as expected",{
  testthat::expect_equal(1,Log1p(exp(1)-1)) # Log1p(exp(x)) = log(e)=1
  testthat::expect_length(Log1p(1:100),100) # Log1p(vector) is vector of same size
  testthat::expect_gt(Log1p(10^(-(10:15))),0) # handles small positive numbers
})
