library(gt)
library(tidyverse)
library(palmerpenguins)

model1 <- lm(bill_length_mm~flipper_length_mm, data=penguins)
model2 <- update(model1, .~.+body_mass_g)
model3 <- update(model2, .~.+sex)

models <- list(model1, model2, model3)


construct_model_table <- function(models, digits=3) {

  tbl <- models |>
    map(coef) |>
    bind_rows() |>
    t()

  # now convert back to a tibble
  var_names <- rownames(tbl)
  tbl <- tbl |>
    as.data.frame() |>
    as_tibble()

  tbl <- bind_cols(variables=var_names, tbl) |>
    rename_with(~gsub("V", "model", .x))
}

tbl |>
  gt() |>
  cols_label(variables = "Variables") |>
  cols_label_with(starts_with("model"), fn = ~ gsub("model", "Model ", .)) |>
  fmt_number(starts_with("model"), decimals = digits) |>
  sub_missing(missing_text = "")
