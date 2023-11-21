#' Expm1
#'
#' Compute exp(x)-1 in a numerically-stable fashion
#'
#' @param x numeric
#'
#' @return numeric, same size as x
#' @examples
#' Expm1(1e-20)
#' # compare to naive approach:
#' exp(1e-20)-1
#' @export
Expm1 <- function(x){
  if(!is.numeric(x)) stop('x should be numeric, not ', class(x)[1])
  y <- 1+x
  z <- y-1
  idx <- (z==0) # where is z==0 (ie numerical underflow)
  out <- rep(0,length(x))
  out[idx] <- x[idx] # if underflow, x itself is a good approximation
  out[!idx] <- exp(x[!idx])-1 # o.w., compute normally
  return(out)
}
