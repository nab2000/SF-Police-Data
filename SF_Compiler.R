## uses files generated from SF_Analysis to combine them into a single file

SF_compiler <- function(no_files = 10, file_name = "results", 
                     file_type = "csv", output_file_name = "Final_Results",
                     dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/"){
    
    data_frame <- as.data.frame(NULL)                     
    for (i in 1:no_files) {
        file_loc <- paste(dir,file_name,i,".", file_type, sep ="")
        file <- read.csv(file_loc)
        data_frame <- rbind(data_frame, file)
    }
    output_loc <- paste(dir,output_file_name,".", "csv", sep="")
    write.csv(data_frame, output_loc, row.names=F)
}