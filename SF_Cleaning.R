##Cleaning Data

SF_clean <- function(file_name = "train.csv", dir = "C:/Users/ndr/Documents/Projects/R Projects/SF Crime/"){
    
    file_loc <- paste(dir, file_name, sep = "")
    train <- read.csv(file_loc)
    
    train$Year <- as.Date(train[,1])
    train$Year <- as.numeric(format(train$Year, "%Y"))
    
    clean_df <- as.data.frame(NULL)
    
    row_no <- 0
    for (w in 1: length(unique(train$Year))){
        year <- unique(train$Year)[w]
        
        for (x in 1:length(unique(train$DayOfWeek))){
            dow <- unique(train$DayOfWeek)[x]
        
            for (z in 1:length(unique(train$PdDistrict))) {
                pd <- unique(train$PdDistrict)[z]
                row_no <- row_no + 1
                clean_df[row_no, 1] <- dow
                clean_df[row_no, 2] <- pd
                clean_df[row_no, 3] <- year
                sum <- summary(train$Category[train$DayOfWeek == dow & train$PdDistrict == pd & train$Year == year])
        
                for (y in 1:length(sum)) {
                    clean_df[row_no, y+3] <- sum[y]
                }
            }
        }
    }
names(clean_df) <- c("DayOfWeek", "PdDistrict", "Year", as.character(unique(train$Category)))

clean_df$Year <- as.factor(clean_df$Year)
clean_df <<- clean_df
}


