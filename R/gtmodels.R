library(gt)
library(tidyverse)
library(palmerpenguins)
library(stringr)

model1 <- lm(bill_length_mm~flipper_length_mm, data=penguins)
model2 <- update(model1, .~.+body_mass_g)
model3 <- update(model2, .~.+sex)

models <- list(model1, model2, model3)

digits <- 3

name_correspondence <- list("flipper_length_mm"="Flipper length (mm)",
                            "body_mass_g"="Body Mass (g)",
                            "sexmale"="Male")

extract_summary <- function(model) {
  n <- length(model1$fitted.values)
  r.squared <- summary(model)$r.squared
  return(c("N" = n, "$$R^2$$"=r.squared))
}

extract_se <- function(model) {
  summary(model)$coef[,2]
}

extract_pvalue <- function(model) {
  summary(model)$coef[,4]
}

transpose_tibble <- function(x) {
  x |>
    t() |>
    as.data.frame() |>
    as_tibble()
}

gt_model <- function(models,
                     digits=3,
                     sig_thresh=c(0.05),
                     var_labels=NULL) {

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
    map(extract_summary) |>
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

  # change names for reference
  tbl <- tbl |>
    rename_with(~gsub("V", "model", .x))

  # change intercept
  tbl <- tbl |>
    mutate(variable = str_replace(variable, "\\(Intercept\\)", "Intercept"))

  if(!is.null(var_labels)) {
    for(vname in names(var_labels)) {
      tbl <- tbl |>
        mutate(variable = str_replace(variable, vname,
                                      as.character(var_labels[vname])))
    }
  }

  var_indx <- seq(from=1, by=2, length.out=length(var_names))
  se_indx <- seq(from=2, by=2, length.out=length(var_names))
  tbl$variable[se_indx] <- ""

  gt_tbl <- tbl |>
    gt(rowname_col = "variable") |>
    cols_label_with(starts_with("model"), fn = ~ gsub("model", "Model ", .)) |>
    fmt_number(starts_with("model"), rows=var_indx, decimals = digits) |>
    fmt_number(starts_with("model"), rows=se_indx, decimals = digits,
               pattern="({x})") |>
    fmt_number(starts_with("model"), rows = matches("N$"), decimals = 0,
               use_seps=TRUE) |>
    fmt_number(starts_with("model"), rows = matches("R\\^2"), decimals = 3) |>
    sub_missing(missing_text = "") |>
    opt_footnote_marks(marks = c("*","**","***"))

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

    for(i in 1:m) {
      for(j in 1:length(sig_thresh)) {
        gt_tbl <- gt_tbl |>
          tab_footnote(footnote = paste("p < ", sig_thresh[j], sep=""),
                       locations = cells_body(columns=i+1,
                                              rows=var_indx[which(thresholds[[j]][,i])]),
                       placement = "right")
      }
    }
  }

  return(gt_tbl)
}

gt_model(models, digits=3, var_labels=name_correspondence,
         sig_thresh=c(0.05,0.01,0.001)) |>
  tab_source_note("Note: Standard errors are shown in parenthesis.")


model <- glm(sex ~ flipper_length_mm+body_mass_g, data=penguins)
