## ============================================================
## 02_harmonize_variables.R
## Harmonise les noms de variables entre pays. Les codes DHS
## sont relativement standards mais certaines variables varient
## (ex. ethnicité, religion, variables de biomarqueurs).
##
## À personnaliser pour votre projet : définissez vos propres
## cartes de renommage ir_rename et mr_rename ci-dessous.
## ============================================================

source(here::here("02_code", "00_setup.R"))

grid <- country_survey_grid(config)

# ---- Carte de renommage pour le recode femmes (IR) ----------
# Format : nom_cible = "nom_source_DHS"
ir_rename <- c(
  id              = "caseid",
  cluster         = "v001",
  weight_raw      = "v005",
  psu             = "v021",
  stratum         = "v022",
  region          = "v024",
  urban           = "v025",
  age             = "v012",
  educ_level      = "v106",
  wealth_q        = "v190",
  marital_status  = "v501",
  # Ajoutez les variables de VOTRE projet ici
  NULL
)

# ---- Carte de renommage pour le recode hommes (MR) ----------
mr_rename <- c(
  id              = "mcaseid",
  cluster         = "mv001",
  weight_raw      = "mv005",
  psu             = "mv021",
  stratum         = "mv022",
  region          = "mv024",
  urban           = "mv025",
  age             = "mv012",
  educ_level      = "mv106",
  wealth_q        = "mv190",
  marital_status  = "mv501",
  NULL
)

harmonise <- function(data, rename_map, sex) {
  if (is.null(data)) return(NULL)
  keep <- intersect(rename_map, names(data))
  if (length(keep) == 0) return(NULL)
  reverse <- setNames(names(rename_map)[match(keep, rename_map)], keep)
  out <- data |>
    dplyr::select(dplyr::all_of(keep)) |>
    dplyr::rename_with(~ reverse[.x])
  out$sex    <- sex
  out$weight <- out$weight_raw / 1e6
  out
}

cli::cli_h1("Harmonisation des variables")

purrr::pwalk(grid, function(country, survey) {
  in_dir  <- file.path(paths$data_interim, country, survey)
  out_dir <- file.path(in_dir, "harmonised")
  if (!dir.exists(out_dir)) dir.create(out_dir)

  ir <- if (file.exists(file.path(in_dir, "ir.rds"))) readRDS(file.path(in_dir, "ir.rds")) else NULL
  mr <- if (file.exists(file.path(in_dir, "mr.rds"))) readRDS(file.path(in_dir, "mr.rds")) else NULL

  ir_h <- harmonise(ir, ir_rename, sex = "female")
  mr_h <- harmonise(mr, mr_rename, sex = "male")

  if (!is.null(ir_h)) {
    ir_h$country <- country; ir_h$survey <- survey
    saveRDS(ir_h, file.path(out_dir, "ir.rds"))
  }
  if (!is.null(mr_h)) {
    mr_h$country <- country; mr_h$survey <- survey
    saveRDS(mr_h, file.path(out_dir, "mr.rds"))
  }

  cli::cli_alert_success("{country} | {survey} — harmonisé")
})
