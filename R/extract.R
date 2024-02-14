# variety of functions to extract data from model objects

extract_se <- function(model) {
  summary(model)$coef[, 2]
}

extract_pvalue <- function(model) {
  summary(model)$coef[, 4]
}

extract_summary <- function(model, summary_stats = NULL) {
  # always include sample size
  n <- length(model$residuals)
  sum_stats <- c("N" = n)

  if ("rsquared" %in% summary_stats) {
    sum_stats <- c(sum_stats, "rsquared" = extract_rsquared(model))
  }
  if ("pseudo_rsquared" %in% summary_stats) {
    sum_stats <- c(sum_stats, "pseudo_rsquared" = extract_pseudo_rsquared(model))
  }
  if ("adj_rsquared" %in% summary_stats) {
    sum_stats <- c(sum_stats, "adj_rsquared" = extract_adj_rsquared(model))
  }
  if ("bic" %in% summary_stats) {
    sum_stats <- c(sum_stats, "bic" = extract_bic(model))
  }
  if ("loglik" %in% summary_stats) {
    sum_stats <- c(sum_stats, "loglik" = extract_loglik(model))
  }
  if ("deviance" %in% summary_stats) {
    sum_stats <- c(sum_stats, "deviance" = extract_deviance(model))
  }

  return(sum_stats)
}

extract_rsquared <- function(model) {
  summary(model)$r.squared
}

extract_adj_rsquared <- function(model) {
  summary(model)$adj.r.squared
}

extract_bic <- function(model) {
  BIC(model)
}

extract_deviance <- function(model) {
  deviance(model)
}

extract_loglik <- function(model) {
  as.numeric(logLik(model))
}

extract_pseudo_rsquared <- function(model) {
  (model$null.deviance - model$deviance) / model$null.deviance
}
