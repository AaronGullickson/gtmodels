
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gtmodels

<!-- badges: start -->
<!-- badges: end -->

The `gtmodels` package allows you to output multiple models as a single
`gt_tbl` table using the [gt](https://gt.rstudio.com/) package. This
output can easily be embedded in R Markdown and Quarto documents.
Furthermore, because the output is a `gt_tbl` object, it can easily be
customized further by the user using standard `gt` commands.

## Installation

You can install the development version of `gtmodels` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("AaronGullickson/gtmodels")
```

## Example

This is a basic example which shows you how to build a table containing
several models:

``` r
library(gt)
library(gtmodels)
model1 <- lm(mpg ~ hp, data = mtcars)
model2 <- update(model1, . ~ . + disp + wt)
model3 <- update(model2, . ~ . + as.factor(cyl))

gt_model(list(model1, model2, model3))
```

<div id="cxixdcqnox" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cxixdcqnox table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#cxixdcqnox thead, #cxixdcqnox tbody, #cxixdcqnox tfoot, #cxixdcqnox tr, #cxixdcqnox td, #cxixdcqnox th {
  border-style: none;
}
&#10;#cxixdcqnox p {
  margin: 0;
  padding: 0;
}
&#10;#cxixdcqnox .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#cxixdcqnox .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#cxixdcqnox .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#cxixdcqnox .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#cxixdcqnox .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#cxixdcqnox .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#cxixdcqnox .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#cxixdcqnox .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#cxixdcqnox .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#cxixdcqnox .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#cxixdcqnox .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#cxixdcqnox .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#cxixdcqnox .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#cxixdcqnox .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#cxixdcqnox .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cxixdcqnox .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#cxixdcqnox .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#cxixdcqnox .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#cxixdcqnox .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cxixdcqnox .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#cxixdcqnox .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cxixdcqnox .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#cxixdcqnox .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cxixdcqnox .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#cxixdcqnox .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cxixdcqnox .gt_left {
  text-align: left;
}
&#10;#cxixdcqnox .gt_center {
  text-align: center;
}
&#10;#cxixdcqnox .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#cxixdcqnox .gt_font_normal {
  font-weight: normal;
}
&#10;#cxixdcqnox .gt_font_bold {
  font-weight: bold;
}
&#10;#cxixdcqnox .gt_font_italic {
  font-style: italic;
}
&#10;#cxixdcqnox .gt_super {
  font-size: 65%;
}
&#10;#cxixdcqnox .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#cxixdcqnox .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#cxixdcqnox .gt_indent_1 {
  text-indent: 5px;
}
&#10;#cxixdcqnox .gt_indent_2 {
  text-indent: 10px;
}
&#10;#cxixdcqnox .gt_indent_3 {
  text-indent: 15px;
}
&#10;#cxixdcqnox .gt_indent_4 {
  text-indent: 20px;
}
&#10;#cxixdcqnox .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id=""></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model1">model1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model2">model2</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model3">model3</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub">Intercept</th>
<td headers="stub_1_1 model1" class="gt_row gt_right">30.099<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model2" class="gt_row gt_right">37.106<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model3" class="gt_row gt_right">36.002<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_2 model1" class="gt_row gt_right">(1.634)</td>
<td headers="stub_1_2 model2" class="gt_row gt_right">(2.111)</td>
<td headers="stub_1_2 model3" class="gt_row gt_right">(2.131)</td></tr>
    <tr><th id="stub_1_3" scope="row" class="gt_row gt_left gt_stub">hp</th>
<td headers="stub_1_3 model1" class="gt_row gt_right">−0.068<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model2" class="gt_row gt_right">−0.031<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model3" class="gt_row gt_right">−0.024</td></tr>
    <tr><th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_4 model1" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_4 model2" class="gt_row gt_right">(0.011)</td>
<td headers="stub_1_4 model3" class="gt_row gt_right">(0.012)</td></tr>
    <tr><th id="stub_1_5" scope="row" class="gt_row gt_left gt_stub">disp</th>
<td headers="stub_1_5 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_5 model2" class="gt_row gt_right">−0.001</td>
<td headers="stub_1_5 model3" class="gt_row gt_right">0.004</td></tr>
    <tr><th id="stub_1_6" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_6 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_6 model2" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_6 model3" class="gt_row gt_right">(0.013)</td></tr>
    <tr><th id="stub_1_7" scope="row" class="gt_row gt_left gt_stub">wt</th>
<td headers="stub_1_7 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_7 model2" class="gt_row gt_right">−3.801<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_7 model3" class="gt_row gt_right">−3.429<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_8" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_8 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_8 model2" class="gt_row gt_right">(1.066)</td>
<td headers="stub_1_8 model3" class="gt_row gt_right">(1.055)</td></tr>
    <tr><th id="stub_1_9" scope="row" class="gt_row gt_left gt_stub">as.factor(cyl)6</th>
<td headers="stub_1_9 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model3" class="gt_row gt_right">−3.466<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_10" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_10 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model3" class="gt_row gt_right">(1.463)</td></tr>
    <tr><th id="stub_1_11" scope="row" class="gt_row gt_left gt_stub">as.factor(cyl)8</th>
<td headers="stub_1_11 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model3" class="gt_row gt_right">−3.753</td></tr>
    <tr><th id="stub_1_12" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_12 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model3" class="gt_row gt_right">(2.814)</td></tr>
    <tr><th id="stub_1_13" scope="row" class="gt_row gt_left gt_stub">N</th>
<td headers="stub_1_13 model1" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model2" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model3" class="gt_row gt_right">32</td></tr>
  </tbody>
  &#10;  <tfoot>
    <tr class="gt_footnotes">
      <td class="gt_footnote" colspan="4">
        <div style="padding-bottom:2px;"><span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span> p &lt; 0.05</div>
      </td>
    </tr>
  </tfoot>
</table>
</div>

Right now, the table doesn’t look like much but I can make some quick
and easy changes using additional arguments in `gt_model`. First, I can
add some predefined summary statistics:

``` r
gt_model(list(model1, model2, model3), summary_stats=c("rsquared","bic"))
```

<div id="dlbfkpncgf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#dlbfkpncgf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#dlbfkpncgf thead, #dlbfkpncgf tbody, #dlbfkpncgf tfoot, #dlbfkpncgf tr, #dlbfkpncgf td, #dlbfkpncgf th {
  border-style: none;
}
&#10;#dlbfkpncgf p {
  margin: 0;
  padding: 0;
}
&#10;#dlbfkpncgf .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#dlbfkpncgf .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#dlbfkpncgf .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#dlbfkpncgf .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#dlbfkpncgf .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#dlbfkpncgf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#dlbfkpncgf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#dlbfkpncgf .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#dlbfkpncgf .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#dlbfkpncgf .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#dlbfkpncgf .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#dlbfkpncgf .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#dlbfkpncgf .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#dlbfkpncgf .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#dlbfkpncgf .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dlbfkpncgf .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#dlbfkpncgf .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#dlbfkpncgf .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#dlbfkpncgf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dlbfkpncgf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#dlbfkpncgf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dlbfkpncgf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#dlbfkpncgf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dlbfkpncgf .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#dlbfkpncgf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dlbfkpncgf .gt_left {
  text-align: left;
}
&#10;#dlbfkpncgf .gt_center {
  text-align: center;
}
&#10;#dlbfkpncgf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#dlbfkpncgf .gt_font_normal {
  font-weight: normal;
}
&#10;#dlbfkpncgf .gt_font_bold {
  font-weight: bold;
}
&#10;#dlbfkpncgf .gt_font_italic {
  font-style: italic;
}
&#10;#dlbfkpncgf .gt_super {
  font-size: 65%;
}
&#10;#dlbfkpncgf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#dlbfkpncgf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#dlbfkpncgf .gt_indent_1 {
  text-indent: 5px;
}
&#10;#dlbfkpncgf .gt_indent_2 {
  text-indent: 10px;
}
&#10;#dlbfkpncgf .gt_indent_3 {
  text-indent: 15px;
}
&#10;#dlbfkpncgf .gt_indent_4 {
  text-indent: 20px;
}
&#10;#dlbfkpncgf .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id=""></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model1">model1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model2">model2</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model3">model3</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub">Intercept</th>
<td headers="stub_1_1 model1" class="gt_row gt_right">30.099<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model2" class="gt_row gt_right">37.106<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model3" class="gt_row gt_right">36.002<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_2 model1" class="gt_row gt_right">(1.634)</td>
<td headers="stub_1_2 model2" class="gt_row gt_right">(2.111)</td>
<td headers="stub_1_2 model3" class="gt_row gt_right">(2.131)</td></tr>
    <tr><th id="stub_1_3" scope="row" class="gt_row gt_left gt_stub">hp</th>
<td headers="stub_1_3 model1" class="gt_row gt_right">−0.068<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model2" class="gt_row gt_right">−0.031<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model3" class="gt_row gt_right">−0.024</td></tr>
    <tr><th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_4 model1" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_4 model2" class="gt_row gt_right">(0.011)</td>
<td headers="stub_1_4 model3" class="gt_row gt_right">(0.012)</td></tr>
    <tr><th id="stub_1_5" scope="row" class="gt_row gt_left gt_stub">disp</th>
<td headers="stub_1_5 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_5 model2" class="gt_row gt_right">−0.001</td>
<td headers="stub_1_5 model3" class="gt_row gt_right">0.004</td></tr>
    <tr><th id="stub_1_6" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_6 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_6 model2" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_6 model3" class="gt_row gt_right">(0.013)</td></tr>
    <tr><th id="stub_1_7" scope="row" class="gt_row gt_left gt_stub">wt</th>
<td headers="stub_1_7 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_7 model2" class="gt_row gt_right">−3.801<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_7 model3" class="gt_row gt_right">−3.429<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_8" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_8 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_8 model2" class="gt_row gt_right">(1.066)</td>
<td headers="stub_1_8 model3" class="gt_row gt_right">(1.055)</td></tr>
    <tr><th id="stub_1_9" scope="row" class="gt_row gt_left gt_stub">as.factor(cyl)6</th>
<td headers="stub_1_9 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model3" class="gt_row gt_right">−3.466<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_10" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_10 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model3" class="gt_row gt_right">(1.463)</td></tr>
    <tr><th id="stub_1_11" scope="row" class="gt_row gt_left gt_stub">as.factor(cyl)8</th>
<td headers="stub_1_11 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model3" class="gt_row gt_right">−3.753</td></tr>
    <tr><th id="stub_1_12" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_12 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model3" class="gt_row gt_right">(2.814)</td></tr>
    <tr><th id="stub_1_13" scope="row" class="gt_row gt_left gt_stub">N</th>
<td headers="stub_1_13 model1" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model2" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model3" class="gt_row gt_right">32</td></tr>
    <tr><th id="stub_1_14" scope="row" class="gt_row gt_left gt_stub">rsquared</th>
<td headers="stub_1_14 model1" class="gt_row gt_right">0.602</td>
<td headers="stub_1_14 model2" class="gt_row gt_right">0.827</td>
<td headers="stub_1_14 model3" class="gt_row gt_right">0.858</td></tr>
    <tr><th id="stub_1_15" scope="row" class="gt_row gt_left gt_stub">bic</th>
<td headers="stub_1_15 model1" class="gt_row gt_right">185.636</td>
<td headers="stub_1_15 model2" class="gt_row gt_right">165.972</td>
<td headers="stub_1_15 model3" class="gt_row gt_right">166.600</td></tr>
  </tbody>
  &#10;  <tfoot>
    <tr class="gt_footnotes">
      <td class="gt_footnote" colspan="4">
        <div style="padding-bottom:2px;"><span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span> p &lt; 0.05</div>
      </td>
    </tr>
  </tfoot>
</table>
</div>

Now lets change the variable labels by creating a named vector that
gives us the correspondence between old and new names.

``` r
# create a named vector or labels for the variable names
name_corr <- c("Intercept" = "Constant",
               "hp" = "Horsepower",
               "disp" = "Displacement (cu. in.)",
               "wt" = "Weight (1000 lbs)",
               "as.factor\\(cyl\\)6" = "6-cylinder",
               "as.factor\\(cyl\\)8" = "8-cylinder",
               "rsquared" = "R-squared",
               "bic" = "BIC")

gt_model(list(model1, model2, model3), summary_stats=c("rsquared","bic"),
         var_labels = name_corr)
```

<div id="cpecdljjpt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cpecdljjpt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#cpecdljjpt thead, #cpecdljjpt tbody, #cpecdljjpt tfoot, #cpecdljjpt tr, #cpecdljjpt td, #cpecdljjpt th {
  border-style: none;
}
&#10;#cpecdljjpt p {
  margin: 0;
  padding: 0;
}
&#10;#cpecdljjpt .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#cpecdljjpt .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#cpecdljjpt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#cpecdljjpt .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#cpecdljjpt .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#cpecdljjpt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#cpecdljjpt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#cpecdljjpt .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#cpecdljjpt .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#cpecdljjpt .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#cpecdljjpt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#cpecdljjpt .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#cpecdljjpt .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#cpecdljjpt .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#cpecdljjpt .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cpecdljjpt .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#cpecdljjpt .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#cpecdljjpt .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#cpecdljjpt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cpecdljjpt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#cpecdljjpt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cpecdljjpt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#cpecdljjpt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cpecdljjpt .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#cpecdljjpt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#cpecdljjpt .gt_left {
  text-align: left;
}
&#10;#cpecdljjpt .gt_center {
  text-align: center;
}
&#10;#cpecdljjpt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#cpecdljjpt .gt_font_normal {
  font-weight: normal;
}
&#10;#cpecdljjpt .gt_font_bold {
  font-weight: bold;
}
&#10;#cpecdljjpt .gt_font_italic {
  font-style: italic;
}
&#10;#cpecdljjpt .gt_super {
  font-size: 65%;
}
&#10;#cpecdljjpt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#cpecdljjpt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#cpecdljjpt .gt_indent_1 {
  text-indent: 5px;
}
&#10;#cpecdljjpt .gt_indent_2 {
  text-indent: 10px;
}
&#10;#cpecdljjpt .gt_indent_3 {
  text-indent: 15px;
}
&#10;#cpecdljjpt .gt_indent_4 {
  text-indent: 20px;
}
&#10;#cpecdljjpt .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id=""></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model1">model1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model2">model2</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="model3">model3</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub">Constant</th>
<td headers="stub_1_1 model1" class="gt_row gt_right">30.099<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model2" class="gt_row gt_right">37.106<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model3" class="gt_row gt_right">36.002<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_2 model1" class="gt_row gt_right">(1.634)</td>
<td headers="stub_1_2 model2" class="gt_row gt_right">(2.111)</td>
<td headers="stub_1_2 model3" class="gt_row gt_right">(2.131)</td></tr>
    <tr><th id="stub_1_3" scope="row" class="gt_row gt_left gt_stub">Horsepower</th>
<td headers="stub_1_3 model1" class="gt_row gt_right">−0.068<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model2" class="gt_row gt_right">−0.031<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model3" class="gt_row gt_right">−0.024</td></tr>
    <tr><th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_4 model1" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_4 model2" class="gt_row gt_right">(0.011)</td>
<td headers="stub_1_4 model3" class="gt_row gt_right">(0.012)</td></tr>
    <tr><th id="stub_1_5" scope="row" class="gt_row gt_left gt_stub">Displacement (cu. in.)</th>
<td headers="stub_1_5 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_5 model2" class="gt_row gt_right">−0.001</td>
<td headers="stub_1_5 model3" class="gt_row gt_right">0.004</td></tr>
    <tr><th id="stub_1_6" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_6 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_6 model2" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_6 model3" class="gt_row gt_right">(0.013)</td></tr>
    <tr><th id="stub_1_7" scope="row" class="gt_row gt_left gt_stub">Weight (1000 lbs)</th>
<td headers="stub_1_7 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_7 model2" class="gt_row gt_right">−3.801<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_7 model3" class="gt_row gt_right">−3.429<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_8" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_8 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_8 model2" class="gt_row gt_right">(1.066)</td>
<td headers="stub_1_8 model3" class="gt_row gt_right">(1.055)</td></tr>
    <tr><th id="stub_1_9" scope="row" class="gt_row gt_left gt_stub">6-cylinder</th>
<td headers="stub_1_9 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model3" class="gt_row gt_right">−3.466<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_10" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_10 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model3" class="gt_row gt_right">(1.463)</td></tr>
    <tr><th id="stub_1_11" scope="row" class="gt_row gt_left gt_stub">8-cylinder</th>
<td headers="stub_1_11 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model3" class="gt_row gt_right">−3.753</td></tr>
    <tr><th id="stub_1_12" scope="row" class="gt_row gt_left gt_stub"></th>
<td headers="stub_1_12 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model3" class="gt_row gt_right">(2.814)</td></tr>
    <tr><th id="stub_1_13" scope="row" class="gt_row gt_left gt_stub">N</th>
<td headers="stub_1_13 model1" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model2" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model3" class="gt_row gt_right">32</td></tr>
    <tr><th id="stub_1_14" scope="row" class="gt_row gt_left gt_stub">R-squared</th>
<td headers="stub_1_14 model1" class="gt_row gt_right">0.602</td>
<td headers="stub_1_14 model2" class="gt_row gt_right">0.827</td>
<td headers="stub_1_14 model3" class="gt_row gt_right">0.858</td></tr>
    <tr><th id="stub_1_15" scope="row" class="gt_row gt_left gt_stub">BIC</th>
<td headers="stub_1_15 model1" class="gt_row gt_right">185.636</td>
<td headers="stub_1_15 model2" class="gt_row gt_right">165.972</td>
<td headers="stub_1_15 model3" class="gt_row gt_right">166.600</td></tr>
  </tbody>
  &#10;  <tfoot>
    <tr class="gt_footnotes">
      <td class="gt_footnote" colspan="4">
        <div style="padding-bottom:2px;"><span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span> p &lt; 0.05</div>
      </td>
    </tr>
  </tfoot>
</table>
</div>

I have taken this about as far as I want with the basic command, but now
I can process it further by just piping it into subsequent `gt`
commands:

``` r
gt_model(list(model1, model2, model3), summary_stats=c("rsquared","bic"),
         var_labels = name_corr) |>
  cols_label(model1 = "(1)", model2 = "(2)", model3 = "(3)") |>
  fmt_number(rows = c("Constant", "BIC"), decimals = 1) |>
  tab_source_note(md("*Notes:* Standard errors shown in parenthesis.")) |>
  tab_options(table.width = "100%", row.striping.include_stub = TRUE)
```

<div id="iaxkwmwjpw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#iaxkwmwjpw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#iaxkwmwjpw thead, #iaxkwmwjpw tbody, #iaxkwmwjpw tfoot, #iaxkwmwjpw tr, #iaxkwmwjpw td, #iaxkwmwjpw th {
  border-style: none;
}
&#10;#iaxkwmwjpw p {
  margin: 0;
  padding: 0;
}
&#10;#iaxkwmwjpw .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#iaxkwmwjpw .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#iaxkwmwjpw .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#iaxkwmwjpw .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#iaxkwmwjpw .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#iaxkwmwjpw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#iaxkwmwjpw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#iaxkwmwjpw .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#iaxkwmwjpw .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#iaxkwmwjpw .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#iaxkwmwjpw .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#iaxkwmwjpw .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#iaxkwmwjpw .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#iaxkwmwjpw .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#iaxkwmwjpw .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#iaxkwmwjpw .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#iaxkwmwjpw .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#iaxkwmwjpw .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#iaxkwmwjpw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#iaxkwmwjpw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#iaxkwmwjpw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#iaxkwmwjpw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#iaxkwmwjpw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#iaxkwmwjpw .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#iaxkwmwjpw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#iaxkwmwjpw .gt_left {
  text-align: left;
}
&#10;#iaxkwmwjpw .gt_center {
  text-align: center;
}
&#10;#iaxkwmwjpw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#iaxkwmwjpw .gt_font_normal {
  font-weight: normal;
}
&#10;#iaxkwmwjpw .gt_font_bold {
  font-weight: bold;
}
&#10;#iaxkwmwjpw .gt_font_italic {
  font-style: italic;
}
&#10;#iaxkwmwjpw .gt_super {
  font-size: 65%;
}
&#10;#iaxkwmwjpw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#iaxkwmwjpw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#iaxkwmwjpw .gt_indent_1 {
  text-indent: 5px;
}
&#10;#iaxkwmwjpw .gt_indent_2 {
  text-indent: 10px;
}
&#10;#iaxkwmwjpw .gt_indent_3 {
  text-indent: 15px;
}
&#10;#iaxkwmwjpw .gt_indent_4 {
  text-indent: 20px;
}
&#10;#iaxkwmwjpw .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id=""></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="(1)">(1)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="(2)">(2)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="(3)">(3)</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub">Constant</th>
<td headers="stub_1_1 model1" class="gt_row gt_right">30.1<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model2" class="gt_row gt_right">37.1<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_1 model3" class="gt_row gt_right">36.0<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub  gt_striped"></th>
<td headers="stub_1_2 model1" class="gt_row gt_right">(1.634)</td>
<td headers="stub_1_2 model2" class="gt_row gt_right">(2.111)</td>
<td headers="stub_1_2 model3" class="gt_row gt_right">(2.131)</td></tr>
    <tr><th id="stub_1_3" scope="row" class="gt_row gt_left gt_stub">Horsepower</th>
<td headers="stub_1_3 model1" class="gt_row gt_right">−0.068<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model2" class="gt_row gt_right">−0.031<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_3 model3" class="gt_row gt_right">−0.024</td></tr>
    <tr><th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub  gt_striped"></th>
<td headers="stub_1_4 model1" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_4 model2" class="gt_row gt_right">(0.011)</td>
<td headers="stub_1_4 model3" class="gt_row gt_right">(0.012)</td></tr>
    <tr><th id="stub_1_5" scope="row" class="gt_row gt_left gt_stub">Displacement (cu. in.)</th>
<td headers="stub_1_5 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_5 model2" class="gt_row gt_right">−0.001</td>
<td headers="stub_1_5 model3" class="gt_row gt_right">0.004</td></tr>
    <tr><th id="stub_1_6" scope="row" class="gt_row gt_left gt_stub  gt_striped"></th>
<td headers="stub_1_6 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_6 model2" class="gt_row gt_right">(0.010)</td>
<td headers="stub_1_6 model3" class="gt_row gt_right">(0.013)</td></tr>
    <tr><th id="stub_1_7" scope="row" class="gt_row gt_left gt_stub">Weight (1000 lbs)</th>
<td headers="stub_1_7 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_7 model2" class="gt_row gt_right">−3.801<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td>
<td headers="stub_1_7 model3" class="gt_row gt_right">−3.429<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_8" scope="row" class="gt_row gt_left gt_stub  gt_striped"></th>
<td headers="stub_1_8 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_8 model2" class="gt_row gt_right">(1.066)</td>
<td headers="stub_1_8 model3" class="gt_row gt_right">(1.055)</td></tr>
    <tr><th id="stub_1_9" scope="row" class="gt_row gt_left gt_stub">6-cylinder</th>
<td headers="stub_1_9 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_9 model3" class="gt_row gt_right">−3.466<span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span></td></tr>
    <tr><th id="stub_1_10" scope="row" class="gt_row gt_left gt_stub  gt_striped"></th>
<td headers="stub_1_10 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_10 model3" class="gt_row gt_right">(1.463)</td></tr>
    <tr><th id="stub_1_11" scope="row" class="gt_row gt_left gt_stub">8-cylinder</th>
<td headers="stub_1_11 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_11 model3" class="gt_row gt_right">−3.753</td></tr>
    <tr><th id="stub_1_12" scope="row" class="gt_row gt_left gt_stub  gt_striped"></th>
<td headers="stub_1_12 model1" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model2" class="gt_row gt_right"><br /></td>
<td headers="stub_1_12 model3" class="gt_row gt_right">(2.814)</td></tr>
    <tr><th id="stub_1_13" scope="row" class="gt_row gt_left gt_stub">N</th>
<td headers="stub_1_13 model1" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model2" class="gt_row gt_right">32</td>
<td headers="stub_1_13 model3" class="gt_row gt_right">32</td></tr>
    <tr><th id="stub_1_14" scope="row" class="gt_row gt_left gt_stub  gt_striped">R-squared</th>
<td headers="stub_1_14 model1" class="gt_row gt_right">0.602</td>
<td headers="stub_1_14 model2" class="gt_row gt_right">0.827</td>
<td headers="stub_1_14 model3" class="gt_row gt_right">0.858</td></tr>
    <tr><th id="stub_1_15" scope="row" class="gt_row gt_left gt_stub">BIC</th>
<td headers="stub_1_15 model1" class="gt_row gt_right">185.6</td>
<td headers="stub_1_15 model2" class="gt_row gt_right">166.0</td>
<td headers="stub_1_15 model3" class="gt_row gt_right">166.6</td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="4"><em>Notes:</em> Standard errors shown in parenthesis.</td>
    </tr>
  </tfoot>
  <tfoot>
    <tr class="gt_footnotes">
      <td class="gt_footnote" colspan="4">
        <div style="padding-bottom:2px;"><span class="gt_footnote_marks gt_asterisk" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>*</sup></span> p &lt; 0.05</div>
      </td>
    </tr>
  </tfoot>
</table>
</div>
