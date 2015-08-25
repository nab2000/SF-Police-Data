## analyzing the test data
test <- read.csv("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/test.csv")
test$Year <- as.Date(test[,2])
test$Year <- as.numeric(format(test$Year, "%Y"))