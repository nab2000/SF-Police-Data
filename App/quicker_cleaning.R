## this function will take a file or data frame with a specified
## categorical variable (cat_var) and convert it into a a data frame and 
##csv file where the occurence of the categorical variable is summed as a 
##function of other variables specified by var
SF_sort <- function(file = NULL, 
                    vars = c("Month", "DayOfWeek", "PdDistrict"), 
                    dir = "./", 
                    save_as = "sort_df", save_file = FALSE, date_format = TRUE, date_col = 1,
                    cat_var = "Category"){
    ## load in necessary libraries
    require(plyr)
    require(tidyr)

        train <- as.data.frame(file)

    if (class(train[,cat_var]) != "factor") {train[,cat_var]  <- as.factor(train[,cat_var] )}
    if(length(unique(train[,cat_var])) == 1){
        sort_df <- sapply(split(train[,cat_var], train[,vars]), length)
        sort_df <- as.data.frame(sort_df)
        colnames(sort_df) <- unique(train[,cat_var])
    } else{
        sort_df <- sapply(split(train[,cat_var], train[,vars]), summary)
        sort_df <- t(sort_df)
        sort_df <- as.data.frame(sort_df)
    }   
    

    if(save_file){
        save_loc <- paste(dir, save_as, ".csv", sep = "")
        write.csv(sort_df, save_loc, row.names = F)
    }
    sort_df
}


