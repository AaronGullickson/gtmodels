# variety of functions to extract data from model objects

#### Variable specific information ####

extract_coef <- function(model) {
  if("margins" %in% class(model)) {
    x <- summary(model)$AME
    names(x) <- summary(model)$factor
    return(x)
  } else {
    # we default to lm
    return(coef(model))
  }
}

extract_se <- function(model) {
  if("margins" %in% class(model)) {
    x <- summary(model)$SE
    names(x) <- summary(model)$factor
    return(x)
  } else {
    # we default to lm
    return(summary(model)$coef[, 2])
  }
}

extract_tstat <- function(model) {
  if("margins" %in% class(model)) {
    x <- summary(model)$z
    names(x) <- summary(model)$factor
    return(x)
  } else {
    # we default to lm
    return(summary(model)$coef[, 3])
  }
}

extract_pvalue <- function(model) {
  if("margins" %in% class(model)) {
    x <- summary(model)$p
    names(x) <- summary(model)$factor
    return(x)
  } else {
    # we default to lm
    return(summary(model)$coef[, 4])
  }
}

#### Summary statistics ####

extract_summary <- function(model, summary_stats = NULL) {
  # always include sample size
  if("margins" %in% class(model)) {
    n <- length(na.omit(model$fitted))
  } else {
    n <- length(model$residuals)
  }
  sum_stats <- c("n" = n)

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
