## ============================================================
## 05_construct_covariates.R
## Recode les covariables (éducation, richesse, résidence, etc.)
## en catégories cohérentes entre pays.
## ============================================================

source(here::here("02_code", "00_setup.R"))

grid <- country_survey_grid(config)

recode_covariates <- function(d) {
  d |>
    dplyr::mutate(
      age_group = cut(age,
        breaks = c(14, 19, 24, 29, 34, 39, 44, 49, 54, 60),
        labels = c("15-19","20-24","25-29","30-34","35-39",
                   "40-44","45-49","50-54","55-59"),
        right = TRUE),
      educ_cat = dplyr::case_when(
        educ_level == 0 ~ "aucune",
        educ_level == 1 ~ "primaire",
        educ_level == 2 ~ "secondaire",
        educ_level == 3 ~ "supérieure",
        TRUE ~ NA_character_
      ),
      educ_cat = factor(educ_cat,
        levels = c("aucune","primaire","secondaire","supérieure")),
      urban = factor(urban, levels = c(1,2),
                     labels = c("urbain","rural")),
      wealth_q = factor(wealth_q,
        levels = 1:5,
        labels = c("plus pauvre","pauvre","moyen","riche","plus riche"))
    )
}

cli::cli_h1("Recodage des covariables")

purrr::pwalk(grid, function(country, survey) {
  for (f in c("ir.rds", "mr.rds")) {
    p <- file.path(paths$data_interim, country, survey, "harmonised", f)
    if (file.exists(p)) {
      d <- readRDS(p) |> recode_covariates()
      saveRDS(d, p)
      cli::cli_alert_success("{country}/{survey}/{f} — covariables recodées")
    }
  }
})
