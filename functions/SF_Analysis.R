##This uses the probability table created by SF_Prob and a test data set
##to predict the likelihood of each category based on the variables given

SF_Analy <- function(file_name = "test", prob_tbl = prob_table, start = 1, 
                     save_as = "results", date_format = TRUE, date_col = 2,
                     dir = "./", 
                     vars = c("Year", "PdDistrict", "DayOfWeek", "Id")){
    ## check if given file_name is a data frame or file
    file_loc <- paste (dir, file_name, ".csv", sep ="")
    
    if (exists(file_name)) {test <<- get(file_name)} 
    
    else if (file.exists(file_loc)){test <<- read.csv(file_loc)} 
    
    else { print("file does not exist"); stop }
    
    
    ## turn date and time column into year column
    if(date_format){
        test$Year <- as.Date(test[, date_col])
        test$Year <- as.numeric(format(test$Year, "%Y"))
        test$Month <- as.Date(test[,date_col])
        test$Month <- format(test$Month, "%b")
    }
 
    ## divide packet into smaller groupings to breka up computational time
    ##if necessary
    file_nos <- ceiling(nrow(test)/10)
    
    ## splits the dataframe into sets of 10 and uses probability table
    ## to estimate probability of category that the observaiton belongs to
    for(n in start:10){
        output <- as.data.frame(NULL)
        beg <- file_nos*(n-1)
        end <- file_nos*n
        sub <- test[beg:end, ]
        
        for (i in 1:nrow(sub)){
            year <- sub$Year[i]
            PdDist <- sub$PdDistrict[i]
            dow <- sub$DayOfWeek[i]
            id <- sub$Id[i] 
            
            prob_row <- prob_tbl[prob_tbl$Year == year & 
                                       prob_tbl$PdDistrict == PdDist &
                                   prob_tbl$DayOfWeek == dow, ]
            prob_row <- c(id, prob_row)
            prob_row <- as.data.frame(prob_row)
            names(prob_row) <- c("Id", names(prob_tbl))
            output <-rbind(output, prob_row)
        }
        
        na_list <- !is.na(output[,1])
        output <- output[na_list, ]
        output_file_loc <- paste(dir, save_as, n, ".csv", sep ="")    
        write.csv(output, file = output_file_loc, row.names=F)
     }
}
