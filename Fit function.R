##fitting loop
SF_Analy <- function(file_name = "test", prob_tbl = prob_table, 
                     save_as = "results", date_format = TRUE,
                     dir = "./", ){
    ## check if given file_name is a data frame or file
    file_loc <- paste (dir, file_name, ".csv", sep ="")
    
    if (exists(file_name)) {test <<- get(file_name)} 
    
    else if (file.exists(file_loc)){test <<- read.csv(file_loc)} 
    
    else { print("file does not exist"); stop }
    
    ## check if prob_table is a file name or value
    file_loc <- paste (dir, prob_tbl, ".csv", sep ="")
    
    if (exists(prob_tbl)) {} 
    
    else if (file.exists(file_loc)){prob_tbl <<- read.csv(file_loc, check.names 
                                                          = False)} 
    
    else { print("file does not exist"); stop }
    
    ## turn date and time column into year column
    if(date_format){
        test$Year <- as.Date(test[, "Dates"])
        test$Year <- as.numeric(format(test$Year, "%Y"))
        test$Month <- as.Date(test[,"Dates"])
        test$Month <- format(test$Month, "%b")
    }
 
    ##generate linear model from Prob_tbl      
    for(i in 1:39){
        col_no <- i+4
        var_name <- colnames(prob_tbl)[col_no]
        fit_name <- paste(var_name)
        assign(fit_name, lm(get(var_name)~Year + PdDistrict + Month + DayOfWeek, 
                             data = prob_tbl))
        
    }
    results_df <- data.frame(col_1 = rep(NA, nrow(test)))

    ## apply linnear models 
    for (i in 1:39){
        col_no <- i+4
        var_name <- colnames(prob_tbl)[col_no]
        col <-     predict(get(var_name), test)
        results_df <- cbind(results_df, col)
        colnames(results_df)[i+1] <- var_name
    }

    
}