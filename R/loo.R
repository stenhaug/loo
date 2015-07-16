#' Leave-one-out cross-validation (LOO)
#'
#' Efficient approximate leave-one-out cross-validation
#'
#' @export
#' @param log_lik an \eqn{S} by \eqn{N} matrix, where \eqn{S} is the size of the
#'   posterior sample (the number of simulations) and \eqn{N} is the number of
#'   data points. Typically (but not restricted to be) the object returned by
#'   \code{\link{extract_log_lik}}.
#' @param ... optional arguments to pass to \code{\link{psislw}}. Possible
#' arguments and their defaults are:
#' \describe{
#' \item{\code{wcp = 0.2}}{the proportion of importance weights to use for the
#' generalized Pareto fit. The \code{100*wcp}\% largest weights are used as the
#' sample from which to estimate the parameters \eqn{k} and \eqn{\sigma} of
#' the generalized Pareto distribution.}
#' \item{\code{wtrunc = 3/4}}{for truncating very large weights to
#' \eqn{S}^\code{wtrunc} (set to zero for no truncation).}
#' \item{\code{cores = \link[parallel]{detectCores}()}}{the number of cores to
#'      use for parallelization.}
#'}
#'
#' We recommend using the default values for the \code{psislw} arguments unless
#' there are problems (e.g. \code{NA} or \code{NaN} results).
#'
#' @return A named list (of class \code{'loo'}) with components:
#'
#' \describe{
#' \item{\code{elpd_loo, se_elpd_loo}}{expected log pointwise predictive density
#' and standard error}
#' \item{\code{p_loo, se_p_loo}}{estimated effective number of parameters and
#' standard error}
#' \item{\code{looic, se_looic}}{\code{-2 * elpd_loo} (i.e., converted to the
#' deviance scale) and standard error}
#' \item{\code{pointwise}}{a matrix containing the pointwise contributions of each
#' of the above measures}
#' \item{\code{pareto_k}}{a vector containing the estimates of the shape
#' parameter \eqn{k} for the generaelized Pareto fit to the importance ratios
#' for each leave-one-out distribution. See PSIS-LOO section in
#' \code{\link{loo-package}} for details about interpreting \eqn{k}. (Also, by
#' default, the print method for \code{'loo'} objects will provide warnings
#' about problematic values of \eqn{k}. It is also possible to plot the values
#' of \eqn{k} by setting the optional argument \code{plot_k} to \code{TRUE} (the
#' default is not to plot). See \code{\link{print.loo}}.)}
#' }
#'
#' @seealso \code{\link{loo-package}}, \code{\link{print.loo}},
#' \code{\link{compare}}
#'
#' @examples
#' \dontrun{
#' log_lik1 <- extract_log_lik(stanfit1)
#' loo1 <- loo(log_lik1)
#' print(loo1, digits = 3)
#'
#' log_lik2 <- extract_log_lik(stanfit2)
#' loo2 <- loo(log_lik2)
#' loo2
#'
#' loo_diff <- compare(loo1, loo2)
#' loo_diff
#' print(loo_diff, digits = 5)
#' }
#'
loo <- function(log_lik, ...) {
  if (!is.matrix(log_lik))
    stop('log_lik should be a matrix')
  psis <- psisloo(log_lik, ...)
  pointwise <- pointwise_loo(log_lik, psis)
  out <- totals(pointwise)
  nms <- names(pointwise)
  names(out) <- c(nms, paste0("se_", nms))
  out$pointwise <- cbind_list(pointwise)
  out$pareto_k <- psis$pareto_k
  attr(out, "log_lik_dim") <- dim(log_lik)
  class(out) <- "loo"
  out
}