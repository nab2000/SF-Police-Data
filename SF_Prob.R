## This function generates a probability table from clean_df based on 
## day of the week, precient, and year. It can generate a probability table
## for any data frame in a similar foram provided it is given the 
## data frame and the column where the numeric data starts 

SF_Prob <- function(file_name = "clean_df", dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/", 
                    save_as = "prob_table" ) {
    
    file_loc <- paste (dir, file_name, sep ="")
    
    if (exists(file_name)) {
        test <<- get(file_name)
        
    } 
    else if (file.exists(file_loc)){
        test <<- read.csv(file_loc, check.names = F)
        
    }
    
    else { print("file does not exist"); stop }
    
    start <- NULL
    for (i in 1:ncol(test)){
        if (class(test[1,i]) == "integer"){
            start <- i
        }
        if (class(start) != "NULL") break
        
    }
    
    
    for (i in 1:nrow(test)) {
        cols <- ncol(test)
        
        test$sum[i] <- sum(test[i, start:cols]) 
    }
    
    prob_table <- as.data.frame(NULL)
    for (i in 1:nrow(test)) {
        for(h in 1:ncol(test)) {
            if (class(test[i, h]) == "factor" | class(test[i, h]) == "character") {
                prob_table[i, h] <- test[i, h]
            }
            else if(class(test[i,h]) == "integer") {
                prob_table[i, h] <- test[i,h]/test[i,ncol(test)]
            }
            else {
                warning("Issue with column ", h, " and row ", i )
            }
        }
    }
    names(prob_table) <- names(test)
    prob_table[,ncol(prob_table)] <- NULL
    
    save_loc <- paste(dir, save_as, ".csv", sep = "")
    write.csv(prob_table, save_loc)
    
    prob_table <<- prob_table         
}
 