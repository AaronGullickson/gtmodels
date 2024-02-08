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

  # extract summary statistics
  tbl_summary <- models |>
    map(extract_summary) |>
    bind_rows()

  # combine
  tbl <- bind_cols(tbl_coef, tbl_summary)

  # transpose the table and get it back in tibble form
  var_names <- c(paste("var_", colnames(tbl_coef), sep=""),
                 paste("summary_", colnames(tbl_summary), sep=""))
  tbl <- tbl |>
    t() |>
    as.data.frame() |>
    as_tibble()

  tbl <- bind_cols(variables=var_names, tbl) |>
    rename_with(~gsub("V", "model", .x))

  return(tbl)
}

tbl <- construct_table(list(model1, model2, model3))

tbl |>
  gt(rowname_col = "variables") |>
  cols_label_with(starts_with("model"), fn = ~ gsub("model", "Model ", .)) |>
  fmt_number(starts_with("model"), rows=starts_with("var"), decimals = digits) |>
  fmt_number(starts_with("model"), rows = matches("n$"), decimals = 0, use_seps=TRUE) |>
  fmt_number(starts_with("model"), rows = matches("R\\^2"), decimals = 3) |>
  sub_missing(missing_text = "")
