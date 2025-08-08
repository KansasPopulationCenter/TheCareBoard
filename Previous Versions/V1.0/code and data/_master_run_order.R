library(rmarkdown)
setwd("~/GitHub/CareBoard/03_metric-tables/_updated_scripts")

quarto_files <- c(
  "market",
  "market_datum",
  "care_provider",
  "activity_formal",
  "activity_informal",
  "broad_impacts",
  "gini",
  "sandwich_generation", 
  "care_ratio"
)

# # alternative to run using R Scripts
# for(file in quarto_files){
#   input <- paste0(file, ".qmd")
#   output <- paste0(file, ".R")
# 
#   knitr::purl(input, output)
#   
#   source(output)
#   print(paste0(file, " processed"))
# }

for(q_file in quarto_files){
  render(paste0(q_file, ".qmd"), output_format = NULL)
  file.remove(paste0(q_file, ".html"))
}
