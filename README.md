# Gabarit de projet DHS — SSAPOPLAB

**Un dépôt-type reproductible pour tout projet de recherche quantitative utilisant les Enquêtes démographiques et de santé (DHS).**

Ce dépôt est un **template**. Pour démarrer votre projet :

1. Sur GitHub, cliquez sur le bouton vert **"Use this template"** → **"Create a new repository"**.
2. Donnez un nom à votre projet (ex. `these-marie-mariage-precoce`).
3. Clonez le nouveau dépôt sur votre ordinateur avec GitHub Desktop.
4. Lisez le fichier `04_docs/demarrage.md` pour l'installation et les premiers pas.

---

## À qui s'adresse ce gabarit ?

Aux étudiants et étudiantes à la maîtrise et au doctorat du **SSAPOPLAB** et du **Laboratoire de méthodologie de recherche** (UQAM), ainsi qu'à leurs collaborateur·rice·s, qui démarrent un projet d'analyse secondaire des DHS.

Il convient aussi, moyennant des adaptations, aux projets utilisant d'autres enquêtes à plan de sondage complexe (MICS, PHIA, WFS, enquêtes nationales type EDS).

## Ce que le gabarit vous donne, prêt à l'emploi

- **Une structure de dossiers standardisée** (données, code, documentation, sorties, manuscrit) qui vous suivra toute la thèse.
- **Un pipeline numéroté** de 11 scripts R qui va de la lecture des `.DTA` à la production des tableaux et figures finaux.
- **Des fonctions utilitaires** pour lire les recodes DHS, construire les objets de sondage pondéré, nettoyer les biomarqueurs.
- **Un `.gitignore` sécurisé** qui empêche de pousser les données DHS sur GitHub (violation des termes d'utilisation).
- **Un cadre de documentation** (plan pré-analyse, codebook, DAG causal, revue de littérature).
- **Un `Makefile`** pour relancer tout le pipeline en une commande.
- **Une gestion des chemins locaux** (`_config_local.yml`) pour que chaque membre de l'équipe puisse pointer vers son propre dossier de données sans conflit Git.

## Philosophie

Un projet de recherche quantitative est **du code**. Comme pour tout code sérieux :

1. **Les données brutes sont sanctuarisées.** On n'écrit jamais dans `01_data/raw/`. Tout traitement produit un nouveau fichier dans `interim/` ou `processed/`.
2. **Les constantes vivent dans un seul endroit** (`_config.yml`). Changer un seuil, c'est changer une ligne.
3. **Chaque script a UNE responsabilité claire**, documentée en tête de fichier.
4. **Le projet doit tourner sur l'ordinateur d'un collègue** sans modification du code (seul le `_config_local.yml` change).
5. **Git versionne tout sauf les données** (brutes et traitées) et les sorties volumineuses.
6. **On ne travaille jamais directement sur `main`** — toujours une branche par analyse ou feature, puis Pull Request.

## Structure

```
mon-projet/
├── README.md                   <- Fichier d'accueil (celui-ci, à adapter)
├── LICENSE                     <- MIT par défaut
├── .gitignore                  <- Protège les données et sorties
├── _config.yml                 <- Config partagée (chemins relatifs, paramètres)
├── _config_local.yml.example   <- Exemple de config perso (jamais commité)
├── renv.lock                   <- Versions des paquets R (à créer avec renv::snapshot())
├── Makefile                    <- make all → tout le pipeline
├── mon-projet.Rproj            <- Projet RStudio
│
├── 01_data/
│   ├── raw/                    <- Données DHS brutes (gitignorées)
│   ├── interim/                <- Fichiers .rds par pays
│   ├── processed/              <- Dataset analytique final
│   └── external/               <- Autres données (covariables pays, etc.)
│
├── 02_code/
│   ├── 00_setup.R              <- Packages + config + fonctions
│   ├── 01_import_dhs.R         <- .DTA → .rds
│   ├── 02_harmonize_variables.R
│   ├── 03_construct_outcomes.R
│   ├── 04_construct_exposure.R
│   ├── 05_construct_covariates.R
│   ├── 06_define_sample.R
│   ├── 07_descriptive_stats.R
│   ├── 08_main_models.R
│   ├── 09_sensitivity_analyses.R
│   ├── 10_mediation.R
│   ├── 11_tables_figures.R
│   └── functions/
│       ├── dhs_io.R
│       ├── survey_helpers.R
│       └── reporting.R
│
├── 03_output/                  <- Tableaux, figures, logs (gitignorés)
│
├── 04_docs/
│   ├── demarrage.md            <- GUIDE D'INSTALLATION — lisez d'abord
│   ├── checklist.md            <- Les 10 règles du labo
│   ├── analysis_plan.md        <- Plan pré-analyse à remplir
│   ├── codebook.md             <- Variables dérivées
│   ├── DAG.md                  <- Diagramme causal
│   ├── literature_review.md
│   └── data_access.md
│
├── 05_manuscript/              <- Article Quarto / LaTeX
├── notebooks/                  <- Explorations .qmd
└── references/                 <- Bibliographie (.bib)
```

## Démarrage rapide (3 étapes)

### 1. Installer les logiciels (une seule fois sur votre machine)

Voir `04_docs/demarrage.md` pour la liste complète. En bref : R, RStudio, Quarto, GitHub Desktop.

### 2. Cloner et ouvrir

Dans GitHub Desktop : `File → Clone repository → URL` et collez l'URL de votre dépôt. Ouvrez ensuite le fichier `.Rproj` dans RStudio.

### 3. Lancer le setup

Dans la console R :

```r
source("02_code/00_setup.R")
```

Le script installe les paquets requis (plusieurs minutes la première fois) et vérifie que la config est bien chargée. Vous devriez voir à la fin un message vert `✓ Setup complete`.

## Références recommandées

Avant de modifier le pipeline, lisez :

- `04_docs/checklist.md` — les 10 règles non négociables du labo.
- Jenny Bryan, **Happy Git with R** : https://happygitwithr.com
- Hadley Wickham, **R for Data Science (2e)** : https://r4ds.hadley.nz
- Gentzkow & Shapiro, **Code and Data for the Social Sciences** : https://web.stanford.edu/~gentzkow/research/CodeAndData.pdf

## Attribution

Gabarit développé par le **SSAPOPLAB** (Laboratoire de recherche sur les dynamiques des populations d'Afrique et de sa diaspora) et le **Laboratoire de méthodologie de recherche**, UQAM.

Si vous utilisez ce gabarit pour un projet publié, merci de citer :

> Adjiwanou, V. (2026). *Gabarit de projet DHS — SSAPOPLAB*. Montréal : UQAM. [URL du dépôt]

## Licence

Code sous licence MIT (voir `LICENSE`). Les données DHS sont régies par leurs propres termes d'utilisation.
