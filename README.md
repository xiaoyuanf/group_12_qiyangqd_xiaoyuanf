# Group 12: Beijing PM2.5
This is the project repository for Group 12 in STAT547M in the University of British Columbia. The project is an assessment of PM2.5 pollution from 2010 to 2014 in Beijing, China. 

## Group Member
Margot Chen, Qi Yang

## Introduction 
1. Project Interest    
Beijing, the capital city of China, has been fighting against `PM2.5` pollution in recent years. `PM2.5` are fine airborne particles less than 2.5μm that can cause severe damage to human health. Meteorological conditions(wind, humidity, etc) can contribute to the formation of `PM2.5` according to previous studies. We are interested in whether there are correlations between Beijing’s `PM2.5` concentration and  meteorological conditions. If so, analyzing meteorological conditions can help us assess and even predict the air quality in Beijing.    

2. Data Description   
The [dataset](https://archive.ics.uci.edu/ml/machine-learning-databases/00381/PRSA_data_2010.1.1-2014.12.31.csv) we used is from [University of California Irvine Machine learning Repository](https://archive.ics.uci.edu/ml/datasets/Beijing+PM2.5+Data#). It was originally uploaded by Songxi Chen in Peking University, China. This is an hourly dataset containing `PM2.5` concentration and meteorological statistics from Jan 1st, 2010 to Dec 31st, 2014.   

3. Plans    
We attempt to address whether Beijing's `PM2.5` is correlated with meteorological conditions(dew point, temperature, pressure, wind speed and direction, rain or snow) and time(year, month, day). Our steps include: data cleaning, correlation tests, linear regression analyses, plotting, dashboard creation. A more detailed proposal in HTML version can be found [here](https://stat547-ubc-2019-20.github.io/group_12_qiyangqd_xiaoyuanf/docs/milestone1.html).  

## Links to Milestones
The links below lead to the releases and `html` versions of milestones in this project, and they will be updated through the course.          
__Milestone 1:__ [release1.0](https://github.com/STAT547-UBC-2019-20/group_12_qiyangqd_xiaoyuanf/releases/tag/1.0)  [html](https://stat547-ubc-2019-20.github.io/group_12_qiyangqd_xiaoyuanf/docs/milestone1.html)        
__Milestone 2:__ [release2.0](https://github.com/STAT547-UBC-2019-20/group_12_qiyangqd_xiaoyuanf/releases/tag/2.0)     
__Milestone 3:__   
__Milestone 4:__   
__Milestone 5:__   
__Milestone 6:__   

## Repository Component
__docs__: `.Rmd`, `.html` and`.md` files, including a proposal and a final report.     
__data__: Raw and cleaned/wrangled datasets.        
__scripts__: `.R` scripts for different usage.      
__images__: Images exported from scripts.     
__tests__: Tests for functions.  

## Usage
1. Clone this repo.    

2. Ensure the following packages are installed:       
  
   `dplyr`, `tidyr`, `tidyverse`, `docopt`, `here`, `glue`, `ggplot2`, `corrplot`, `foreign`, `lubridate`, `viridis`                    

3. Run the following scripts (in order) with specified arguments.

  - [load_data.R](https://stat547-ubc-2019-20.github.io/group_12_qiyangqd_xiaoyuanf/scripts/load_data.R): Load the dataset from an external link and save it as a .csv file.      `Rscript scripts/load_data.R --data_url=https://archive.ics.uci.edu/ml/machine-learning-databases/00381/PRSA_data_2010.1.1-2014.12.31.csv`
  
  - [data_wrangle.R](https://stat547-ubc-2019-20.github.io/group_12_qiyangqd_xiaoyuanf/scripts/data_wrangle.R): Clean and process the raw data according to the needs of the project.      
  `Rscript scripts/data_wrangle.R --raw_path=<raw_data_path> --clean_path=<clean_data_path>`
  
  - [eda.R](https://stat547-ubc-2019-20.github.io/group_12_qiyangqd_xiaoyuanf/scripts/eda.R): Run exploratory data analysis.         
  `Rscript scripts/eda.R --raw_path=<raw_data_path> --clean_path=<clean_data_path> --image_path=<image_path>`
  
  - Knit the draft final report              
  Will be added next week
