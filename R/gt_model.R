#' Generates a table from model results using the `gt` library.
#'
#' `gt_model` outputs a list of models as a [gt] table for display in Quarto,
#' R Markdown, or other formats.
#'
#' This function can be used to create a [gt] table of model (i.e. regression) results
#' using a format common in many scientific fields. Multiple models can be included in the table
#' by feeding in a list of model objects. The most common intended use of this function is within
#' a Quarto document where the output will be displayed nicely in the final output.
#' Currently the following models are verified to work:
#' * [lm]
#' * [glm]
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
#' Each row label begins with either "coef:", "se:", or "summary:" depending on whether it is
#' a model coefficient, standard error, or summary statistic. This is followed by either the
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
#' @param digits a numeric value indicating the number of decimals to round results to
#' @param sig_thresh a numeric value indicating the threshold for statistical significance
#'             for the asterisk. If NULL, asterisks will not be printed.
#' @param var_labels a named character vector indicating labels for the rows. Names should
#'             either the actual variable names in the R model output for variables or
#'             summary statistic names for summary statistics.
#' @param summary_stats a character vector indicating desired summary statistics. See below
#'                for a list of available options.
#' @param beside A logical indicating whether to show the parenthetical value
#'            on the same row (TRUE) or a separate row (FALSE; default).
#'
#' @return `gt_model` returns a `gt_tbl` object that can be further processed using
#' various commands from the [gt] package.
#'
#' @examples
#' if (require("gt")) {
#'   model1 <- lm(mpg ~ hp, data = mtcars)
#'   model2 <- update(model1, . ~ . + disp + wt)
#'   model3 <- update(model2, . ~ . + as.factor(cyl))
#'
#'   name_corr <- c("Intercept" = "Constant",
#'                  "hp" = "Horsepower",
#'                  "disp" = "Displacement (cu. in.)",
#'                  "wt" = "Weight (1000 lbs)",
#'                  "as.factor(cyl)6" = "6-cylinder",
#'                  "as.factor(cyl)8" = "8-cylinder",
#'                  "rsquared" = "R-squared",
#'                  "bic" = "BIC")
#'
#'   gt_model(list(model1, model2, model3), var_labels = name_corr,
#'            summary_stats = c("rsquared", "bic")) |>
#'     cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
#'     fmt_number(rows = c("summary:bic"), decimals = 1) |>
#'     tab_source_note(md("*Notes:* Standard errors shown in parenthesis.")) |>
#'     tab_options(table.width = "100%")
#' }
#' @import gt
#' @export
gt_model <- function(models,
                     digits = 3,
                     sig_thresh = 0.05,
                     var_labels = c("(Intercept)" = "Intercept", "n" = "N"),
                     summary_stats = NULL,
                     beside = FALSE) {

  #### Create Table Parts #####

  # extract coefficients
  tbl_coef <- models |>
    purrr::map(coef) |>
    dplyr::bind_rows()

  # extract standard errors
  tbl_se <- models |>
    purrr::map(extract_se) |>
    dplyr::bind_rows()

  # extract summary statistics
  tbl_summary <- models |>
    purrr::map(extract_summary, summary_stats) |>
    dplyr::bind_rows()

  # get variable names for later
  var_names <- factor(colnames(tbl_coef), levels = colnames(tbl_coef))
  summary_names <- colnames(tbl_summary)
  m <- nrow(tbl_coef)

  # transpose both tables and convert back to tibbles
  tbl_coef <- tbl_coef |>
    transpose_tibble() |>
    dplyr::mutate(type = "coef", variable = var_names)

  tbl_se <- tbl_se |>
    transpose_tibble() |>
    dplyr::mutate(type = "se", variable = var_names)

  #### Construct Full Table ####

  if(beside) {
    tbl_combined <- dplyr::bind_rows(tbl_coef, tbl_se) |>
      tidyr::pivot_wider(id_cols=variable,
                         names_from=type,
                         values_from=matches("^V[0-9]")) |>
      dplyr::mutate(variable = paste("coef", variable, sep=":"))

    tbl_summary <- tbl_summary |>
      transpose_tibble() |>
      dplyr::mutate(variable = paste("summary", summary_names, sep=":")) |>
      dplyr::select(variable, dplyr::everything()) |>
      dplyr::rename_with(~ paste0(.x, "_se", sep=""), matches("^V[0-9]"))

    tbl <- dplyr::bind_rows(tbl_combined, tbl_summary)
  } else {
    tbl_combined <- dplyr::bind_rows(tbl_coef, tbl_se) |>
      dplyr::arrange(variable, type) |>
      dplyr::mutate(variable = paste(type, variable, sep=":")) |>
      dplyr::select(!type) |>
      dplyr::select(variable, dplyr::everything())

    tbl_summary <- tbl_summary |>
      transpose_tibble() |>
      dplyr::mutate(variable = paste("summary", summary_names, sep=":")) |>
      dplyr::select(variable, dplyr::everything())

    tbl <- dplyr::bind_rows(tbl_combined, tbl_summary)
  }

  # change call columns to "modelX"
  tbl <- tbl |>
    dplyr::rename_with(~ gsub("V", "model", .x))

  # if var_labels provided, rename all variables by labels
  # if (!is.null(var_labels)) {
  #   for (vname in names(var_labels)) {
  #     tbl <- tbl |>
  #       dplyr::mutate(variable = stringr::str_replace(
  #         variable,
  #         paste("^", vname, "$", sep = ""),
  #         as.character(var_labels[vname])
  #       ))
  #   }
  # }

  #### Construct gt table ####

  tbl_gt_model <- tbl |>
    gt(rowname_col = "variable") |>
    fmt_number(decimals = digits) |>
    fmt_number(decimals = 0, rows = "summary:n") |>
    sub_missing(missing_text = "") |>
    opt_footnote_marks(marks = c("*", "**", "***")) |>
    tab_options(footnotes.multiline = FALSE, footnotes.sep = ";")

  # wrap parenthetical values in parenthesis
  if(beside) {
    tbl_gt_model <- tbl_gt_model |>
      fmt_number(columns = ends_with("_se"),
                 rows = starts_with("coef:"),
                 pattern = "({x})")
  } else {
    tbl_gt_model <- tbl_gt_model |>
      fmt_number(rows = starts_with("se:"), pattern = "({x})")
  }

  # remove "se:" stub labels
  tbl_gt_model <- tbl_gt_model |>
    text_replace(".*", "", locations = cells_stub(rows = matches("^se:")))

  # replace variable labels
  if(!is.null(var_labels)) {
    tbl_gt_model <- tbl_gt_model |>
      text_transform(
        fn = function(x) {
          replacement <- var_labels[stringr::str_remove(x, "^(coef|summary):")]
          replacement[which(is.na(replacement))] <- x[which(is.na(replacement))]
          return(replacement)
        },
        locations = cells_stub(rows = matches("^(coef|summary):"))
      )
  }

  #### Add Asterisks ####

  if (!is.null(sig_thresh)) {
    # create pvalue matrix
    tbl_p <- models |>
      purrr::map(extract_pvalue) |>
      dplyr::bind_rows() |>
      transpose_tibble()

    is_sig <- tbl_p < sig_thresh
    multiplier <- ifelse(beside, 2, 1)
    var_id <- paste(tbl_coef$type, tbl_coef$variable, sep=":")
    sig_label <- paste("p < ", sig_thresh, sep = "")

    # loop through models and assign an asterisks
    for (i in 1:m) {
      sig_rows <- c(na.omit(var_id[is_sig[,i]]))
      tbl_gt_model <- tbl_gt_model |>
        tab_footnote(footnote = sig_label,
                     locations = cells_body(columns = multiplier*i + 1,
                                            rows = sig_rows),
                     placement = "right")
    }
  }

  return(tbl_gt_model)
}

# helper function to transpose a tibble
transpose_tibble <- function(x) {
  x |>
    t() |>
    as.data.frame() |>
    tibble::as_tibble()
}
