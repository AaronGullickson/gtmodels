# The output of a basic gt_model is as expected

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\ncoef:(Intercept) & $30.099$\\textsuperscript{\\textit{*}} & $37.106$\\textsuperscript{\\textit{*}} & $36.002$\\textsuperscript{\\textit{*}} \\\\ \n & ($1.634$) & ($2.111$) & ($2.131$) \\\\ \ncoef:hp & $-0.068$\\textsuperscript{\\textit{*}} & $-0.031$\\textsuperscript{\\textit{*}} & $-0.024$ \\\\ \n & ($0.010$) & ($0.011$) & ($0.012$) \\\\ \ncoef:disp &  & $-0.001$ & $0.004$ \\\\ \n &  & ($0.010$) & ($0.013$) \\\\ \ncoef:wt &  & $-3.801$\\textsuperscript{\\textit{*}} & $-3.429$\\textsuperscript{\\textit{*}} \\\\ \n &  & ($1.066$) & ($1.055$) \\\\ \ncoef:as.factor(cyl)6 &  &  & $-3.466$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & ($1.463$) \\\\ \ncoef:as.factor(cyl)8 &  &  & $-3.753$ \\\\ \n &  &  & ($2.814$) \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
      attr(,"class")
      [1] "knit_asis"
      attr(,"knit_meta")
      attr(,"knit_meta")[[1]]
      $name
      [1] "booktabs"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[2]]
      $name
      [1] "caption"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[3]]
      $name
      [1] "longtable"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[4]]
      $name
      [1] "colortbl"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[5]]
      $name
      [1] "array"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_cacheable")
      [1] NA

# Variable labels can be correctly applied

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\nConstant & $30.099$\\textsuperscript{\\textit{*}} & $37.106$\\textsuperscript{\\textit{*}} & $36.002$\\textsuperscript{\\textit{*}} \\\\ \n & ($1.634$) & ($2.111$) & ($2.131$) \\\\ \nHorsepower & $-0.068$\\textsuperscript{\\textit{*}} & $-0.031$\\textsuperscript{\\textit{*}} & $-0.024$ \\\\ \n & ($0.010$) & ($0.011$) & ($0.012$) \\\\ \nDisplacement (cu. in.) &  & $-0.001$ & $0.004$ \\\\ \n &  & ($0.010$) & ($0.013$) \\\\ \nWeight (1000 lbs) &  & $-3.801$\\textsuperscript{\\textit{*}} & $-3.429$\\textsuperscript{\\textit{*}} \\\\ \n &  & ($1.066$) & ($1.055$) \\\\ \n6-cylinder &  &  & $-3.466$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & ($1.463$) \\\\ \n8-cylinder &  &  & $-3.753$ \\\\ \n &  &  & ($2.814$) \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
      attr(,"class")
      [1] "knit_asis"
      attr(,"knit_meta")
      attr(,"knit_meta")[[1]]
      $name
      [1] "booktabs"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[2]]
      $name
      [1] "caption"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[3]]
      $name
      [1] "longtable"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[4]]
      $name
      [1] "colortbl"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_meta")[[5]]
      $name
      [1] "array"
      
      $options
      NULL
      
      $extra_lines
      NULL
      
      attr(,"class")
      [1] "latex_dependency"
      
      attr(,"knit_cacheable")
      [1] NA

