## ============================================================
## 01_import_dhs.R
## Lit les recodes IR, MR, CR de chaque pays/enquête listé dans
## _config.yml et sauvegarde en .rds dans 01_data/interim/.
## Idempotent : relancer écrase les .rds existants.
## ============================================================

source(here::here("02_code", "00_setup.R"))

grid <- country_survey_grid(config)

cli::cli_h1("Import des recodes DHS")

import_one <- function(country, survey) {
  cli::cli_h2("{country} | {survey}")

  ir_path <- find_dhs_file(country, survey, "IR", paths$data_raw)
  mr_path <- find_dhs_file(country, survey, "MR", paths$data_raw)
  cr_path <- find_dhs_file(country, survey, "CR", paths$data_raw)

  ir <- read_dhs(ir_path)
  mr <- read_dhs(mr_path)
  cr <- read_dhs(cr_path)

  out_dir <- file.path(paths$data_interim, country, survey)
  if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)

  if (!is.null(ir)) saveRDS(ir, file.path(out_dir, "ir.rds"))
  if (!is.null(mr)) saveRDS(mr, file.path(out_dir, "mr.rds"))
  if (!is.null(cr)) saveRDS(cr, file.path(out_dir, "cr.rds"))

  cli::cli_alert_success("Fichiers intermédiaires sauvegardés dans {out_dir}")
}

purrr::pwalk(grid, import_one)

cli::cli_alert_success("Import terminé.")
