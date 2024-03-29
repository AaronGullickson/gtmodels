# Functions to build the gt_model table

# Functions to create or modify underlying tibble -------------------------

# function to build the tibble that will form the basis for the gt table
build_tbl <- function(models,
                      summary_stats = NULL,
                      parenthetical_value = "std.error",
                      beside = FALSE,
                      fn_transform = NULL,
                      fn_estimate = NULL,
                      fn_summary = NULL) {

  ### Build coefficient table ###

  tbl_coef <- models |>
    purrr::map(ifelse(is.null(fn_estimate), broom::tidy, fn_estimate)) |>
    dplyr::bind_rows(.id="model") |>
    dplyr::select(model, term, estimate, !!parenthetical_value) |>
    dplyr::rename(variable = term,
                  coef = estimate,
                  par = !!parenthetical_value)  |>
    dplyr::mutate(model = stringr::str_c("model", model))

  # potentially transform coefficients
  if(!is.null(fn_transform)) {
    tbl_coef <- tbl_coef |>
      dplyr::mutate(coef = fn_transform(coef))
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

  ### Build summary table ###

  # always include the number of observations, even if summary_stats is null
  if(!("nobs" %in% summary_stats)) {
    summary_stats <- c("nobs", summary_stats)
  }

  tbl_summary <- models |>
    purrr::map(ifelse(is.null(fn_summary), broom::glance, fn_summary)) |>
    dplyr::bind_rows(.id="model")  |>
    dplyr::mutate(model = stringr::str_c("model", model)) |>
    dplyr::select(c(model, tidyselect::all_of(summary_stats))) |>
    tidyr::pivot_longer(cols = tidyselect::all_of(summary_stats),
                        names_to = "variable") |>
    tidyr::pivot_wider(names_from = model, values_from = value) |>
    dplyr::mutate(variable = stringr::str_c("summary", variable, sep=":"))

  if(beside) {
    # need to rename columns in this case to match
    tbl_summary <- tbl_summary |>
      dplyr::rename_with(~ paste0(.x, "_par"),
                         tidyselect::starts_with("model"))
  }

  ### Combine tables ###

  tbl <- dplyr::bind_rows(tbl_coef, tbl_summary)

  return(tbl)
}

# take a character vector of variable names and omit any from the tibble
omit_variables <- function(tbl, omit_var) {
  for(x in omit_var) {
    x <- paste("^(coef|par):", x, sep="")
    tbl <- tbl |>
      dplyr::filter(!stringr::str_detect(variable, x))
  }

  return(tbl)
}

# add group label rows for variables specified by groups character vector
add_groups <- function(tbl, groups) {
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

    # insert group row
    tbl <- tbl |>
      tibble::add_row(variable=paste("grp", group, sep=":"),
                      .before=indx_first)
  }

  return(tbl)
}


# Functions to create or modify gt object ---------------------------------

# construct the basic gt table from the underlying tibble
construct_tbl_gt <- function(tbl,
                             digits,
                             parenthesis_type,
                             beside) {

  # build basic gt table
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
    warning("Parenthesis type not recognized. Defaulting to regular.")
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

  # Remove "par:" stub labels
  tbl_gt_model <- tbl_gt_model |>
    text_replace(".*", "", locations = cells_stub(rows = matches("^par:")))

  return(tbl_gt_model)
}

# function to replace stub labels with nicer variable labels
replace_var_labels <- function(tbl_gt_model, var_labels) {

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

  return(tbl_gt_model)
}

# function to apply indentation to variables that are part of a group
apply_group_indents <- function(tbl_gt_model, groups) {

  if(!is.null(groups)) {
    match_string <- paste0("^coef:(",
                           paste(stringr::str_escape(groups), collapse="|"),
                           ")")
    tbl_gt_model <- tbl_gt_model |>
      tab_stub_indent(rows = matches(match_string), indent = 3)
  }

  return(tbl_gt_model)
}

# function to apply asterisks to the gt table for statistical significance
apply_asterisks <- function(tbl_gt_model,
                            models,
                            sig_thresh,
                            beside,
                            omit_var,
                            fn_estimate) {

  # create pvalue matrix
  tbl_p <- models |>
    purrr::map(ifelse(is.null(fn_estimate), broom::tidy, fn_estimate)) |>
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
                   locations = cells_body(columns = col_idx, rows = sig_rows),
                   placement = "right")
  }

  return(tbl_gt_model)
}

# Validation functions ----------------------------------------------------

validate_digits <- function(digits) {

  if (is.null(digits)) {
    cli::cli_abort("The value for `digits` must not be `NULL`.")
  }
  if (length(digits) != 1) {
    cli::cli_abort("The length of `digits` must be 1.")
  }
  if (is.na(digits)) {
    cli::cli_abort("The value for `digits` must not be `NA`.")
  }
  if (!is.numeric(digits)) {
    cli::cli_abort("Any input for `digits` must be numeric.")
  }
  if (digits < 0) {
    cli::cli_abort("The value for `digits` must be positive or zero.")
  }
}

validate_sig_thresh <- function(sig_thresh) {

  if (is.null(sig_thresh)) {
    return()
  }

  if (length(sig_thresh) != 1) {
    cli::cli_abort("The length of `sig_thresh` must be 1.")
  }
  if (is.na(sig_thresh)) {
    cli::cli_abort("The value for `sig_thresh` must not be `NA`.")
  }
  if (!is.numeric(sig_thresh)) {
    cli::cli_abort("Any input for `sig_thresh` must be numeric.")
  }
  if (sig_thresh <= 0) {
    cli::cli_abort("The value for `sig_thresh` must be greater than zero.")
  }
}

validate_summary_stats <- function(summary_stats) {

  if (is.null(summary_stats)) {
    return()
  }

  if (sum(is.na(summary_stats)) > 0) {
    cli::cli_abort("The values for `summary_stats` must not be `NA`.")
  }
  if (!is.character(summary_stats)) {
    cli::cli_abort("Any input for `summary_stats` must be character.")
  }
}

validate_var_labels <- function(var_labels) {

  if(is.null(var_labels)) {
    return()
  }

  if(sum(is.na(var_labels)) > 0) {
    cli::cli_abort("The values for `var_labels` must not be `NA`.")
  }
  if(!is.character(var_labels)) {
    cli::cli_abort("Any input for `var_labels` must be character.")
  }
  if(is.null(names(var_labels))) {
    cli::cli_abort("The `var_labels` vector must be named.")
  }
}

validate_parenthetical_value <- function(parenthetical_value) {

  if(is.null(parenthetical_value)) {
    cli::cli_abort("The value for `parenthetical_value` must not be `NULL`.")
  }
  if(length(parenthetical_value) != 1) {
    cli::cli_abort("The length of `parenthetical_value` must be 1.")
  }
  if(is.na(parenthetical_value)) {
    cli::cli_abort("The value for `parenthetical_value` must not be `NA`.")
  }
  if(!is.character(parenthetical_value)) {
    cli::cli_abort("Any input for `parenthetical_value` must be character.")
  }

  if(!(parenthetical_value %in% c("std.error", "statistic", "p.value"))) {
    warning("Parenthetical value not recognized. Defaulting to std.error.")
    return("std.error")
  }

  return(parenthetical_value)
}

validate_parenthesis_type <- function(parenthesis_type) {

  if(is.null(parenthesis_type)) {
    cli::cli_abort("The value for `parenthesis_type` must not be `NULL`.")
  }
  if(length(parenthesis_type) != 1) {
    cli::cli_abort("The length of `parenthesis_type` must be 1.")
  }
  if(is.na(parenthesis_type)) {
    cli::cli_abort("The value for `parenthesis_type` must not be `NA`.")
  }
  if(!is.character(parenthesis_type)) {
    cli::cli_abort("Any input for `parenthesis_type` must be character.")
  }

  if(!(parenthesis_type %in% c("regular", "curly", "square"))) {
    warning("Parenthesis type not recognized. Defaulting to regular.")
    return("regular")
  }

  return(parenthesis_type)
}

validate_beside <- function(beside) {

  if(is.null(beside)) {
    cli::cli_abort("The value for `beside` must not be `NULL`.")
  }
  if(length(beside) != 1) {
    cli::cli_abort("The length of `beside` must be 1.")
  }
  if(is.na(beside)) {
    cli::cli_abort("The value for `beside` must not be `NA`.")
  }
  if(!is.logical(beside)) {
    cli::cli_abort("Any input for `beside` must be logical.")
  }
}

validate_groups <- function(groups) {

  if(is.null(groups)) {
    return()
  }

  if(sum(is.na(groups)) > 0) {
    cli::cli_abort("The values for `groups` must not be `NA`.")
  }
  if(!is.character(groups)) {
    cli::cli_abort("Any input for `groups` must be character.")
  }
}

validate_omit_var <- function(omit_var) {

  if(is.null(omit_var)) {
    return()
  }

  if(sum(is.na(omit_var)) > 0) {
    cli::cli_abort("The values for `omit_var` must not be `NA`.")
  }
  if(!is.character(omit_var)) {
    cli::cli_abort("Any input for `omit_var` must be character.")
  }
}
