# author: Qi Yang
# date: 2020/03/16

.PHONY: all clean

## YOUR SOLUTION HERE FOR THE `all` target
all: docs/finalreport.html docs/finalreport.pdf docs/finalreport.md

# download data
data/raw_data.csv : scripts/load.R
	Rscript scripts/load.R --data_url="https://archive.ics.uci.edu/ml/machine-learning-databases/00381/PRSA_data_2010.1.1-2014.12.31.csv"

# clean data
## YOUR SOLUTION HERE
data/cleaned_data.csv : scripts/data_wrangle.R data/raw_data.csv
	Rscript scripts/data_wrangle.R --raw_path=="data/raw_data.csv" --clean_path="data/cleaned_data.csv" 

# EDA
## YOUR SOLUTION HERE
images/corr.png images/facted_hist.png images/heatmap.png images/season_PM2.5.png images/year_PM2.5.png : scripts/eda.R data/autism_cleaned.csv 
	Rscript scripts/eda.R --raw_path="data/raw_data.csv --clean_path="data/cleaned_data" --image_path="images"

# Knit report
## YOUR SOLUTION HERE
docs/finalreport.html docs/finalreport.pdf : images/barplot.png images/correlation.png images/propbarplot.png docs/finalreport.Rmd data/autism_cleaned.csv scripts/knit.R docs/asd_refs.bib
	Rscript scripts/knit.R --finalreport="docs/finalreport.Rmd"
    
clean :
	rm -f data/*
	rm -f images/*
	rm -f docs/*.md
	rm -f docs/*.html
	rm -f docs/*.pdf