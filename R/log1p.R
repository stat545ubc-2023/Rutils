#' log1p
#'
#' Compute log(1+x) in a numerically-stable fashion
#'
#' @param x numeric
#'
#' @return numeric, same size as x
#' @examples
#' Log1p(1e-20)
#' # compare to naive approach:
#' log(1+1e-20)
#' @export
Log1p <- function(x){
  if(!is.numeric(x)) stop('x should be numeric, not ', class(x)[1])
  y <- 1+x
  z <- y-1
  idx <- (z==0) # where is z==0 (ie numerical underflow)
  out <- rep(0,length(x))
  out[idx] <- x[idx] # if underflow, x itself is a good approximation
  out[!idx] <- x[!idx]*log(y[!idx])/z[!idx] # o.w., log(y)/z ~ log(1+x)/x
  return(out)
}
