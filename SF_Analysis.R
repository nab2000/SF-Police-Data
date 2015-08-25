## analyzing the test data

SF_Analy <- function(file_name, prob_table){
    file_loc <- paste ("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/", file_name, sep ="")
    test <- read.csv(file_name)
    test$Year <- as.Date(test[,2])
    test$Year <- as.numeric(format(test$Year, "%Y"))
    
    
}
