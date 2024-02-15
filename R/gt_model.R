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
#' @param digits a numeric value indicating the number of decimals to round results to
#' @param sig_thresh a numeric value indicating the threshold for statistical significance
#'             for the asterisk. If NULL, asterisks will not be printed.
#' @param summary_stats a character vector indicating desired summary statistics. See below
#'                for a list of available options.
#' @param var_labels a named character vector indicating labels for the rows. Names should
#'             either the actual variable names in the R model output for variables or
#'             summary statistic names for summary statistics.
#' @param parenthetical_value A character string of either "se", "tstat", or "pvalue"
#'             indicating what to include in parenthesis. Defaults to standard errors.
#' @param parenthesis_type A character string of either "regular", "square", or "curly" indicating
#'             the type of parenthesis to use for parenthetical values.
#' @param beside A logical indicating whether to show the parenthetical value
#'            on the same row (TRUE) or a separate row (FALSE; default).
#' @param groups A character vector indicating the factor name for variables that
#'               should be grouped together under a heading row (e.g. for categorical
#'               variables).
#' @param omit_var A character vector indicating variable names for variables that should
#'                 be omitted from the final model.
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
#'                  "as.factor(cyl)" = "Number of cylinders (ref. 4-cylinder)",
#'                  "as.factor(cyl)6" = "6-cylinder",
#'                  "as.factor(cyl)8" = "8-cylinder",
#'                  "n" = "N",
#'                  "rsquared" = "R-squared",
#'                  "bic" = "BIC")
#'
#'   gt_model(list(model1, model2, model3), var_labels = name_corr,
#'            summary_stats = c("rsquared", "bic"),
#'            groups=c("as.factor(cyl)")) |>
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
                     summary_stats = NULL,
                     var_labels = c("n" = "N"),
                     parenthetical_value = "se",
                     parenthesis_type = "regular",
                     beside = FALSE,
                     groups = NULL,
                     omit_var = NULL) {

  #### Create Table Parts #####

  # extract coefficients
  tbl_coef <- models |>
    purrr::map(coef) |>
    dplyr::bind_rows()

  # extract parenthetical values
  if(parenthetical_value == "tstat") {
    tbl_par <- models |>
      purrr::map(extract_tstat) |>
      dplyr::bind_rows()
  } else if(parenthetical_value == "pvalue") {
    tbl_par <- models |>
      purrr::map(extract_pvalue) |>
      dplyr::bind_rows()
  } else {
    # default to standard errors
    if(parenthetical_value != "se") {
      message("argument to parenthetical type not recognized. Defaulting to standard errors")
    }
    tbl_par <- models |>
      purrr::map(extract_se) |>
      dplyr::bind_rows()
  }

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

  tbl_par <- tbl_par |>
    transpose_tibble() |>
    dplyr::mutate(type = "par", variable = var_names)

  #### Construct Full Table ####

  if(beside) {
    tbl_combined <- dplyr::bind_rows(tbl_coef, tbl_par) |>
      tidyr::pivot_wider(id_cols=variable,
                         names_from=type,
                         values_from=matches("^V[0-9]")) |>
      dplyr::mutate(variable = paste("coef", variable, sep=":"))

    tbl_summary <- tbl_summary |>
      transpose_tibble() |>
      dplyr::mutate(variable = paste("summary", summary_names, sep=":")) |>
      dplyr::select(variable, dplyr::everything()) |>
      dplyr::rename_with(~ paste0(.x, "_par", sep=""), matches("^V[0-9]"))

    tbl <- dplyr::bind_rows(tbl_combined, tbl_summary)
  } else {
    tbl_combined <- dplyr::bind_rows(tbl_coef, tbl_par) |>
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
    fmt_number(decimals = 0, rows = "summary:n") |>
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
      fmt_number(columns = ends_with("_par"),
                 rows = starts_with("coef:"),
                 pattern = parenthesis_pattern,
                 decimals = digits)
  } else {
    tbl_gt_model <- tbl_gt_model |>
      fmt_number(rows = starts_with("par:"),
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
      # check to make sure they have not been omitted
      for(x in omit_var) {
        x <- paste("^coef:", x, sep="")
        sig_rows <- sig_rows[!stringr::str_detect(sig_rows, x)]
      }
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
