library(gt)
library(gtmodels)
library(palmerpenguins)

# lm ----------------------------------------------------------------------

model1 <- lm(mpg ~ hp, data = mtcars)
model2 <- update(model1, . ~ . + disp + wt)
model3 <- update(model2, . ~ . + as.factor(cyl))

name_corr <- c("(Intercept)" = "Constant",
               "hp" = "Horsepower",
               "disp" = "Displacement (cu. in.)",
               "wt" = "Weight (1000 lbs)",
               "as.factor(cyl)" = "Number of cylinders (ref. 4-cylinder)",
               "as.factor(cyl)6" = "6-cylinder",
               "as.factor(cyl)8" = "8-cylinder",
               "n" = "N",
               "rsquared" = "R-squared",
               "bic" = "BIC")

gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         digits=3,
         summary_stats = c("rsquared", "bic"),
         groups=c("as.factor(cyl)")) |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  fmt_number(rows = c("summary:bic"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis.")) |>
  tab_options(table.width = "100%")

# test beside
gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         digits=3,
         summary_stats = c("rsquared", "bic"),
         beside = TRUE,
         groups=c("as.factor(cyl)")) |>
  cols_label(model1_coef = "", model2_coef = "", model3_coef = "",
             model1_par = "(1)", model2_par = "(2)", model3_par = "(3)") |>
  fmt_number(rows = c("summary:bic"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis."))


# glm ---------------------------------------------------------------------

model1 <- glm(I(sex=="male")~body_mass_g+island, data=penguins, family=binomial)
model2 <- update(model1, .~.+bill_length_mm)
model3 <- update(model2, .~.+species)

name_corr <- c("(Intercept)" = "Intercept",
               "body_mass_g" = "Body mass (g)",
               "bill_length_mm" = "Bill length (mm)",
               "speciesChinstrap" = "Chinstrap",
               "speciesGentoo" = "Gentoo",
               "species" = "Species (ref. Adelie)",
               "n" = "N",
               "loglik" = "Log-likelihood",
               "deviance" = "Deviance",
               "pseudo_rsquared" = "Pseudo R-squared")

gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         omit_var = "island",
         summary_stats = c("loglik", "deviance", "pseudo_rsquared")) |>
  fmt_number(rows = c("summary:loglik", "summary:deviance"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis. All models include island fixed effects"))

