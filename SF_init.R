## Program to run and initialize all SF programs necessary to obtain 
## required data output for kaggle Competition
SF_init <- function() {
    
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Analysis.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Cleaning.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Prob.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Prob.R")
    SF_clean()
    SF_Prob()
    SF_Analy()
    SF_compiler
    
}
