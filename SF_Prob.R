## This function generates a probability table from clean_df based on 
## day of the week, precient, and year. It can generate a probability table
## for any data frame in a similar foram provided it is given the 
## data frame and the column where the numeric data starts 

Prob <- function(df, start) {
    for (i in 1:nrow(df)) {
        cols <- ncol(df)
        
        df$sum[i] <- sum(df[i, start:cols]) 
    }
    prob_table <- as.data.frame(NULL)
    for (i in 1:nrow(df)) {
        for(h in 1:ncol(df)) {
            if (class(df[i, h]) == "factor" | class(df[i, h]) == "character") {
                prob_table[i, h] <- df[i, h]
            }
            else if(class(df[i,h]) == "integer") {
                prob_table[i, h] <- df[i,h]/df[i,ncol(df)]
            }
            else {
                warning("Issue with column ", h, " and row ", i )
            }
        }
    }
    names(prob_table) <- names(df)
    prob_table[,ncol(prob_table)] <- NULL
    prob_table <<- prob_table         
}
 