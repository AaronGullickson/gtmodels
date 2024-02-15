library(gt)
library(gtmodels)
library(palmerpenguins)


model1 <- lm(mpg ~ hp, data = mtcars)
model2 <- update(model1, . ~ . + disp + wt)
model3 <- update(model2, . ~ . + as.factor(cyl))

name_corr <- c("(Intercept)" = "Constant",
               "hp" = "Horsepower",
               "disp" = "Displacement (cu. in.)",
               "wt" = "Weight (1000 lbs)",
               "as.factor(cyl)6" = "6-cylinder",
               "as.factor(cyl)8" = "8-cylinder",
               "n" = "N",
               "rsquared" = "R-squared",
               "bic" = "BIC")

gt_model(list(model1, model2, model3), var_labels = name_corr,
         summary_stats = c("rsquared", "bic")) |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  fmt_number(rows = c("summary:bic"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis.")) |>
  tab_options(table.width = "100%")

gt_model(list(model1, model2, model3), var_labels = name_corr,
         summary_stats = c("rsquared", "bic"),
         beside = TRUE) |>
  cols_label(model1_coef = "", model2_coef = "", model3_coef = "",
             model1_se = "(1)", model2_se = "(2)", model3_se = "(3)") |>
  fmt_number(rows = c("summary:bic"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis."))
