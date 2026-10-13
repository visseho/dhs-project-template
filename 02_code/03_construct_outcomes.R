## ============================================================
## 03_construct_outcomes.R
## PERSONNALISER CE SCRIPT POUR VOTRE PROJET.
##
## Construit la ou les variables d'issue à partir des données
## harmonisées. Documentez chaque issue dans
## 04_docs/codebook.md au moment où vous la créez.
## ============================================================

source(here::here("02_code", "00_setup.R"))

grid <- country_survey_grid(config)

cli::cli_h1("Construction des issues (à personnaliser)")
cli::cli_alert_info("Ce script est un gabarit vide. Ajoutez-y la construction de vos issues.")

# Exemple (à adapter) :
# purrr::pwalk(grid, function(country, survey) {
#   p <- file.path(paths$data_interim, country, survey, "harmonised", "ir.rds")
#   if (!file.exists(p)) return(invisible(NULL))
#   d <- readRDS(p)
#   d$mon_issue <- as.integer(d$variable_source == 1)
#   saveRDS(d, p)
# })
