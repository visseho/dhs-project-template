# Accès aux données DHS

Les microdonnées DHS ne peuvent **pas** être redistribuées. Chaque chercheur·se du projet doit s'inscrire individuellement et faire sa propre demande.

## Procédure

1. Créer un compte sur https://dhsprogram.com/data/new-user-registration.cfm
2. Soumettre une description de projet (quelques lignes). Mentionner votre affiliation UQAM / SSAPOPLAB et votre directeur ou directrice.
3. Approbation en 1-5 jours ouvrables.
4. Télécharger les fichiers **Stata (`.DTA`)** pour chaque pays et enquête de votre liste. Recodes dont vous aurez probablement besoin :
   - **IR** — Individual Recode (femmes 15-49)
   - **MR** — Men's Recode (hommes)
   - **CR** — Couples Recode
   - **HR** — Household Recode
   - **PR** — Household Member Recode
   - **GE** — Geographic (GPS clusters, si autorisé)

## Organisation sur votre machine

Les fichiers doivent respecter cette arborescence pour que le pipeline les trouve :

```
01_data/raw/
├── BEN/                              <- code ISO3 à 3 lettres
│   └── DHS-VII-2017-18/              <- survey_id tel que dans _config.yml
│       ├── BJIR71FL.DTA              <- préfixes DHS à 2 lettres (BJ pour Bénin)
│       ├── BJMR71FL.DTA
│       ├── BJCR71FL.DTA
│       └── ...
├── CMR/
│   └── DHS-VII-2018/
│       └── ...
└── ...
```

## Enquêtes sans module d'intérêt

Si une enquête ne contient pas une variable dont vous avez besoin (ex. biomarqueur TA, module VBG, GPS), excluez-la de `_config.yml`.

## Éthique

Bien que les données DHS soient anonymisées à la source, votre institution peut exiger une attestation d'exemption du Comité d'éthique de la recherche (CER). Pour l'UQAM, un modèle est disponible auprès du SSAPOPLAB.
