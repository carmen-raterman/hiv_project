here::i_am("code/00_clean_data.R")
absolute_path_to_data <- here::here("raw_data", "vrc01_data.csv")
data <- read.csv(absolute_path_to_data, header = TRUE)

library(labelled)
library(gtsummary)

var_label(data) <- list(
  id = "ID",
  ab_resistance = "Antibody resistance",
  shield_glycans = "Shield glycans",
  region = "Region",
  env_length = "Length of Env protein"
)

data$number_glycans <- ifelse(data$shield_glycans < 4, "< 4", ">= 4")

print("I executed without any errors.")

# this saves an objects created in R that we can load from a different R session later
saveRDS(
  data,
  file = here::here("output/data_clean.rds")
)
