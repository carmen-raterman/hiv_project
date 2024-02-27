here::i_am("code/04_render_report.R")

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
config_list <- config::get(
  config = WHICH_CONFIG
)

library(rmarkdown)

report_filename <- paste0(
  "hiv_report_config_",
  WHICH_CONFIG,
  ".html"
)
# rendering a report in production mode
render(
  "hiv_report.Rmd",
  output_file = report_filename
)

# rendering a report in "test" mode
render("hiv_report.Rmd")