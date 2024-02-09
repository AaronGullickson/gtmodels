library(gt)
library(gtmodels)
library(palmerpenguins)


model1 <- lm(bill_length_mm~flipper_length_mm, data=penguins)
model2 <- update(model1, .~.+body_mass_g)
model3 <- update(model2, .~.+sex)

models <- list(model1, model2, model3)

name_corr <- list("flipper_length_mm" = "Flipper length (mm)",
                  "body_mass_g" = "Body Mass (g)",
                  "sexmale" = "Male (ref. female)")

gt_model(models, digits=3, var_labels=name_corr,
         sig_thresh=c(0.05,0.01)) |>
  tab_source_note("Note: Standard errors are shown in parenthesis.")
