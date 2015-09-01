## This function generates a probability table from clean_df based on 
## day of the week, precient, and year. It can generate a probability table
## for any data frame in a similar foram provided it is given the 
## data frame and the column where the numeric data starts 

SF_Prob <- function(file_name = clean_df, dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/", 
                    start = 4, save_as = "prob_table" ) {
    file_loc <- paste (dir, file_name, sep ="")
    
    if (exists(file_name)) {
        test <<- file_name
        
    } 
    else if (file.exists(file_loc)){
        test <<- read.csv(file_loc)
        
    }
    
    else { print("file does not exist"); stop }
    
    
    for (i in 1:nrow(file_name)) {
        cols <- ncol(file_name)
        
        file_name$sum[i] <- sum(file_name[i, start:cols]) 
    }
    
    prob_table <- as.data.frame(NULL)
    for (i in 1:nrow(file_name)) {
        for(h in 1:ncol(file_name)) {
            if (class(file_name[i, h]) == "factor" | class(file_name[i, h]) == "character") {
                prob_table[i, h] <- file_name[i, h]
            }
            else if(class(file_name[i,h]) == "integer") {
                prob_table[i, h] <- file_name[i,h]/file_name[i,ncol(file_name)]
            }
            else {
                warning("Issue with column ", h, " and row ", i )
            }
        }
    }
    names(prob_table) <- names(file_name)
    prob_table[,ncol(prob_table)] <- NULL
    
    save_loc <- paste(dir, save_as, ".csv", sep = "")
    write.csv(prob_table, save_loc)
    
    prob_table <<- prob_table         
}
 