## ============================================================
## Makefile — orchestre le pipeline complet.
##   make all      : exécute tout
##   make import   : seulement l'étape d'import
##   make clean    : efface les fichiers intermédiaires et sorties
## ============================================================

R     := Rscript
CODE  := 02_code

all: figures

setup:
	$(R) $(CODE)/00_setup.R

import: setup
	$(R) $(CODE)/01_import_dhs.R

harmonise: import
	$(R) $(CODE)/02_harmonize_variables.R

outcomes: harmonise
	$(R) $(CODE)/03_construct_outcomes.R

exposure: outcomes
	$(R) $(CODE)/04_construct_exposure.R

covariates: exposure
	$(R) $(CODE)/05_construct_covariates.R

sample: covariates
	$(R) $(CODE)/06_define_sample.R

descriptive: sample
	$(R) $(CODE)/07_descriptive_stats.R

models: descriptive
	$(R) $(CODE)/08_main_models.R

sensitivity: models
	$(R) $(CODE)/09_sensitivity_analyses.R

figures: sensitivity
	$(R) $(CODE)/11_tables_figures.R

clean:
	rm -rf 01_data/interim/* 01_data/processed/*
	rm -rf 03_output/tables/* 03_output/figures/* 03_output/logs/*

.PHONY: all setup import harmonise outcomes exposure covariates sample \
        descriptive models sensitivity figures clean
