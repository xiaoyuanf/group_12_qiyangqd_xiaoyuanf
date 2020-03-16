# author: Qi Yang
# date: 2020-03-16

"This script knits the final report to .pdf and .html.

Usage: knit.R --rmd_path=<rmd_path>
" -> doc

# Load library
library(docopt)

# Main command
opt <- docopt(doc)

main <- function(rmd_path) {
  rmarkdown::render(rmd_path,
                    c("html_document", "pdf_document"))
  print("The final report is knitted to the docs folder!")
}

#' @param finalreport_path is where the .rmd of final report is. 

main(opt$rmd_path)