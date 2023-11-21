
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Rutils

<!-- badges: start -->
<!-- badges: end -->

Rutils allows you to safely compute operations prone to numerical under
or overflow in R.

## Installation

You can install the development version of Rutils from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2023/Rutils")
```

## Examples

``` r
library(Rutils)
```

### LogSumExp

First an example where using the LogSumExp trick doesn’t actually help,
just to verify that we obtain the correct answer.

``` r
my_x = c(1:10)
trick <- logsumexp(my_x)
direct <- log(sum(exp(my_x)))
print(paste("The correct answer is ", direct, " and the LogSumExp trick yields ", trick))
#> [1] "The correct answer is  10.4586297444267  and the LogSumExp trick yields  10.4586297444267"
```

Now an example where the trick actually helps:

``` r
my_x = c(-1e5,-1e12)
trick <- logsumexp(my_x)
direct <- log(sum(exp(my_x)))
print(paste("The correct answer is ", trick, " but the naive method yields ", direct))
#> [1] "The correct answer is  -1e+05  but the naive method yields  -Inf"
```

The naive computation doesn’t work because both $\exp(-10^{5})$ and
$\exp(-10^{12})$ are smaller than the computer precision can represent,
and so they are rounded down to 0. Added up they’re still 0 and $\log 0$
results in $-\infty$. But the LogSumExp trick avoids this since
$x^\star = -10^{5}$ and the sum terms become $\exp(-10^{5}+10^{5})=1$
and $\exp(-10^{12}+10^{5})$ which is still represented as 0. The log of
sum of exps is now 0, but to that we add $x^\star=-10^{5}$. Very large
negative but not $-\infty$.

Now a more realistic example where the trick also helps. Suppose we want
to evaluate the log pdf of a mixture model with 10 elements in the
mixture: $\log p(x) = \log(p_1(x)+\cdots+p_{10}(x))$, where $p_n(x)$ is
the pdf of the $n$ th mixture element, which in our case is a
$\mathcal{N}(10n,0.1^2)$ distribution. Note that
$p_n(x) = \exp\log p_n(x)$, which allows us to cast the problem in the
LogSumExp trick format. Below we set $x=54$ and show that the naive
method produces underflow while the LogSumExp trick does not.

``` r
# setup
means <- 10*(1:10)
sd <- 0.1
test_x <- 54

# calculate log pdfs
lprbs <- rep(0,10)
for(n in 1:10) lprbs[n] <- dnorm(test_x, mean = means[n], sd = sd, log = TRUE)

# estimate log pdf of mixture model
trick <- logsumexp(lprbs)
direct <- log(sum(exp(lprbs)))
print(paste("The LogSumExp trick yields ", trick, " but the naive method yields ", direct))
#> [1] "The LogSumExp trick yields  -798.616353440211  but the naive method yields  -Inf"
```
