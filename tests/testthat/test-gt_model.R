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

test_that("A transformation function can be applied", {
  tbl <- gt_model(models, fn_transform = exp)
  tbl |> as_latex() |> expect_snapshot()
})

test_that("A custom estimation function can be used", {
  tbl1 <- gt_model(models)
  get_coef_lm <- function(model) {
    summary(model)$coef |>
      tibble::as_tibble(rownames = "term") |>
      dplyr::rename(estimate = Estimate, std.error = `Std. Error`,
                    statistic = `t value`, p.value = `Pr(>|t|)`)
  }
  tbl2 <- gt_model(models, fn_estimate = get_coef_lm)
  expect_equal(tbl1$`_data`, tbl2$`_data`)
})

test_that("A custom summary function can be used", {
  get_summary <- function(model) {
    broom::glance(model) |>
      dplyr::mutate(BIC.null = nobs * log(1-r.squared) + (nobs-df.residual) * log(nobs))
  }
  tbl <- gt_model(models, fn_summary = get_summary,
                  summary_stats = c("nobs", "BIC.null"))
  expect_equal(tbl$`_data`$variable[14], "summary:BIC.null")
})

test_that("Validation of digits argument is working", {
  expect_error(gt_model(models, digits = c(2, 3)),
               "The length of `digits` must be 1.")
  expect_error(gt_model(models, digits = NA),
               "The value for `digits` must not be `NA`.")
  expect_error(gt_model(models, digits = NULL),
               "The value for `digits` must not be `NULL`.")
  expect_error(gt_model(models, digits = -2),
               "The value for `digits` must be positive or zero.")
  expect_error(gt_model(models, digits = "a"),
               "Any input for `digits` must be numeric.")
})

test_that("Validation of sig_thresh argument is working", {
  expect_error(gt_model(models, sig_thresh = c(2, 3)),
               "The length of `sig_thresh` must be 1.")
  expect_error(gt_model(models, sig_thresh = NA),
               "The value for `sig_thresh` must not be `NA`.")
  expect_error(gt_model(models, sig_thresh = -2),
               "The value for `sig_thresh` must be greater than zero.")
  expect_error(gt_model(models, sig_thresh = "a"),
               "Any input for `sig_thresh` must be numeric.")
  tbl <- gt_model(models, sig_thresh = NULL)
  tbl |> as_latex() |> expect_snapshot()
})

test_that("Validation of summary_stats argument is working", {
  expect_error(gt_model(models, summary_stats = NA),
               "The values for `summary_stats` must not be `NA`.")
  expect_error(gt_model(models, summary_stats = c(1, 2)),
               "Any input for `summary_stats` must be character.")
})

test_that("Validation of var_labels argument is working", {
  expect_error(gt_model(models, var_labels = NA),
               "The values for `var_labels` must not be `NA`.")
  expect_error(gt_model(models, var_labels = c(1, 2)),
               "Any input for `var_labels` must be character.")
  expect_error(gt_model(models, var_labels = c("a", "b")),
               "The `var_labels` vector must be named.")
})

test_that("Validation of parenthetical_value argument is working", {
  expect_error(gt_model(models, parenthetical_value = c("a", "b")),
               "The length of `parenthetical_value` must be 1.")
  expect_error(gt_model(models, parenthetical_value = NULL),
               "The value for `parenthetical_value` must not be `NULL`.")
  expect_error(gt_model(models, parenthetical_value = NA),
               "The value for `parenthetical_value` must not be `NA`.")
  expect_error(gt_model(models, parenthetical_value = 1),
               "Any input for `parenthetical_value` must be character.")
  expect_warning(gt_model(models, parenthetical_value = "bob"),
                 "Parenthetical value not recognized. Defaulting to std.error.")
})

test_that("Validation of parenthesis_type argument is working", {
  expect_error(gt_model(models, parenthesis_type = c("a", "b")),
               "The length of `parenthesis_type` must be 1.")
  expect_error(gt_model(models, parenthesis_type = NULL),
               "The value for `parenthesis_type` must not be `NULL`.")
  expect_error(gt_model(models, parenthesis_type = NA),
               "The value for `parenthesis_type` must not be `NA`.")
  expect_error(gt_model(models, parenthesis_type = 1),
               "Any input for `parenthesis_type` must be character.")
  expect_warning(gt_model(models, parenthesis_type = "bob"),
                 "Parenthesis type not recognized. Defaulting to regular.")
})

test_that("Validation of beside argument is working", {
  expect_error(gt_model(models, beside = c(TRUE, TRUE)),
              "The length of `beside` must be 1.")
  expect_error(gt_model(models, beside = NULL),
               "The value for `beside` must not be `NULL`.")
  expect_error(gt_model(models, beside = NA),
               "The value for `beside` must not be `NA`.")
  expect_error(gt_model(models, beside = 1),
               "Any input for `beside` must be logical.")
})

test_that("Validation of groups argument is working", {
  expect_error(gt_model(models, groups = NA),
               "The values for `groups` must not be `NA`.")
  expect_error(gt_model(models, groups = c(1, 2)),
               "Any input for `groups` must be character.")
})

test_that("Validation of omit_var argument is working", {
  expect_error(gt_model(models, omit_var = NA),
               "The values for `omit_var` must not be `NA`.")
  expect_error(gt_model(models, omit_var = c(1, 2)),
               "Any input for `omit_var` must be character.")
})


