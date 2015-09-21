SF_sort <- function(file_name = "train.csv", vars = c("Month", "Year", "DayOfWeek", "PdDistrict"), dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/", 
                     save_as = "sort_df"){
    library(plyr)
    library(tidyr)
    ## pulls in data and then summarizes crime category by vars
    
    file_loc <- paste(dir, file_name, sep = "")
    
    if (exists(file_name)) {
        train <- get(file_name)
        
    } 
    
    else if (file.exists(file_loc)){
        train <- read.csv(file_loc, check.names = F)
        
    }
    
    else { print("file does not exist"); stop }
    
    train$Year <- as.Date(train[,1])
    train$Year <- as.numeric(format(train$Year, "%Y"))
    
    train$Month <- as.Date(train[,1])
    train$Month <- format(train$Month, "%b")


    sort_df <- sapply(split(train$Category, train[,vars]), summary)

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


