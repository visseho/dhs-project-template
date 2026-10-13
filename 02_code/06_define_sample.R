## ============================================================
## 06_define_sample.R
## Applique les critères d'inclusion/exclusion et pool tous
## les fichiers harmonisés en un dataset analytique.
## ============================================================

source(here::here("02_code", "00_setup.R"))

grid <- country_survey_grid(config)

# ---- Pooler les femmes -------------------------------------
women <- purrr::pmap_dfr(grid, function(country, survey) {
  p <- file.path(paths$data_interim, country, survey, "harmonised", "ir.rds")
  if (file.exists(p)) readRDS(p) else NULL
})

# ---- Pooler les hommes -------------------------------------
men <- purrr::pmap_dfr(grid, function(country, survey) {
  p <- file.path(paths$data_interim, country, survey, "harmonised", "mr.rds")
  if (file.exists(p)) readRDS(p) else NULL
})

# ---- Restrictions d'échantillon ----------------------------
apply_restrictions <- function(d, sex_label) {
  cli::cli_h2("Restrictions : {sex_label}")
  n0 <- nrow(d)
  cli::cli_alert("Départ n = {n0}")

  age_lo <- if (sex_label == "femmes") config$analysis$women_age_min else config$analysis$men_age_min
  age_hi <- if (sex_label == "femmes") config$analysis$women_age_max else config$analysis$men_age_max
  d <- d |> dplyr::filter(age >= age_lo, age <= age_hi)
  cli::cli_alert("Après filtre d'âge : n = {nrow(d)}")

  d
}

if (nrow(women) > 0) women <- apply_restrictions(women, "femmes")
if (nrow(men)   > 0) men   <- apply_restrictions(men,   "hommes")

# ---- Remise à l'échelle des pondérations -------------------
if (nrow(women) > 0) women <- rescale_weights(women, method = config$analysis$weight_rescale)
if (nrow(men)   > 0) men   <- rescale_weights(men,   method = config$analysis$weight_rescale)

# ---- Sauvegarde --------------------------------------------
saveRDS(women, file.path(paths$data_processed, "women_analytical.rds"))
saveRDS(men,   file.path(paths$data_processed, "men_analytical.rds"))

cli::cli_alert_success("Datasets analytiques sauvegardés dans {paths$data_processed}")
