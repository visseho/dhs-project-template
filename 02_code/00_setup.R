## ============================================================
## 00_setup.R
## Charge les paquets, la configuration, les fonctions
## utilitaires et définit les options globales.
## À sourcer en premier dans toute session de travail.
## ============================================================

# ---- Paquets requis ----------------------------------------
# Utilisez renv pour la reproductibilité :
#   renv::init()      # une seule fois au début du projet
#   renv::snapshot()  # après avoir installé un nouveau paquet
#   renv::restore()   # pour reconstruire l'environnement
#                       sur une nouvelle machine

required_packages <- c(
  "haven",        # Lecture des fichiers Stata (.DTA)
  "labelled",     # Manipulation des variables étiquetées
  "dplyr", "tidyr", "stringr", "forcats", "purrr", "readr",
  "survey",       # Plans de sondage complexes
  "srvyr",        # Interface tidyverse pour survey
  "gtsummary",    # Tableaux de publication
  "broom",        # Nettoyage des sorties de modèles
  "ggplot2", "ggthemes", "patchwork",
  "yaml",
  "here",         # Gestion des chemins
  "fs",
  "lme4",         # Modèles multiniveaux
  "marginaleffects",
  "cli"
)

missing <- setdiff(required_packages, rownames(installed.packages()))
if (length(missing) > 0) {
  message("Installation des paquets manquants : ",
          paste(missing, collapse = ", "))
  install.packages(missing)
}

invisible(lapply(required_packages, library, character.only = TRUE))

# ---- Chargement de la configuration ------------------------
# D'abord la config partagée du projet (_config.yml, versionnée),
# puis la config locale de l'utilisateur·rice (_config_local.yml,
# gitignorée) qui peut surcharger les chemins pour cette machine.

config <- yaml::read_yaml(here::here("_config.yml"))

local_cfg_path <- here::here("_config_local.yml")
if (file.exists(local_cfg_path)) {
  local_cfg <- yaml::read_yaml(local_cfg_path)
  config <- utils::modifyList(config, local_cfg)
  cli::cli_alert_info("Config locale chargée depuis _config_local.yml")
}

# ---- Résolution des chemins --------------------------------
# Les chemins relatifs du _config.yml sont transformés en absolus
# via here::here(). Les chemins absolus (venant du _config_local.yml,
# par ex. /mnt/data/DHS) sont conservés tels quels.

resolve_path <- function(p) {
  if (fs::is_absolute_path(p)) p else here::here(p)
}
paths <- lapply(config$paths, resolve_path)

for (p in paths) if (!dir.exists(p)) dir.create(p, recursive = TRUE)

# ---- Chargement des fonctions utilitaires ------------------
fn_dir <- here::here("02_code", "functions")
for (f in list.files(fn_dir, pattern = "\\.R$", full.names = TRUE)) {
  source(f)
}

# ---- Options globales --------------------------------------
options(
  survey.lonely.psu       = "adjust",
  scipen                  = 999,
  dplyr.summarise.inform  = FALSE
)

set.seed(20260514)

cli::cli_alert_success(
  "Setup complete. Loaded {length(required_packages)} packages."
)
