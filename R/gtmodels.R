library(gt)
library(tidyverse)
library(palmerpenguins)

model1 <- lm(bill_length_mm~flipper_length_mm, data=penguins)
model2 <- update(model1, .~.+body_mass_g)
model3 <- update(model2, .~.+sex)

models <- list(model1, model2, model3)

digits <- 3

extract_summary <- function(model) {
  n <- length(model1$fitted.values)
  r.squared <- summary(model)$r.squared
  return(c("N" = n, "$$R^2$$"=r.squared))
}

extract_se <- function(model) {
  summary(model)$coef[,2]
}

extract_pvalue <- function(model) {
  summary(model)$coef[,4]
}

construct_table <- function(models) {

  # extract coefficients
  tbl_coef <- models |>
    map(coef) |>
    bind_rows()

  # extract standard errors
  tbl_se <- models |>
    map(extract_se) |>
    bind_rows()

  # extract summary statistics
  tbl_summary <- models |>
    map(extract_summary) |>
    bind_rows()

  # get variable names for later
  var_names <- colnames(tbl_coef)
  summary_names <- colnames(tbl_summary)

  # transpose both tables and convert back to tibbles
  tbl_coef <- tbl_coef |>
    t() |>
    as.data.frame() |>
    as_tibble() |>
    mutate(type="coef", variable=var_names)

  tbl_se <- tbl_se |>
    t() |>
    as.data.frame() |>
    as_tibble() |>
    mutate(type="se", variable=var_names)

  tbl_combined <- bind_rows(tbl_coef, tbl_se) |>
    arrange(variable, type) |>
    select(!type) |>
    select(variable, everything())

  tbl_summary <- tbl_summary |>
    t() |>
    as.data.frame() |>
    as_tibble() |>
    mutate(variable=summary_names) |>
    select(variable, everything())

  # combine
  tbl <- bind_rows(tbl_combined, tbl_summary)

  # change names for reference
  tbl <- tbl |>
    rename_with(~gsub("V", "model", .x))

  var_indx <- seq(from=1, by=2, length.out=length(var_names))
  se_indx <- seq(from=2, by=2, length.out=length(var_names))
  tbl$variable[var_indx] <- paste("var", tbl$variable[var_indx], sep="_")
  tbl$variable[se_indx] <- paste("se", tbl$variable[se_indx], sep="_")

  return(tbl)
}

tbl <- construct_table(list(model1, model2, model3))

tbl |>
  gt(rowname_col = "variable") |>
  cols_label_with(starts_with("model"), fn = ~ gsub("model", "Model ", .)) |>
  fmt_number(starts_with("model"), rows=starts_with("var"), decimals = digits) |>
  fmt_number(starts_with("model"), rows=starts_with("se"), decimals = digits, pattern="({x})") |>
  fmt_number(starts_with("model"), rows = matches("N$"), decimals = 0, use_seps=TRUE) |>
  fmt_number(starts_with("model"), rows = matches("R\\^2"), decimals = 3) |>
  sub_missing(missing_text = "")
