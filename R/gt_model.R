#' Generates a table from model results using the `gt` library.
#'
#' `gt_model` outputs a list of models as a [gt] table for display in Quarto,
#' R Markdown, or other formats.
#'
#' This function can be used to create a [gt] table of model (i.e. regression) results
#' using a format common in many scientific fields. Multiple models can be included in the table
#' by feeding in a list of model objects. The most common intended use of this function is within
#' a Quarto document where the output will be displayed nicely in the final output.
#'
#' Model output is extracted via the [broom](https://broom.tidymodels.org/index.html)
#' package. You can see a full list of models with methods available in `broom`
#' [here](https://broom.tidymodels.org/articles/available-methods.html). Some complex model
#' types that don't return other elements besides basic estimates, standard errors, etc. may
#' not work correctly.
#'
#' For model classes without corresponding [broom] methods, the user may use the
#' `fn_estimate` and `fn_summary` arguments to supply custom functions that extract
#' this information from the model object in a manner analogous to [broom::tidy] and
#' [broom::glance], respectively.
#'
#' Because the returned object is a `gt_tbl`, it can be further refined to the user's
#' tastes by piping it into subsequent [gt] commands.
#'
#' The returned table uses a "stub" column for the variable and summary statistics labels. All
#' model columns will be named as `modelX` where X is the index of the model (e.g. model1, model2).
#' Users can rename the models with a `cols_label` command. Variables and summary statistics
#' can be renamed by the `var_labels` argument which takes a named character vector that
#' provides the correspondence between original and new variable names (see examples below).
#'
#' All rows have a label prefix that can be used to identify sets of rows or particular rows.
#' Each row label begins with either "coef:", "par:", "summary:", or "grp:" depending on whether it is
#' a model coefficient, parenthetical value, summary statistic, or variable group row, respectively. This is followed by either the
#' name of the variable in R or the name of the summary statistic. These labels will still apply
#' even if the `var_labels` argument has been used for different labeling in the printed table.
#' User can use this to access specific rows or types of rows. For example, to change the
#' rounding on all coefficient values:
#'
#' ```r
#'  gt_model(...) |>
#'    fmt_number(rows=matches("^coef:"), decimals=5)
#' ```
#'
#' @param models a `list` of models, of either the `lm` or `glm` command.
#' @param digits a numeric value indicating the number of decimals to use when rounding numbers.
#' @param sig_thresh a numeric value indicating the threshold for statistical significance
#'             for the asterisk. If NULL, asterisks will not be printed.
#' @param summary_stats a character vector indicating desired summary statistics. The names
#'                      should match summary statistic names produced through [broom::glance]
#'                      when applied to a model of this type. The number of observations
#'                      will always be reported.
#' @param var_labels a named character vector indicating labels for the rows. Names should
#'             be the actual variable names in the R model output for variables or
#'             summary statistic names from [broom::glance] for summary statistics.
#' @param parenthetical_value A character string of either "std.error", "statistic" (e.g. test statistic),
#'                            or "p.value" indicating what to include in parenthesis.
#'                            Defaults to standard errors.
#' @param parenthesis_type A character string of either "regular", "square", or "curly" indicating
#'             the type of parenthesis to use for parenthetical values.
#' @param beside A logical indicating whether to show the parenthetical value
#'            on the same row (TRUE) or a separate row (FALSE; default).
#' @param groups A character vector indicating the factor name for variables that
#'               should be grouped together under a heading row (e.g. for categorical
#'               variables).
#' @param omit_var A character vector indicating variable names for variables that should
#'                 be omitted from the final model.
#' @param exponentiate A boolean value indicating whether the coefficients from the model
#'                     should be exponentiated (taken to the power of e). This may be
#'                     useful for some models that use a log transformation of the
#'                     dependent variable.
#' @param fn_estimate A user-supplied custom function to extract variable-specific
#'                    estimates from the supplied model object. This can be useful if
#'                    the model has no existing method in [broom]. The returned object
#'                    should be a [tibble] of the same type as returned from [broom::tidy]. Each
#'                    row should be for a given independent variables and the column names
#'                    `term` (for variable name), `estimate` (for coefficient value),
#'                    `std.error`, `statistic` (for test statistic), and `p.value`.
#' @param fn_summary A user-supplied custom function to extract additional summary
#'                   statistics from the supplied model object. These additional summary
#'                   statistics can then be added via the `summary_stats` argument. This
#'                   can be useful to add custom summary statistics not available in
#'                   [broom::glance] or if no existing method exists in [broom] for this type
#'                   of model object. The
#'                   returned object should be a [tibble] of the same type as returned
#'                   from [broom::glance]. It should have only one row, and any desired
#'                   summary statistics should be included as variables. In many cases,
#'                   the output from [broom::glance] can be augmented in this function
#'                   with additional information. See below for an example of
#'                   this approach for pseudo-R-squared in a logit model.
#'
#' @return `gt_model` returns a `gt_tbl` object that can be further processed using
#' various commands from the [gt] package.
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
                     var_labels = c("n" = "N"),
                     parenthetical_value = "std.error",
                     parenthesis_type = "regular",
                     beside = FALSE,
                     groups = NULL,
                     omit_var = NULL,
                     exponentiate = FALSE,
                     fn_estimate = NULL,
                     fn_summary = NULL) {

  #### Create Table #####

  if(!(parenthetical_value %in% c("std.error", "statistic", "p.value"))) {
    parenthetical_value <- "std.error"
    warning("Parenthetical value not recognized. Defaulting to std.error.")
  }

  if(is.null(fn_estimate)) {
    # use broom to get the model estimates
    tbl_coef <- models |>
      purrr::map(broom::tidy)
  } else {
    # try the custom function
    tbl_coef <- models |>
      purrr::map(fn_estimate)
  }

  tbl_coef <- tbl_coef |>
    dplyr::bind_rows(.id="model") |>
    dplyr::select(model, term, estimate, !!parenthetical_value) |>
    dplyr::rename(variable = term,
                  coef = estimate,
                  par = !!parenthetical_value)  |>
    dplyr::mutate(model = stringr::str_c("model", model))


  if(exponentiate) {
    tbl_coef <- tbl_coef |>
      dplyr::mutate(coef = exp(coef))
  }


  # reshape the table
  tbl_coef <- tbl_coef |>
    tidyr::pivot_longer(cols = c(coef, par),
                        names_to = "type",
                        values_to = "value") |>
    tidyr::pivot_wider(id_cols = c(variable, type),
                       names_from = model,
                       values_from = value)

  # if beside, then reshape again
  if(beside) {
    tbl_coef <- tbl_coef |>
      tidyr::pivot_wider(id_cols=variable,
                         names_from=type,
                         values_from=tidyselect::starts_with("model")) |>
      dplyr::mutate(variable = stringr::str_c("coef", variable, sep=":"))
  } else {
    # if not beside we can get rid of type
    tbl_coef <- tbl_coef |>
      dplyr::mutate(variable = stringr::str_c(type, variable, sep=":")) |>
      dplyr::select(!type)
  }

  # now get summary statistics
  if(!("nobs" %in% summary_stats)) {
    # always include the number of observations
    summary_stats <- c("nobs", summary_stats)
  }

  if(is.null(fn_summary)) {
    tbl_summary <- models |>
      purrr::map(broom::glance)
  } else {
    tbl_summary <- models |>
      purrr::map(fn_summary)
  }

  tbl_summary <- tbl_summary |>
    dplyr::bind_rows(.id="model")  |>
    dplyr::mutate(model = stringr::str_c("model", model)) |>
    dplyr::select(c(model, tidyselect::all_of(summary_stats))) |>
    tidyr::pivot_longer(cols = summary_stats, names_to = "variable") |>
    tidyr::pivot_wider(names_from = model, values_from = value) |>
    dplyr::mutate(variable = stringr::str_c("summary", variable, sep=":"))

  if(beside) {
    # need to rename columns in this case to match
    tbl_summary <- tbl_summary |>
      dplyr::rename_with(~ paste0(.x, "_par"),
                         tidyselect::starts_with("model"))
  }

  # now combine them together
  tbl <- dplyr::bind_rows(tbl_coef, tbl_summary)

  # drop any omitted variables
  for(x in omit_var) {
    x <- paste("^(coef|par):", x, sep="")
    tbl <- tbl |>
      dplyr::filter(!stringr::str_detect(variable, x))
  }

  #### Add groups ####

  # start a list of row labels to indent
  indent_list <- NULL
  for(group in groups) {
    # get all members of this group by index
    indx_grp <- which(stringr::str_detect(tbl$variable,
                                          stringr::fixed(paste("coef",
                                                               group,
                                                               sep=":"))))
    # get first index where this group occurs
    indx_first <- indx_grp[1]
    if(is.na(indx_first)) {
      next
    }

    # collect row labels for later indentation
    indent_list <- c(indent_list, tbl$variable[indx_grp])

    # insert group row
    tbl <- tbl |>
      tibble::add_row(variable=paste("grp", group, sep=":"),
                      .before=indx_first)
  }

  #### Construct gt Table ####

  tbl_gt_model <- tbl |>
    gt(rowname_col = "variable") |>
    fmt_number(decimals = digits) |>
    fmt_number(decimals = 0, rows = "summary:nobs") |>
    sub_missing(missing_text = "") |>
    opt_footnote_marks(marks = c("*", "**", "***")) |>
    tab_options(footnotes.multiline = FALSE, footnotes.sep = ";")

  # wrap parenthetical values in parenthesis
  parenthesis_pattern = "({x})"
  if(parenthesis_type == "square") {
    parenthesis_pattern <- "[{x}]"
  } else if(parenthesis_type == "curly") {
    parenthesis_pattern <- "{{x}}"
  } else if(parenthesis_type != "regular") {
    message("Parenthesis type not recognized. Defaulting to regular.")
  }
  if(beside) {
    tbl_gt_model <- tbl_gt_model |>
      fmt_number(columns = tidyselect::ends_with("_par"),
                 rows = tidyselect::starts_with("coef:"),
                 pattern = parenthesis_pattern,
                 decimals = digits)
  } else {
    tbl_gt_model <- tbl_gt_model |>
      fmt_number(rows = tidyselect::starts_with("par:"),
                 pattern = parenthesis_pattern,
                 decimals = digits)
  }

  # remove "par:" stub labels
  tbl_gt_model <- tbl_gt_model |>
    text_replace(".*", "", locations = cells_stub(rows = matches("^par:")))

  # replace variable labels
  if(!is.null(var_labels)) {
    tbl_gt_model <- tbl_gt_model |>
      text_transform(
        fn = function(x) {
          replacement <- var_labels[stringr::str_remove(x, "^(coef|grp|summary):")]
          replacement[which(is.na(replacement))] <- x[which(is.na(replacement))]
          return(replacement)
        },
        locations = cells_stub(rows = matches("^(coef|grp|summary):"))
      )
  }

  # apply indents
  if(length(indent_list) > 0) {
    tbl_gt_model <- tbl_gt_model |>
      tab_stub_indent(rows=indent_list, indent=3)
  }

  #### Add Asterisks ####

  if (!is.null(sig_thresh)) {

    # create pvalue matrix
    tbl_p <- models |>
      purrr::map(broom::tidy) |>
      dplyr::bind_rows(.id="model") |>
      dplyr::select(model, term, p.value) |>
      dplyr::rename(variable=term,
                    pvalue=p.value)  |>
      dplyr::mutate(model = stringr::str_c("model", model)) |>
      tidyr::pivot_wider(id_cols = variable,
                         names_from = model,
                         values_from = pvalue) |>
      dplyr::mutate(variable = stringr::str_c("coef", variable, sep=":"))

    sig_label <- paste("p < ", sig_thresh, sep = "")

    # loop through models and assign an asterisks
    for (i in 2:ncol(tbl_p)) {
      sig_rows <- tbl_p$variable[which(tbl_p[,i] < sig_thresh)]
      # check to make sure they have not been omitted
      for(x in omit_var) {
        x <- paste("^coef:", x, sep="")
        sig_rows <- sig_rows[!stringr::str_detect(sig_rows, x)]
      }
      col_idx <- i
      if(beside) {
        col_idx <- 2 * i - 1
      }
      tbl_gt_model <- tbl_gt_model |>
        tab_footnote(footnote = sig_label,
                     locations = cells_body(columns = col_idx,
                                            rows = sig_rows),
                     placement = "right")
    }
  }

  return(tbl_gt_model)
}

