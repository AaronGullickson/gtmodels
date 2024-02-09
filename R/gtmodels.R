gt_model <- function(models,
                     digits=3,
                     sig_thresh=c(0.05),
                     var_labels=NULL,
                     summary_stats=NULL) {

  # extract coefficients
  tbl_coef <- models |>
    map(coef) |>
    bind_rows()

  # extract standard errors
  tbl_se <- models |>
    map(extract_se) |>
    bind_rows()

  # extract summary statistics
  tbl_summary <- models |>
    map(extract_summary, summary_stats) |>
    bind_rows()

  # get variable names for later
  var_names <- factor(colnames(tbl_coef),
                      levels=colnames(tbl_coef))
  summary_names <- colnames(tbl_summary)
  m <- nrow(tbl_coef)

  # transpose both tables and convert back to tibbles
  tbl_coef <- tbl_coef |>
    transpose_tibble() |>
    mutate(type="coef", variable=var_names)

  tbl_se <- tbl_se |>
    transpose_tibble() |>
    mutate(type="se", variable=var_names)

  tbl_combined <- bind_rows(tbl_coef, tbl_se) |>
    arrange(variable, type) |>
    select(!type) |>
    select(variable, everything())

  tbl_summary <- tbl_summary |>
    transpose_tibble() |>
    mutate(variable=summary_names) |>
    select(variable, everything())

  # combine
  tbl <- bind_rows(tbl_combined, tbl_summary)

  # set indexes
  var_indx <- seq(from=1, by=2, length.out=length(var_names))
  se_indx <- seq(from=2, by=2, length.out=length(var_names))

  # change names
  tbl <- tbl |>
    rename_with(~gsub("V", "model", .x))

  tbl$variable[se_indx] <- ""

  tbl <- tbl |>
    mutate(variable = str_replace(variable, "\\(Intercept\\)", "Intercept"))

  if(!is.null(var_labels)) {
    for(vname in names(var_labels)) {
      tbl <- tbl |>
        mutate(variable = str_replace(variable, vname,
                                      as.character(var_labels[vname])))
    }
  }

  gt_tbl <- tbl |>
    gt(rowname_col = "variable") |>
    fmt_number(starts_with("model"), decimals = digits) |>
    fmt_number(starts_with("model"), rows=se_indx, decimals = digits,
               pattern="({x})") |>
    fmt_number(starts_with("model"), rows = tidyselect::matches("N$"),
               decimals = 0) |>
    sub_missing(missing_text = "") |>
    opt_footnote_marks(marks = c("*","**","***")) |>
    tab_options(footnotes.multiline = FALSE, footnotes.sep=";")

  # add asterisks
  # FIXME: If a particular threshold is not present in the data it doesn't show
  # in the notes and the wrong number of asterisks are shown
  if(!is.null(sig_thresh)) {

    # create pvalue matrix
    tbl_p <- models |>
      map(extract_pvalue) |>
      bind_rows() |>
      transpose_tibble()

    thresholds <- list()
    for(i in 1:length(sig_thresh)) {
      if(i == length(sig_thresh)) {
        thresholds[[i]] <- tbl_p < sig_thresh[i]
      } else {
        thresholds[[i]] <- tbl_p < sig_thresh[i] & tbl_p>=sig_thresh[i+1]
      }
    }


    for(i in 1:length(sig_thresh)) {
      for(j in 1:m) {
        gt_tbl <- gt_tbl |>
          tab_footnote(footnote = paste("p < ", sig_thresh[i], sep=""),
                       locations = cells_body(columns=j+1,
                                              rows=var_indx[which(thresholds[[i]][,j])]),
                       placement = "right")
      }
    }
  }

  return(gt_tbl)
}

transpose_tibble <- function(x) {
  x |>
    t() |>
    as.data.frame() |>
    as_tibble()
}
