## this function will take a file or data frame with a specified
## categorical variable (cat_var) and convert it into a a data frame and 
##csv file where the occurence of the categorical variable is summed as a 
##function of other variables specified by var
SF_sort <- function(file_name = "train", 
                    vars = c("Month", "DayOfWeek", "PdDistrict"), 
                    dir = "./", 
                    save_as = "sort_df", save_file = FALSE, date_format = TRUE, date_col = 1,
                    cat_var = "Category"){
    ## load in necessary libraries
    require(plyr)
    require(tidyr)
   
    ## Look for data frame first before pulling in csv file
    file_loc <- paste(dir, file_name, ".csv", sep = "")
    
    if (exists(file_name)) {
        train <- as.data.frame(get(file_name))
    } else if (file.exists(file_loc)){
        train <- read.csv(file_loc, check.names = FALSE)
    }else { print("file does not exist"); stop }
    

    if (class(train[,cat_var]) != "factor") {train[,cat_var]  <- as.factor(train[,cat_var] )}

    sort_df <- sapply(split(train[,cat_var], train[,vars]), summary)

    sort_df <- as.data.frame(sort_df)
    sort_df <- t(sort_df)
    ## converts sort_df into a more usable data frame for use with prob_table function
    
    if(save_file){
        save_loc <- paste(dir, save_as, ".csv", sep = "")
        write.csv(sort_df, save_loc, row.names = F)
    }
    sort_df
}


