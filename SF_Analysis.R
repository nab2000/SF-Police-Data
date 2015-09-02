## analyzing the test data

SF_Analy <- function(file_name = "test.csv", prob_tbl = prob_table, start = 1, save_as = "results", 
                     dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/"){
    ## check if given file_name is a data frame or file
    file_loc <- paste (dir, file_name, sep ="")

    if (file.exists(file_loc)){
        test <<- read.csv(file_loc)
    } 
    else if (exists(file_name)) {
        test <<- file_name
       
    }
    
    else { print("file does not exist"); stop }
    
    
    ## turn date and time column into year column
    test$Year <- as.Date(test[,2])
    test$Year <- as.numeric(format(test$Year, "%Y"))
    test <- test[, c(1,3,4,8)] 
 
    ## divide packet into smaller groupings 
    file_nos <- ceiling(nrow(test)/10)
    
    
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
