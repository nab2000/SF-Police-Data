## analyzing the test data

SF_Analy <- function(file_name = "test.csv", prob_tbl = prob_table, dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/"){
    file_loc <- paste (dir, file_name, sep ="")
    test <- read.csv(file_loc)
    test$Year <- as.Date(test[,2])
    test$Year <- as.numeric(format(test$Year, "%Y"))
    test <- test[, c(1,3,4,8)] 
## testing fuction below
## test_fun <- function(test)  {  
    output <- as.data.frame(NULL)
    for (i in 1:nrow(test)){
        year <- test$Year[i]
        PdDist <- test$PdDistrict[i]
        dow <- test$DayOfWeek[i]
        id <- test$Id[i] 
        
        prob_row <- prob_tbl[prob_tbl$Year == year & 
                                   prob_tbl$PdDistrict == PdDist &
                               prob_tbl$DayOfWeek == dow, ]
        prob_row <- c(id, prob_row)
        prob_row <- as.data.frame(prob_row)
        names(prob_row) <- c("Id", names(prob_tbl))
        output <-rbind(output, prob_row)
    }
    ## }
output_file_loc <- paste(dir, "results.csv", sep ="")    
write.csv(output, file = output_file_loc)
}
