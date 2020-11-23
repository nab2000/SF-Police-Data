##This uses the probability table created by SF_Prob and a test data set
##to predict the likelihood of each category based on the variables given
require(dplyr)
SF_Analy <- function(test, prob_tbl, 
                     save_as = "results",dir = "./Output/",
                     date_format = TRUE, 
                     date_col = 2, 
                     export = FALSE){

    ## turn date and time column into year column
    if(date_format){
        test[, date_col] <- as.Date(test[, date_col])
        test$Year <- as.numeric(format(test[, date_col], "%Y"))
        test$Month <- format(test[, date_col], "%b")
    }
    output <- left_join(test, prob_tbl)
    ##Remove
    na_list <- !is.na(output$Prob)
    output <- output[na_list, ]
    if(export){
        output_file_loc <- paste(dir, save_as, ".csv", sep ="")    
        write.csv(output, file = output_file_loc, row.names=F)
    }
    return(output)
}
