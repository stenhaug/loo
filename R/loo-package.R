#' Efficient LOO-CV and WAIC for Bayesian models
#'
#' @docType package
#' @name loo-package
#'
#' @importFrom stats sd var quantile setNames weights rnorm
#' @importFrom matrixStats logSumExp colLogSumExps colSums2 colVars
#'
#' @description
#' \if{html}{
#'   \figure{stanlogo.png}{options: width="50px" alt="mc-stan.org"}
#'   \emph{Stan Development Team}
#' }
#'
#' This package implements the methods described in Vehtari, Gelman, and Gabry
#' (2017a, 2017b) and Yao et al. (2018). To get started see the \pkg{loo}
#' package vignettes
#' \href{https://mc-stan.org/loo/articles/index.html}{vignettes},
#' \code{\link{loo}} function for efficient approximate leave-one-out
#' cross-validation (LOO-CV), the \code{\link{psis}} function for the Pareto
#' smoothed importance sampling (PSIS) algorithm, or
#' \code{\link{loo_model_weights}} for an implementation of Bayesian stacking of
#' predictive distributions from multiple models.
#'
#'
#' @details Leave-one-out cross-validation (LOO-CV) and the widely applicable
#'   information criterion (WAIC) are methods for estimating pointwise
#'   out-of-sample prediction accuracy from a fitted Bayesian model using the
#'   log-likelihood evaluated at the posterior simulations of the parameter
#'   values. LOO-CV and WAIC have various advantages over simpler estimates of
#'   predictive error such as AIC and DIC but are less used in practice because
#'   they involve additional computational steps. This package implements the
#'   fast and stable computations for approximate LOO-CV laid out in Vehtari,
#'   Gelman, and Gabry (2017a). From existing posterior simulation draws, we
#'   compute LOO-CV using Pareto smoothed importance sampling (PSIS; Vehtari,
#'   Gelman, and Gabry, 2017b), a new procedure for regularizing and diagnosing
#'   importance weights. As a byproduct of our calculations, we also obtain
#'   approximate standard errors for estimated predictive errors and for
#'   comparing of predictive errors between two models.
#'
#'   We recommend PSIS-LOO-CV instead of WAIC, because PSIS provides useful
#'   diagnostics and effective sample size and Monte Carlo standard error
#'   estimates.
#'
#'
#' @template loo-and-psis-references
#' @template stacking-references
#'
#' @references
#' Epifani, I., MacEachern, S. N., and Peruggia, M. (2008). Case-deletion
#' importance sampling estimators: Central limit theorems and related results.
#' \emph{Electronic Journal of Statistics} \strong{2}, 774-806.
#'
#' Gelfand, A. E. (1996). Model determination using sampling-based methods. In
#' \emph{Markov Chain Monte Carlo in Practice}, ed. W. R. Gilks, S. Richardson,
#' D. J. Spiegelhalter, 145-162. London: Chapman and Hall.
#'
#' Gelfand, A. E., Dey, D. K., and Chang, H. (1992). Model determination using
#' predictive distributions with implementation via sampling-based methods. In
#' \emph{Bayesian Statistics 4}, ed. J. M. Bernardo, J. O. Berger, A. P. Dawid,
#' and A. F. M. Smith, 147-167. Oxford University Press.
#'
#' Gelman, A., Hwang, J., and Vehtari, A. (2014). Understanding predictive
#' information criteria for Bayesian models. \emph{Statistics and Computing}
#' \strong{24}, 997-1016.
#'
#' Ionides, E. L. (2008). Truncated importance sampling. \emph{Journal of
#' Computational and Graphical Statistics} \strong{17}, 295-311.
#'
#' Koopman, S. J., Shephard, N., and Creal, D. (2009). Testing the assumptions
#' behind importance sampling. \emph{Journal of Econometrics} \strong{149}, 2-11.
#'
#' Peruggia, M. (1997). On the variability of case-deletion importance sampling
#' weights in the Bayesian linear model. \emph{Journal of the American
#' Statistical Association} \strong{92}, 199-207.
#'
#' Stan Development Team (2017). The Stan C++ Library, Version 2.17.0.
#' \url{http://mc-stan.org}.
#'
#' Stan Development Team (2018). RStan: the R interface to Stan, Version 2.17.3.
#' \url{http://mc-stan.org}.
#'
#' Watanabe, S. (2010). Asymptotic equivalence of Bayes cross validation and
#' widely application information criterion in singular learning theory.
#' \emph{Journal of Machine Learning Research} \strong{11}, 3571-3594.
#'
#' Zhang, J., and Stephens, M. A. (2009). A new and efficient estimation method
#' for the generalized Pareto distribution. \emph{Technometrics} \strong{51},
#' 316-325.
#'
NULL
