#' Generate a gt table from model results.
#'
#' @description A description
#'
#' @param models a \code{list} of models, of either the \code{lm} or \code{glm} command.
#' @param digits a numeric value indicating the number of decimals to round results to
#' @param sig_thresh a numeric value indicating the threshold for statistical significance
#'             for the asterisk. If NULL, asterisks will not be printed.
#' @param var_labels a named character vector indicating labels for the rows. Names should
#'             be the actual row names and values should be the labels desired.
#' @param summary_stats a character vector indicating desired summary statistics. See below
#'                for a list of available options.
#' @details
#' This function can be used to create a \code{gt_tbl} table of model (i.e. regression) results
#' using a format common in many scientific fields. Multiple models can be included in the table
#' by feeding in a list of model objects. The most common intended use of this function is within
# ` a Quarto document where the output will be displayed nicely in the final output.
#' Currently the following models are verified to work:
#'
#' Because the returned object is a \code{gt_tbl}, it can be further refined to the user's
#' tastes by piping it into subsequent \code{gt} commands.
#'
#' The returned table uses a label row for the variable label and summary statistics labels. All
# " model columns will be named as \code{modelX} where X is the index of the model (e.g. model1, model2).
#' Users can rename the models with a \code{cols_label} command. Variables and summary statistics
#' can be renamed by the \code{var_labels} argument which takes a named character vector that
#' provides the correspondence between original and new variable names (see examples below).
#'
#' @return \code{gt_model} returns a \code{gt_tbl} object that can be further processed using
#' various commands from the \code{gt} package.
gt_model <- function(models,
                     digits = 3,
                     sig_thresh = 0.05,
                     var_labels = NULL,
                     summary_stats = NULL) {
  #### Create Full Table #####

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
  var_names <- factor(colnames(tbl_coef),
    levels = colnames(tbl_coef)
  )
  summary_names <- colnames(tbl_summary)
  m <- nrow(tbl_coef)

  # transpose both tables and convert back to tibbles
  tbl_coef <- tbl_coef |>
    transpose_tibble() |>
    dplyr::mutate(type = "coef", variable = var_names)

  tbl_se <- tbl_se |>
    transpose_tibble() |>
    dplyr::mutate(type = "se", variable = var_names)

  tbl_combined <- dplyr::bind_rows(tbl_coef, tbl_se) |>
    dplyr::arrange(variable, type) |>
    dplyr::select(!type) |>
    dplyr::select(variable, dplyr::everything())

  tbl_summary <- tbl_summary |>
    transpose_tibble() |>
    dplyr::mutate(variable = summary_names) |>
    dplyr::select(variable, dplyr::everything())

  # combine
  tbl <- dplyr::bind_rows(tbl_combined, tbl_summary)

  # set indices for later reference
  var_indx <- seq(from = 1, by = 2, length.out = length(var_names))
  se_indx <- seq(from = 2, by = 2, length.out = length(var_names))

  #### Change Labels ####

  # change call columns to "modelX"
  tbl <- tbl |>
    dplyr::rename_with(~ gsub("V", "model", .x))

  # remove row labels on se lines
  tbl$variable[se_indx] <- ""

  # remove parenthesis from intercept label
  tbl <- tbl |>
    dplyr::mutate(variable = stringr::str_replace(
      variable,
      "\\(Intercept\\)",
      "Intercept"
    ))

  # if var_labels provided, rename all variables by labels
  if (!is.null(var_labels)) {
    for (vname in names(var_labels)) {
      tbl <- tbl |>
        dplyr::mutate(variable = stringr::str_replace(
          variable,
          paste("^", vname, "$", sep = ""),
          as.character(var_labels[vname])
        ))
    }
  }

  #### Construct basic gt table

  gt_tbl <- tbl |>
    gt::gt(rowname_col = "variable") |>
    gt::fmt_number(dplyr::starts_with("model"), decimals = digits) |>
    gt::fmt_number(dplyr::starts_with("model"),
      rows = se_indx,
      decimals = digits,
      pattern = "({x})"
    ) |>
    gt::fmt_number(dplyr::starts_with("model"),
      rows = dplyr::matches("^N$"),
      decimals = 0
    ) |>
    gt::sub_missing(missing_text = "") |>
    gt::opt_footnote_marks(marks = c("*", "**", "***")) |>
    gt::tab_options(footnotes.multiline = FALSE, footnotes.sep = ";")

  #### Add Asterisks ####

  if (!is.null(sig_thresh)) {
    # create pvalue matrix
    tbl_p <- models |>
      purrr::map(extract_pvalue) |>
      dplyr::bind_rows() |>
      transpose_tibble()

    is_sig <- tbl_p < sig_thresh

    # loop through models and assign an asterisks
    for (j in 1:m) {
      gt_tbl <- gt_tbl |>
        gt::tab_footnote(
          footnote = paste("p < ", sig_thresh, sep = ""),
          locations = gt::cells_body(
            columns = j + 1,
            rows = var_indx[which(is_sig[, j])]
          ),
          placement = "right"
        )
    }
  }

  return(gt_tbl)
}

transpose_tibble <- function(x) {
  x |>
    t() |>
    as.data.frame() |>
    tibble::as_tibble()
}
