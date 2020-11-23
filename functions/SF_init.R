## Program to run and initialize all SF programs necessary to 
#obtain 
## required data output for kaggle Competition
SF_init <- function(train = NULL, test = NULL, 
                    vars = c("Month", "Year", "DayOfWeek", 
                             "PdDistrict"),
                    cat_var = "Category",
                    date_format = TRUE, 
                    date_col_train = 1,
                    date_col_test = 2,
                    file_dir ="./Output/",
                    save_as_clean = "clean",
                    prob_save_as = "prob_table",
                    file_name_test = "test", 
                    file_name_train = "train", 
                    Analy_save_as = "results",
                    export = FALSE){
    ##Load in support functions
    source("./functions/SF_Analysis.R")
    source("./functions/quicker_cleaning.R")
    source("./functions/SF_Prob.R")
    ## Load in files if not provided as data frame
    if(is.null(train)){
        file_loc_train <- paste(file_dir, file_name_train, ".csv", sep = "")
        train <- read.csv(file_loc_train, check.names = FALSE)
    }
    if(is.null(test)){
        file_loc_test <- paste(file_dir, file_name_test, ".csv", sep = "")
        test <- read.csv(file_loc_test, check.names = FALSE)   
    }
    
    ## Run functions
    clean <- SF_sort(train, vars, file_dir, 
                    save_as_clean, 
                    date_format, 
                    date_col_train,
                    export = export,
                    cat_var)
    prob <-  SF_Prob(clean, vars,
                     file_dir,
                   prob_save_as, 
                   export = export)
    res <-  SF_Analy(test, prob,
             Analy_save_as, file_dir, 
             date_format, 
             date_col_test,
             export = export)
    ## Return results
    return(res)
}
