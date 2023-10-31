#' LogSumExp
#'
#' Compute log(sum(exp(x))) in a numerically-stable fashion
#'
#' @param x numeric, usually a vector
#'
#' @return numeric, single number
#' @examples
#' logsumexp(c(-1e5,-1e12))
#' # compare to log(sum(exp(c(-1e5,-1e12))))
#' log(sum(exp(c(-1e5,-1e12))))
#' @export
logsumexp <- function(x){
  if(!is.numeric(x)) stop('x should be numeric, not ', class(x)[1])
  x_max <- max(x)
  result <- x_max + log(sum(exp(x-x_max)))
  return(result)
}
