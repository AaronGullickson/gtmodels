library(gt)
library(gtmodels)
library(palmerpenguins)
library(margins)
library(lmtest)
library(sandwich)
library(AER)
library(survey)
library(survival)

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
               "nobs" = "N",
               "r.squared" = "R-squared",
               "BIC" = "BIC")

gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         digits=3,
         summary_stats = c("r.squared", "BIC"),
         groups=c("as.factor(cyl)")) |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  fmt_number(rows = c("summary:BIC"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis.")) |>
  tab_options(table.width = "100%")

# test beside
gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         digits=3,
         summary_stats = c("r.squared", "BIC"),
         beside = TRUE,
         groups=c("as.factor(cyl)")) |>
  cols_label(model1_coef = "", model2_coef = "", model3_coef = "",
             model1_par = "(1)", model2_par = "(2)", model3_par = "(3)") |>
  fmt_number(rows = c("summary:BIC"), decimals = 1) |>
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
               "nobs" = "N",
               "logLik" = "Log-likelihood",
               "deviance" = "Deviance",
               "pseudo_rsquared" = "Pseudo R-squared")

gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         omit_var = "island",
         summary_stats = c("logLik", "deviance"),
         groups = "species") |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  fmt_number(rows = c("summary:logLik", "summary:deviance"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis. All models include island fixed effects"))


# try exponentiating results
gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         omit_var = "island",
         summary_stats = c("logLik", "deviance"),
         groups = "species",
         exponentiate = TRUE) |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  fmt_number(rows = c("summary:logLik", "summary:deviance"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis. All models include island fixed effects"))


# margins -----------------------------------------------------------------

models <- lapply(list(model1, model2, model3), margins)

gt_model(lapply(list(model1, model2, model3), margins),
         var_labels = name_corr,
         omit_var = "island",
         groups = "species") |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis. All models include island fixed effects"))


# lmtest ------------------------------------------------------------------

data(Affairs, package = 'AER')

model1 <- glm(affairs~I(age-40)+I((age-40)^2)+gender, data=Affairs,
              family=poisson)
model2 <- update(model1, .~.+yearsmarried+children)
model3 <- update(model2, .~.+religiousness)

name_corr <- c("(Intercept)" = "Intercept",
               "I(age - 40)" = "Age (centered 40)",
               "I((age - 40)^2)" = "Age squared",
               "gendermale" = "Male",
               "yearsmarried" = "Years married",
               "childrenyes" = "Have children",
               "religiousness" = "Religiousness",
               "n" = "N")

gt_model(list(model1, model2, model3),
         var_labels = name_corr) |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis."))

gt_model(lapply(list(model1, model2, model3),
                function(model){coeftest(model, vcov = vcovHC(model, "HC1"))}),
         var_labels = name_corr) |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  tab_source_note(md("*Notes:* Robust standard errors shown in parenthesis."))

# svyglm -----------------------------------------------------------------

data(api)
dstrat <- svydesign(id=~1, strata=~stype, weights=~pw, data=apistrat, fpc=~fpc)

model1 <- svyglm(api00~ell, design=dstrat)
model2 <- update(model1, .~.+meals)
model3 <- update(model2, .~.+mobility)

gt_model(list(model1, model2, model3))


# survival ----------------------------------------------------------------

model1 <- clogit(case~spontaneous+strata(stratum), data=infert)
model2 <- update(model1, .~.+induced)

gt_model(list(model1, model2))

