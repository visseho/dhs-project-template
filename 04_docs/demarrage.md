# Guide de démarrage

Suivez ce guide **dans l'ordre**. Comptez une demi-journée pour la première installation, moins d'une heure pour les suivants qui connaissent déjà l'écosystème.

---

## 1. Logiciels à installer (une seule fois)

### Indispensables

| Logiciel | Lien | Pourquoi |
|---|---|---|
| **R (≥ 4.3)** | https://cran.r-project.org | Moteur statistique |
| **RStudio Desktop** (gratuit) | https://posit.co/download/rstudio-desktop/ | Éditeur R. À installer **après** R. |
| **Git** | https://git-scm.com (Windows) ; déjà présent sur macOS | Versionnage. Ne pas confondre avec GitHub Desktop. |
| **GitHub Desktop** | https://desktop.github.com | Interface graphique pour Git. |
| **Compte GitHub** | https://github.com/join | Avec votre adresse `@courrier.uqam.ca` de préférence. |

### Fortement recommandés

| Logiciel | Lien | Pourquoi |
|---|---|---|
| **Quarto** | https://quarto.org | Documents reproductibles (texte + code + figures). |
| **TinyTeX** | `tinytex::install_tinytex()` en R | Pour exporter en PDF. |
| **VS Code** | https://code.visualstudio.com | Pour éditer les fichiers YAML/Markdown confortablement. |

### Pour les projets Python ou mixtes

| Logiciel | Lien |
|---|---|
| **Miniconda** | https://docs.conda.io/projects/miniconda/ |

---

## 2. Configurer Git (une seule fois)

Dans un terminal (ou dans la console Git Bash sur Windows) :

```bash
git config --global user.name "Votre Nom"
git config --global user.email "votre.courriel@courrier.uqam.ca"
```

Puis ouvrez GitHub Desktop, allez dans `Preferences → Accounts` et connectez-vous à votre compte GitHub.

---

## 3. Cloner votre projet

Dans GitHub Desktop :

1. `File → Clone repository`
2. Onglet **URL** → collez l'URL de votre dépôt (ex. `https://github.com/ssapoplab/mon-projet`)
3. **Local path** : choisissez un dossier **hors de iCloud/OneDrive/Dropbox**. Nous recommandons `~/Mon_Repo_GitHub/`.
4. Cliquez `Clone`.

> ⚠️ **Ne mettez jamais un dépôt Git dans un dossier synchronisé par iCloud, OneDrive ou Dropbox.** Les deux systèmes se marchent dessus et finissent par corrompre vos fichiers.

---

## 4. Ouvrir le projet dans RStudio

Double-cliquez sur le fichier `.Rproj` à la racine du dossier cloné. RStudio s'ouvre dans le contexte du projet (vous verrez le nom du projet en haut à droite).

Vérifiez dans la console :

```r
getwd()
```

Vous devriez voir le chemin de votre projet. **Ne faites jamais `setwd()`** — si le `getwd()` est faux, c'est que vous n'avez pas ouvert le `.Rproj`.

---

## 5. Lancer le setup

Dans la console R :

```r
source("02_code/00_setup.R")
```

La première fois, R installe une vingtaine de paquets — comptez **5-15 minutes**. Si R demande "install from sources?", répondez **`no`**.

À la fin, vous devriez voir :

```
✓ Setup complete. Loaded N packages and K countries.
```

---

## 6. Obtenir les données DHS

Les données DHS **ne sont pas** incluses dans ce dépôt (ni dans aucun dépôt Git — c'est contractuel).

1. Créez un compte sur https://dhsprogram.com/data/new-user-registration.cfm
2. Soumettez une description de projet (votre directeur peut vous aider à la formuler). Approbation : 1-5 jours ouvrables.
3. Téléchargez les **fichiers Stata (`.DTA`)** des recodes dont vous avez besoin : IR (femmes), MR (hommes), CR (couples), HR (ménage), PR (personne).
4. Placez-les dans la structure attendue :

```
01_data/raw/
├── BEN/
│   └── DHS-VII-2017-18/
│       ├── BJIR71FL.DTA
│       ├── BJMR71FL.DTA
│       └── ...
```

Le code pays du dossier est l'**ISO3** (`BEN`, `CMR`, `KEN`). Le préfixe des **fichiers** est le code DHS à deux lettres (`BJ` pour Bénin, `CM` pour Cameroun) — c'est normal, c'est la convention DHS.

---

## 7. Configurer les chemins (si vos données sont ailleurs)

Si vos données ne sont pas dans `01_data/raw/` mais sur un disque externe, un serveur ou un dossier partagé du labo, **ne modifiez pas `_config.yml`** (qui est versionné). Créez à la place un fichier `_config_local.yml` à la racine du projet :

```yaml
paths:
  data_raw: "/chemin/vers/mon/dossier/DHS"
```

Ce fichier est automatiquement gitignoré. Chaque membre de l'équipe peut avoir le sien avec son propre chemin.

---

## 8. Premier test

```r
source("02_code/01_import_dhs.R")
```

Vous devriez voir pour chaque pays dont vous avez les données :

```
── BEN | DHS-VII-2017-18 ──
✓ Saved interim files to .../01_data/interim/BEN/DHS-VII-2017-18
```

Puis vérifiez :

```r
list.files("01_data/interim", recursive = TRUE)
```

Si vous voyez des `.rds`, bravo — votre pipeline est opérationnel.

---

## 9. Prochaines étapes

- Lisez `04_docs/checklist.md` (les 10 règles).
- Lisez `04_docs/analysis_plan.md` et commencez à le remplir **avant** de regarder les résultats.
- Documentez chaque nouvelle variable dérivée dans `04_docs/codebook.md`.
- Faites votre premier commit : "Setup project with Benin 2017-18 data".

---

## En cas de problème

- **Erreur `could not find function "..."`** : relancez `source("02_code/00_setup.R")`.
- **Erreur `cannot open the connection`** : vérifiez que le `.Rproj` est ouvert (`getwd()` doit pointer sur votre projet).
- **Erreur Git** : ne paniquez pas, n'effacez rien, demandez sur le Slack du labo.
- **Doute scientifique** : rendez-vous bihebdomadaire avec votre directeur.
