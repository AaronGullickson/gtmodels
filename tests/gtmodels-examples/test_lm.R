library(gt)
library(gtmodels)
library(tidyverse)
library(palmerpenguins)


model1 <- lm(bill_length_mm~flipper_length_mm, data=penguins)
model2 <- update(model1, .~.+body_mass_g)
model3 <- update(model2, .~.+sex)

models <- list(model1, model2, model3)

name_corr <- list("flipper_length_mm" = "Flipper length (mm)",
                  "body_mass_g" = "Body Mass (g)",
                  "sexmale" = "Male (ref. female)",
                  "BIC" = "Bayesian Information Criterion")

gt_model(models, digits=3, var_labels=name_corr, sig_thresh=c(0.05,0.01),
         summary_stats=c("rsquared","adj_rsquared","bic")) |>
  cols_label(model1="(1)", model2="(2)", model3="(3)") |>
  fmt_number(columns=starts_with("model"),
             rows="Bayesian Information Criterion",
             decimals=0) |>
  tab_source_note(md("*Note:* Standard errors are shown in parenthesis."))


model1 <- glm(sex~body_mass_g, data=penguins, family=binomial)
model2 <- update(model1, .~.+bill_length_mm)
model3 <- update(model2, .~.+flipper_length_mm)

models <- list(model1, model2, model3)

name_corr <- list("flipper_length_mm" = "Flipper length (mm)",
                  "body_mass_g" = "Body Mass (g)",
                  "bill_length_mm" = "Bill length (mm)")

gt_model(models, digits=3, var_labels=name_corr, sig_thresh=c(0.05,0.01, 0.001),
         summary_stats=c("bic", "deviance","loglik","pseudo_rsquared")) |>
  cols_label(model1="(1)", model2="(2)", model3="(3)") |>
  rows_add(variable="Null Deviance", model1=model1$null.deviance,
           model2=model2$null.deviance, model3=model3$null.deviance) |>
  fmt_number(columns=starts_with("model"),
             rows=c("BIC","Log-Likelihood","Deviance", "Null Deviance"),
             decimals=1) |>
  tab_source_note(md("*Note:* Standard errors are shown in parenthesis."))
