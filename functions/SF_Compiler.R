## uses files generated from SF_Analysis to combine them into a single file and
##correctly formats them for submission for Kaggle Competition

SF_compiler <- function(no_files = 10, file_name = "results", 
                    output_file_name = "Final_Results", col_keep = c(1, 5:44),
                     dir = "./"){
    
    data_frame <- as.data.frame(NULL)
    
    ## Reads in the first file
    file_loc <- paste(dir,file_name,1,".csv", sep ="")
    file <- read.csv(file_loc, check.names = F)
    data_frame <- rbind(data_frame, file)
    
    ##this for loop reads in the rest of the files and removes duplicate
    ##result at beginning of each file (artifact of SF_Analy)
    for (i in 2:no_files) {
        file_loc <- paste(dir,file_name,i,".csv", sep ="")
        file <- read.csv(file_loc, check.names =F)
        data_frame <- rbind(data_frame, file[2:nrow(file),])
    }
    
    ## this removes year, precient, and day of week cor other specified columns
    final_df <-  data_frame[, col_keep]
    
    ## outputs final file
    output_loc <- paste(dir,output_file_name,".csv", sep="")
    write.csv(final_df, output_loc, row.names=F)
}