#' Create a **gt** table from multiple model results
#'
#' @description
#'
#' The `gt_model()` function outputs a list of models as a [gt] table for
#' display in Quarto, R Markdown, or other formats. Further **gt**
#' transformations can be applied to the created table.
#'
#' @details
#'
#' This function can be used to create a [gt] table of model (i.e. regression)
#' results using a format common in many scientific fields. Multiple models can
#' be included in the table by feeding in a list of model objects. The most
#' common intended use of this function is within a Quarto document where the
#' output will be displayed nicely in the final output.
#'
#' Model output is extracted via the
#' [broom](https://broom.tidymodels.org/index.html) package. You can see a full
#' list of models with methods available in `broom`
#' [here](https://broom.tidymodels.org/articles/available-methods.html). Some
#' complex model types that return other elements besides estimates,
#' standard errors, and p.values may not work correctly.
#'
#' For model classes without corresponding [broom] methods, the user may specify
#' the `fn_estimate` and `fn_summary` arguments to supply custom functions that
#' extract this information from the model object in a manner analogous to
#' [broom::tidy] and [broom::glance], respectively.
#'
#' Because the returned object is a `gt_tbl`, it can be further refined to the
#' user's tastes by piping it into subsequent [gt] commands.
#'
#' It may be useful to consider the table anatomy and underlying row and column
#' labels that underly the outputted model. The general anatomy is:
#'
#' | <stubhead_label>    | model1 | model2 | model3 |
#' |:--------------------|-------:|-------:|-------:|
#' | coef:var_name1      | ...    | ...    | ...    |
#' | par:var_name1       | (...)  | (...)  | (...)  |
#' | coef:var_name2      | ...    | ...    | ...    |
#' | par:var_name2       | (...)  | (...)  | (...)  |
#' | grp:var_name3       |        |        |        |
#' | coef:var_name3Yes   | ...    |  ...   | ...    |
#' | par:var_name3No     | (...)  | (...)  | (...)  |
#' | coef:var_name3Yes   | ...    | ...    | ...    |
#' | par:var_name3No     | (...)  | (...)  | (...)  |
#'
#' The returned table uses a "stub" column for the variable and summary
#' statistics labels. All model columns will be named as `modelX` where X is the
#' index of the model (e.g. model1, model2). Users can rename the models with a
#' `cols_label` command.
#'
#' All rows have a label prefix that can be used to identify sets of rows or
#' particular rows. Each row label begins with either `coef:`, `par:`,
#' `summary:`, or `grp:` depending on whether it is a model coefficient,
#' parenthetical value, summary statistic, or variable group row, respectively.
#' This is followed by either the name of the variable in R or the name of the
#' summary statistic. By default, the function hides the stub labels for the
#' `par:` rows. Other stub labels can be renamed by the `var_labels` argument
#' which takes a named character vector that provides the correspondence between
#' original and new variable names (see examples below).
#'
#' Even if variables/summary statistics, have been renamed the stub labels can
#' still be used to identify particular rows or groups of rows. For example, to
#' change the rounding on all coefficient values:
#'
#' ```r
#'  gt_model(...) |>
#'    fmt_number(rows=matches("^coef:"), decimals=5)
#' ```
#'
#' If the `beside=TRUE` argument is used, the table will have a somewhat different
#' format:
#'
#' | <stubhead_label>    | model1_coef | model1_par | model2_coef | model2_par | model3_coef | model3_par |
#' |:--------------------|------------:|-----------:|------------:|-----------:|------------:|-----------:|
#' | coef:var_name1      | ...         | (...)      | ...         | (...)      | ...         | (...)      |
#' | coef:var_name2      | ...         | (...)      | ...         | (...)      | ...         | (...)      |
#' | grp:var_name3       |             |            |             |            |             |            |
#' | coef:var_name3Yes   | ...         | (...)      | ...         | (...)      | ...         | (...)      |
#' | coef:var_name3Yes   | ...         | (...)      | ...         | (...)      | ...         | (...)      |
#'
#' Parenthetical values are applied in different columns rather than rows in
#' this format, which makes wider but shorter tables if that is desirable. It is
#' recommended to use the columns ending in "_par" to label models and make the
#' "_coef" columns unlabeled for final display. For example, in a table with 3
#' models as above:
#'
#' ```r
#' gt_model(...) |>
#'   cols_label(model1_coef = "", model2_coef = "", model3_coef = "",
#'              model1_par = "(1)", model2_par = "(2)", model3_par = "(3)")
#' ```
#'
#' @param models *List of models*
#'
#'  `list` // **required**
#'
#'   A `list` of models of the same type. These models either must have
#'   [broom::tidy] and [broom::glance] methods, or the user must specify custom
#'   estimate and summary statistic extraction functions using `fn_estimate` and
#'   `fn_summary` arguments.
#'
#' @param digits *Number of rounding digits*
#'
#'   `scalar<numeric>` // *default:* `3`
#'
#'   Indicates the number of decimals to use when rounding numbers in the table.
#'   This can be overridden for particular columns, rows, or cells after table
#'   with [gt::fmt_number].
#'
#' @param sig_thresh *Significance threshold*
#'
#'   `scalar<numeric>` // *default:* `0.05`
#'
#'   A numeric value indicating the threshold for statistical significance. An
#'   asterisks will be placed on all coefficients with a p-value lower than the
#'   threshold. If `NULL`, asterisks will not be printed.
#'
#' @param summary_stats *Summary statistics*
#'
#'   `vector<character>` // *default:* `NULL` (`optional`)
#'
#'   A vector of character strings indicating desired summary statistics to
#'   place at the bottom of the table. The names must match summary statistic
#'   names produced by [broom::glance] when applied to a model of this type. The
#'   number of observations will always be reported, even if this argument is
#'   null.
#'
#' @param var_labels *Variable labels for display*
#'
#'   `vector<character>` // *default:* `c(nobs = "N")`
#'
#'   A named character vector indicating display labels for the row stub. Names
#'   should correspond the actual variable name in the R model output without
#'   the `:` prefix  for variables, or summary statistic names from
#'   [broom::glance] for summary statistics.
#'
#' @param parenthetical_value *Parenthetical value type*
#'
#'   `scalar<character>` // *default:* `std.error`
#'
#'   A character string of either "std.error", "statistic" (e.g. test
#'   statistic), or "p.value" indicating what parenthetical value to include in
#'   parenthesis.
#'
#' @param parenthesis_type *Parenthesis type*
#'
#'   `scalar<character>` // *default:* `regular`
#'
#'   A character string of either "regular", "square", or "curly" indicating the
#    type of parenthesis to use for parenthetical values.
#'
#' @param beside *Place parenthetical values beside rather than below*
#'
#'   `scalar<logical>` // *default:* `FALSE`
#'
#'   Should parenthetical values be reported in separate columns beside
#'   coefficients, rather than below?
#'
#' @param groups *Identify variables belonging to the same group*
#'
#'   `vector<character>` // *default:* `NULL` (`optional`)
#'
#'   A character vector indicating the variable name for variables that should
#'   be grouped together under a heading row (e.g. for categorical variables).
#'   This will generally be the name of the factor variable that creates the
#'   individual dummy variables in the model.
#'
#' @param omit_var *Identify variables to omit from the table*
#'
#'   `vector<character>` // *default:* `NULL` (`optional`)
#'
#'   A character vector indicating variable names for variables that should be
#'   omitted from the final table.
#'
#' @param fn_transform *Transform coefficients with a function*
#'
#'   `function` // *default:* `NULL` (`optional`)
#'
#'   A function (e.g. `exp`) that will be used to transform the coefficients for
#'   the model for the final output.
#'
#' @param fn_estimate *Custom function to extract model estimates*
#'
#'   `function` // *default:* `NULL` (`optional`)
#'
#'   A user-supplied custom function to extract
#'   variable-specific estimates from the supplied model object. This can be
#'   useful if the model has no existing method in [broom]. The returned object
#'   should be a [tibble] of the same type as returned from [broom::tidy]. Each
#'   row should be for a given independent variables with columns for `term`
#'   (for variable name), `estimate` (for coefficient value), `std.error`,
#'   `statistic` (for test statistic), and `p.value`.
#'
#' @param fn_summary *Custom function to extract model summary statistics*
#'
#'   `function` // *default:* `NULL` (`optional`)
#'
#'   A user-supplied custom function to extract additional
#'   summary statistics from the supplied model object. These additional summary
#'   statistics can then be added via the `summary_stats` argument. This can be
#'   used to add custom summary statistics not available in [broom::glance] or
#'   if no existing method exists in [broom] for this type of model object. The
#'   returned object should be a [tibble] of the same type as returned from
#'   [broom::glance]. It should have only one row, and any desired summary
#'   statistics should be included as columns. In many cases, the output from
#'   [broom::glance] can be augmented in this function with additional
#'   information. See below for an example of this approach for pseudo-R-squared
#'   in a logit model.
#'
#' @return `gt_model` returns a `gt_tbl` object that can be further processed
#'   using various commands from the [gt] package.
#'
#' @examples
#' if (require("gt")) {
#'
#' # Linear model output -----------------------------------------------------
#'   model1 <- lm(mpg ~ hp, data = mtcars)
#'   model2 <- update(model1, . ~ . + disp + wt)
#'   model3 <- update(model2, . ~ . + as.factor(cyl))
#'
#'   name_corr <- c("(Intercept)" = "Constant",
#'                  "hp" = "Horsepower",
#'                  "disp" = "Displacement (cu. in.)",
#'                  "wt" = "Weight (1000 lbs)",
#'                  "as.factor(cyl)" = "Number of cylinders (ref. 4-cylinder)",
#'                  "as.factor(cyl)6" = "6-cylinder",
#'                  "as.factor(cyl)8" = "8-cylinder",
#'                  "nobs" = "N",
#'                  "r.squared" = "R-squared",
#'                  "BIC" = "BIC")
#'
#'   gt_model(list(model1, model2, model3), var_labels = name_corr,
#'            summary_stats = c("r.squared", "BIC"),
#'            groups=c("as.factor(cyl)")) |>
#'     cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
#'     fmt_number(rows = c("summary:BIC"), decimals = 1) |>
#'     tab_source_note(md("*Notes:* Standard errors shown in parenthesis.")) |>
#'     tab_options(table.width = "100%")
#'
#' # Custom summary for logit model -------------------------------------------
#'   model1 <- glm(case ~ spontaneous+induced, data = infert,
#'                 family = binomial())
#'   model2 <- update(model1, .~.+age+parity)
#'   model3 <- update(model2, .~.+education)
#'
#'   name_corr <- c("(Intercept)" = "Intercept",
#'                  "spontaneous" = "Prior spontaneous abortions",
#'                  "induced" = "Prior induced abortions",
#'                  "age" = "Age",
#'                  "parity" = "Parity",
#'                  "education" = "Education (ref. less than 6 years)",
#'                  "education6-11yrs" = "6-11 years",
#'                  "education12+ yrs" = "12 or more years",
#'                  "nobs" = "N",
#'                  "deviance" = "Deviance",
#'                  "pseudo.rsquared" = "Pseudo R-squared")
#'
#'   get_summary_logit <- function(model) {
#'     broom::glance(model) |>
#'       dplyr::mutate(pseudo.rsquared = (null.deviance - deviance)/null.deviance)
#'   }
#'
#'   gt_model(list(model1, model2, model3),
#'            var_labels = name_corr,
#'            groups = "education",
#'            fn_summary = get_summary_logit,
#'            summary_stats = c("deviance", "pseudo.rsquared")) |>
#'     cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
#'     fmt_number(rows = "summary:deviance", decimals = 1) |>
#'     tab_source_note(md("*Notes:* Standard errors shown in parenthesis."))
#' }
#' @import gt
#' @export
gt_model <- function(models,
                     digits = 3,
                     sig_thresh = 0.05,
                     summary_stats = NULL,
                     var_labels = c("nobs" = "N"),
                     parenthetical_value = "std.error",
                     parenthesis_type = "regular",
                     beside = FALSE,
                     groups = NULL,
                     omit_var = NULL,
                     fn_transform = NULL,
                     fn_estimate = NULL,
                     fn_summary = NULL) {


  # Check input -------------------------------------------------------------

  validate_digits(digits)
  validate_sig_thresh(sig_thresh)
  validate_summary_stats(summary_stats)
  validate_var_labels(var_labels)
  parenthetical_value <- validate_parenthetical_value(parenthetical_value)

  # Build tibble from models ------------------------------------------------

  tbl <- build_tbl(models = models,
                   summary_stats = summary_stats,
                   parenthetical_value = parenthetical_value,
                   beside = beside,
                   fn_transform = fn_transform,
                   fn_estimate = fn_estimate,
                   fn_summary = fn_summary)

  # omit variables
  tbl <- tbl |>
    omit_variables(omit_var)

  # add groups
  tbl <- tbl |>
    add_groups(groups)

  # Construct the gt table --------------------------------------------------

  tbl_gt_model <- construct_tbl_gt(tbl = tbl,
                                   digits = digits,
                                   parenthesis_type = parenthesis_type,
                                   beside = beside)

  # change variable labels
  tbl_gt_model <- tbl_gt_model |>
    replace_var_labels(var_labels)

  # indent group variables
  tbl_gt_model <- tbl_gt_model |>
    apply_group_indents(groups)

  # add asterisks
  if (!is.null(sig_thresh)) {
    tbl_gt_model <- tbl_gt_model |>
      apply_asterisks(models = models,
                      sig_thresh = sig_thresh,
                      beside = beside,
                      omit_var = omit_var,
                      fn_estimate = fn_estimate)
  }

  return(tbl_gt_model)
}

