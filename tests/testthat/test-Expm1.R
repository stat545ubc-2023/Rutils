testthat::test_that("Input has to be numeric",{
  testthat::expect_error(Expm1(c(TRUE,FALSE))) # boolean input
  testthat::expect_error(Expm1(c(2,"3"))) # string input
})

testthat::test_that("Output behaves as expected",{
  testthat::expect_equal(0,Expm1(log(1))) # Expm1(log(1))=exp(0)-1=0
  testthat::expect_length(Expm1(1:100),100) # Expm1(vector) is vector of same size
  testthat::expect_gt(Expm1(10^(-(10:15))),0) # handles small positive numbers
})
