## this function will take a file or data frame with a specified
## categorical variable (cat_var) and convert it into a a data frame and 
##csv file where the occurence of the categorical variable is summed as a 
##function of other variables specified by var
## load in necessary libraries
require(reshape2)
SF_sort <- function(train, 
                    vars = c("Month", "Year", "DayOfWeek", 
                             "PdDistrict"), 
                    dir = "./Data/", 
                    save_as = "sort_df", 
                    date_format = TRUE, 
                    date_col = 1,
                    export = FALSE, 
                    cat_var = "Category"){
    ## This will convert a Dates column in yyyy-mm-dd hh:mm:ss to year
    ## and month. This can be turned off it these columns already exist
    if(date_format) {
        train[,date_col] <- as.Date(train[,date_col])
        train$Year <- as.numeric(format(train[,date_col], "%Y"))
        train$Month <- format(train[,date_col], "%b")
    }
    ##Reduce dataset to just those columns specified
    fml <- paste(vars, collapse = "+")
    fml <- paste(fml, cat_var, sep = "~")
    fml <- as.formula(fml)

    sort_df <- suppressMessages(reshape2::dcast(train, fml,
                     fun.aggregate = length))
    if(export){
        save_loc <- paste(dir, save_as, ".csv", sep = "")
        write.csv(sort_df, save_loc, row.names = F)
    }
    
    return(sort_df)
}


