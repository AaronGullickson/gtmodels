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

# Rounding digits works as expected

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\ncoef:(Intercept) & $30.10$\\textsuperscript{\\textit{*}} & $37.11$\\textsuperscript{\\textit{*}} & $36.00$\\textsuperscript{\\textit{*}} \\\\ \n & ($1.63$) & ($2.11$) & ($2.13$) \\\\ \ncoef:hp & $-0.07$\\textsuperscript{\\textit{*}} & $-0.03$\\textsuperscript{\\textit{*}} & $-0.02$ \\\\ \n & ($0.01$) & ($0.01$) & ($0.01$) \\\\ \ncoef:disp &  & $0.00$ & $0.00$ \\\\ \n &  & ($0.01$) & ($0.01$) \\\\ \ncoef:wt &  & $-3.80$\\textsuperscript{\\textit{*}} & $-3.43$\\textsuperscript{\\textit{*}} \\\\ \n &  & ($1.07$) & ($1.06$) \\\\ \ncoef:as.factor(cyl)6 &  &  & $-3.47$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & ($1.46$) \\\\ \ncoef:as.factor(cyl)8 &  &  & $-3.75$ \\\\ \n &  &  & ($2.81$) \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
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

# Variable labels are correctly applied

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

# Parenthetical value can be changed

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\ncoef:(Intercept) & $30.099$\\textsuperscript{\\textit{*}} & $37.106$\\textsuperscript{\\textit{*}} & $36.002$\\textsuperscript{\\textit{*}} \\\\ \n & ($18.421$) & ($17.579$) & ($16.897$) \\\\ \ncoef:hp & $-0.068$\\textsuperscript{\\textit{*}} & $-0.031$\\textsuperscript{\\textit{*}} & $-0.024$ \\\\ \n & ($-6.742$) & ($-2.724$) & ($-1.925$) \\\\ \ncoef:disp &  & $-0.001$ & $0.004$ \\\\ \n &  & ($-0.091$) & ($0.325$) \\\\ \ncoef:wt &  & $-3.801$\\textsuperscript{\\textit{*}} & $-3.429$\\textsuperscript{\\textit{*}} \\\\ \n &  & ($-3.565$) & ($-3.248$) \\\\ \ncoef:as.factor(cyl)6 &  &  & $-3.466$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & ($-2.369$) \\\\ \ncoef:as.factor(cyl)8 &  &  & $-3.753$ \\\\ \n &  &  & ($-1.334$) \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
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

---

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\ncoef:(Intercept) & $30.099$\\textsuperscript{\\textit{*}} & $37.106$\\textsuperscript{\\textit{*}} & $36.002$\\textsuperscript{\\textit{*}} \\\\ \n & ($0.000$) & ($0.000$) & ($0.000$) \\\\ \ncoef:hp & $-0.068$\\textsuperscript{\\textit{*}} & $-0.031$\\textsuperscript{\\textit{*}} & $-0.024$ \\\\ \n & ($0.000$) & ($0.011$) & ($0.065$) \\\\ \ncoef:disp &  & $-0.001$ & $0.004$ \\\\ \n &  & ($0.929$) & ($0.748$) \\\\ \ncoef:wt &  & $-3.801$\\textsuperscript{\\textit{*}} & $-3.429$\\textsuperscript{\\textit{*}} \\\\ \n &  & ($0.001$) & ($0.003$) \\\\ \ncoef:as.factor(cyl)6 &  &  & $-3.466$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & ($0.026$) \\\\ \ncoef:as.factor(cyl)8 &  &  & $-3.753$ \\\\ \n &  &  & ($0.194$) \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
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

# Parenthetical type can be changed

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\ncoef:(Intercept) & $30.099$\\textsuperscript{\\textit{*}} & $37.106$\\textsuperscript{\\textit{*}} & $36.002$\\textsuperscript{\\textit{*}} \\\\ \n & [$1.634$] & [$2.111$] & [$2.131$] \\\\ \ncoef:hp & $-0.068$\\textsuperscript{\\textit{*}} & $-0.031$\\textsuperscript{\\textit{*}} & $-0.024$ \\\\ \n & [$0.010$] & [$0.011$] & [$0.012$] \\\\ \ncoef:disp &  & $-0.001$ & $0.004$ \\\\ \n &  & [$0.010$] & [$0.013$] \\\\ \ncoef:wt &  & $-3.801$\\textsuperscript{\\textit{*}} & $-3.429$\\textsuperscript{\\textit{*}} \\\\ \n &  & [$1.066$] & [$1.055$] \\\\ \ncoef:as.factor(cyl)6 &  &  & $-3.466$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & [$1.463$] \\\\ \ncoef:as.factor(cyl)8 &  &  & $-3.753$ \\\\ \n &  &  & [$2.814$] \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
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

---

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\ncoef:(Intercept) & $30.099$\\textsuperscript{\\textit{*}} & $37.106$\\textsuperscript{\\textit{*}} & $36.002$\\textsuperscript{\\textit{*}} \\\\ \n & {$1.634$} & {$2.111$} & {$2.131$} \\\\ \ncoef:hp & $-0.068$\\textsuperscript{\\textit{*}} & $-0.031$\\textsuperscript{\\textit{*}} & $-0.024$ \\\\ \n & {$0.010$} & {$0.011$} & {$0.012$} \\\\ \ncoef:disp &  & $-0.001$ & $0.004$ \\\\ \n &  & {$0.010$} & {$0.013$} \\\\ \ncoef:wt &  & $-3.801$\\textsuperscript{\\textit{*}} & $-3.429$\\textsuperscript{\\textit{*}} \\\\ \n &  & {$1.066$} & {$1.055$} \\\\ \ncoef:as.factor(cyl)6 &  &  & $-3.466$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & {$1.463$} \\\\ \ncoef:as.factor(cyl)8 &  &  & $-3.753$ \\\\ \n &  &  & {$2.814$} \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
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

# A transformation function can be applied

    Code
      as_latex(tbl)
    Output
      [1] "\\begin{table}\n\\begin{tabular*}{\\linewidth}{@{\\extracolsep{\\fill}}l|rrr}\n\\toprule\n\\multicolumn{1}{l}{} & model1 & model2 & model3 \\\\ \n\\midrule\\addlinespace[2.5pt]\ncoef:(Intercept) & $11,796,931,127,359.479$\\textsuperscript{\\textit{*}} & $13,023,154,312,206,508.000$\\textsuperscript{\\textit{*}} & $4,321,610,379,402,674.500$\\textsuperscript{\\textit{*}} \\\\ \n & ($1.634$) & ($2.111$) & ($2.131$) \\\\ \ncoef:hp & $0.934$\\textsuperscript{\\textit{*}} & $0.969$\\textsuperscript{\\textit{*}} & $0.977$ \\\\ \n & ($0.010$) & ($0.011$) & ($0.012$) \\\\ \ncoef:disp &  & $0.999$ & $1.004$ \\\\ \n &  & ($0.010$) & ($0.013$) \\\\ \ncoef:wt &  & $0.022$\\textsuperscript{\\textit{*}} & $0.032$\\textsuperscript{\\textit{*}} \\\\ \n &  & ($1.066$) & ($1.055$) \\\\ \ncoef:as.factor(cyl)6 &  &  & $0.031$\\textsuperscript{\\textit{*}} \\\\ \n &  &  & ($1.463$) \\\\ \ncoef:as.factor(cyl)8 &  &  & $0.023$ \\\\ \n &  &  & ($2.814$) \\\\ \nN & $32$ & $32$ & $32$ \\\\ \n\\bottomrule\n\\end{tabular*}\n\\begin{minipage}{\\linewidth}\n\\textsuperscript{\\textit{*}}p < 0.05\\\\\n\\end{minipage}\n\\end{table}\n"
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

