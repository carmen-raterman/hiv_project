# this is going to fit both primary and secondary model
here::i_am("code/03_models.R")

data <- readRDS(
  file = here::here("output/data_clean.rds")
)

library(gtsummary)

mod <- glm(
  ab_resistance ~ shield_glycans + region + env_length,
  data = data
)

primary_regression_table <- 
  tbl_regression(mod) |>
    add_global_p()

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
config_list <- config::get(
  config = WHICH_CONFIG
)

binary_mod <- glm(
  I(ab_resistance > config_list$cutpoint) ~ shield_glycans + region + env_length,
  data = data,
  family = binomial()
)

secondary_regression_table <-
  tbl_regression(binary_mod, exponentiate = TRUE) |>
    add_global_p()

tertiary_mod <- glm(
  I(ab_resistance > config_list$cutpoint) ~ shield_glycans + region + env_length,
  data = data,
  family = binomial(link = "probit")
)

tertiary_regression_table <-
  tbl_regression(tertiary_mod) |>
    add_global_p()

both_models <- list(
  primary = mod,
  secondary = binary_mod,
  tertiary = tertiary_mod
)

#if active config is test
#renaming, file will be called both_models_config_test.rds
both_models_filename <- paste0(
  "both_models_config_",
  WHICH_CONFIG,
  ".rds"
)
saveRDS(
  both_models,
  file = here::here("output", both_models_filename)
)

both_regression_tables <- list(
  primary = primary_regression_table,
  secondary = secondary_regression_table,
  tertiary = tertiary_regression_table
)

both_regression_tables_filename <- paste0(
  "both_regression_tables_config_",
  WHICH_CONFIG,
  ".rds"
)
saveRDS(
  both_regression_tables,
  file = here::here("output", both_regression_tables_filename)
)

print("I executed successfully")
