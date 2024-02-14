library(gtmodels)
library(palmerpenguins)


model1 <- lm(mpg~hp, data=mtcars)
model2 <- update(model1, .~.+disp+wt)
model3 <- update(model2, .~.+as.factor(cyl))

name_corr <- c("Intercept" = "Constant",
               "hp" = "Horsepower",
               "disp" = "Displacement (cu. in.)",
               "wt" = "Weight (1000 lbs)",
               "as.factor\\(cyl\\)6" = "6-cylinder",
               "as.factor\\(cyl\\)8" = "8-cylinder",
               "rsquared" = "R-squared",
               "bic" = "BIC")

gt_model(list(model1, model2, model3),
         var_labels = name_corr,
         summary_stats=c("rsquared","bic")) |>
  cols_label(model1="(1)", model2="(2)", model3="(3)") |>
  fmt_number(rows = c("Constant","BIC"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis. Reference for cylinders is a 4-cylinder engine.")) |>
  tab_options(table.width = "100%")

model1 <- lm(bill_length_mm~flipper_length_mm, data=penguins)
model2 <- update(model1, .~.+body_mass_g)
model3 <- update(model2, .~.+sex)

models <- list(model1, model2, model3)

name_corr <- c("flipper_length_mm" = "Flipper Length (mm)",
                  "body_mass_g" = "Body Mass (g)",
                  "sexmale" = "Male (ref. female)",
                  "bic" = "BIC",
                  "rsquared" = "R-Squared",
                  "adj_rsquared" = "Adjusted R-Squared")

gt_model(models, digits=3, var_labels=name_corr,
         summary_stats=c("rsquared","adj_rsquared","bic")) |>
  cols_label(model1="(1)", model2="(2)", model3="(3)") |>
  fmt_number(columns=starts_with("model"),
             rows="BIC",
             decimals=0) |>
  tab_spanner(c(model1, model2, model3), label="Models") |>
  tab_source_note(md("*Note:* Standard errors are shown in parenthesis.")) |>
  opt_table_lines(extent = "none") |>
  tab_style(style = cell_borders(sides="top"),
            locations = list(cells_body(rows=9), cells_stub(rows=9))) |>
  tab_style(style = cell_borders(sides="bottom"),
            locations = list(cells_body(rows=12), cells_stub(rows=12))) |>
  tab_style(style = cell_borders(sides="top"),
            locations = list(cells_body(rows=1), cells_stub(rows=1))) |>
  tab_style(style = cell_borders(sides="left"),
            locations = cells_body(columns=model1))


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

# |>
#   tab_options(table.width = pct(100)) |>
#   #opt_table_lines(extent = "none") |>
#   tab_style(style = cell_borders(sides="top", weight = px(1.5)),
#             locations = cells_stub(rows=9)) |>
#   tab_style(style = cell_borders(sides="top", weight = px(1.5)),
#             locations = cells_body(rows=9)) |>
#   tab_options(table_body.border.bottom.color = "black",
#               table_body.border.top.color = "black",
#               stub.border.color = "black",
#               table_body.hlines.color = "white",
#               table.border.bottom.color = "white",
#               column_labels.border.bottom.width = "black",
#               row_group.border.top.color = "red",
#               stub_row_group.border.color = "red",
#               footnotes.border.bottom.color = "red",
#               footnotes.border.lr.color = "red")



