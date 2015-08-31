## uses files generated from SF_Analysis to combine them into a single file and
##correctly formats them for submission for Kaggle Competition

SF_compiler <- function(no_files = 10, file_name = "results", 
                     file_type = "csv", output_file_name = "Final_Results",
                     dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/"){
    
    data_frame <- as.data.frame(NULL)
    ## this is doen for first file to get rid of replicate rows between multiple results
    ## files
    i <- 1
    file_loc <- paste(dir,file_name,i,".", file_type, sep ="")
    file <- read.csv(file_loc, check.names = F)
    data_frame <- rbind(data_frame, file)
    
    for (i in 2:no_files) {
        file_loc <- paste(dir,file_name,i,".", file_type, sep ="")
        file <- read.csv(file_loc, check.names =F)
        data_frame <- rbind(data_frame, file[2:nrow(file),])
    }
    ## this removes year, precient, and day of week column
    final_df <-  data_frame[, c(1, 5:ncol(data_frame))]
    ## outputs final file
    output_loc <- paste(dir,output_file_name,".", "csv", sep="")
    write.csv(final_df, output_loc, row.names=F)
}