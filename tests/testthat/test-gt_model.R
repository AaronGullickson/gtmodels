# create some models for testing

# build some testing data
model1 <- lm(mpg ~ hp, data = mtcars)
model2 <- update(model1, . ~ . + disp + wt)
model3 <- update(model2, . ~ . + as.factor(cyl))
models <- list(model1, model2, model3)
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

test_that("The output of a basic gt_model is as expected", {
  tbl <- gt_model(models)
  expect_s3_class(tbl, "gt_tbl")
  tbl |> as_latex() |> expect_snapshot()
})

test_that("Additional summary statistics can be added", {
  tbl <- gt_model(models, summary_stats = c("r.squared", "BIC"))
  expect_equal(tbl$`_data`$variable[14:15],
               c("summary:r.squared", "summary:BIC"))
})

test_that("Rounding digits works as expected", {
  tbl <- gt_model(models, digits = 2)
  tbl |> as_latex() |> expect_snapshot()
})

test_that("Variable labels are correctly applied", {
  tbl <- gt_model(models, var_labels = name_corr)
  tbl |> as_latex() |> expect_snapshot()
})

test_that("Variables can be omitted", {
  tbl <- gt_model(models, omit_var = c("hp", "wt"))
  expect_equal("hp" %in% tbl$`_data`$variable, FALSE)
  expect_equal("wt" %in% tbl$`_data`$variable, FALSE)
})

test_that("Group rows can be added", {
  tbl <- gt_model(models, groups = c("as.factor(cyl)"))
  expect_equal("grp:as.factor(cyl)" %in% tbl$`_data`$variable, TRUE)
})

test_that("Parenthetical value can be changed", {
  tbl <- gt_model(models, parenthetical_value = "statistic")
  tbl |> as_latex() |> expect_snapshot()
  tbl <- gt_model(models, parenthetical_value = "p.value")
  tbl |> as_latex() |> expect_snapshot()
})

test_that("Parenthetical type can be changed", {
  tbl <- gt_model(models, parenthesis_type = "square")
  tbl |> as_latex() |> expect_snapshot()
  tbl <- gt_model(models, parenthesis_type = "curly")
  tbl |> as_latex() |> expect_snapshot()
})

test_that("Wrong parenthetical value leads to warning", {
  expect_warning(gt_model(models, parenthetical_value = "bob"),
                 "Parenthetical value not recognized. Defaulting to std.error.")
})

test_that("Wrong parenthetical type leads to warning", {
  expect_warning(gt_model(models, parenthesis_type = "bob"),
                 "Parenthesis type not recognized. Defaulting to regular.")
})
