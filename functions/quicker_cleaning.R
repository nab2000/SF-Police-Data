## this function will take a file or data frame with a specified
## categorical variable (cat_var) and convert it into a a data frame and 
##csv file where the occurence of the categorical variable is summed as a 
##function of other variables specified by var
SF_sort <- function(file_name = "train", 
                    vars = c("Month", "Year", "DayOfWeek", "PdDistrict"), 
                    dir = "./", 
                    save_as = "sort_df", date_format = TRUE, date_col = 1,
                    cat_var = "Category"){
    ## load in necessary libraries
    require(plyr)
    require(tidyr)
   
    ## Look for data frame first before pulling in csv file
    file_loc <- paste(dir, file_name, ".csv", sep = "")
    
    if (exists(file_name)) {
        train <- get(file_name)
    } 
    
    else if (file.exists(file_loc)){
        train <- read.csv(file_loc, check.names = FALSE)
    }
    
    else { print("file does not exist"); stop }

    ## This will convert a Dates column in yyyy-mm-dd hh:mm:ss to year
    ## and month. This can be turned off it these columns already exist
    if(date_format) {
    train$Year <- as.Date(train[,date_col])
    train$Year <- as.numeric(format(train$Year, "%Y"))
    train$Month <- as.Date(train[,date_col])
    train$Month <- format(train$Month, "%b")
    }

    sort_df <- sapply(split(train[,cat_var], train[,vars]), summary)

    sort_df <- as.data.frame(sort_df)
    sort_df <- t(sort_df)
    ## converts sort_df into a more usable data frame for use with prob_table function
    
    sort_df <- data.frame(Variables = rownames(sort_df), sort_df, check.names = F)
    rownames(sort_df) <- NULL
    sort_df <- separate(sort_df,Variables, vars)
    
    save_loc <- paste(dir, save_as, ".csv", sep = "")
    write.csv(sort_df, save_loc, row.names = F)
    sort_df <<- sort_df
}


