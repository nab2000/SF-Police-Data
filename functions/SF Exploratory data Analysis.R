## data analysis
library(ggplot2)
p <- ggplot(data = clean_df, aes(x = DayOfWeek, y = clean_df[,10]), color = Year) + geom_point()
p + facet_wrap(~PdDistrict)

t <- ggplot(data = clean_df, aes(x = DayOfWeek, y = clean_df[,10])) + geom_point()
t + facet_wrap(~Year)

## this graph shows that variation in column 10 appear to show simialr differences
## for precients independent of day of the week. However, previous graphs
##showed that the crime for a specific precient varied by day of the week
w <- ggplot(data = clean_df, aes(x = PdDistrict, y = clean_df[,10])) + geom_point()
w + facet_wrap(~DayOfWeek)

