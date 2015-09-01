a <- with( sub, sapply(split(sub$Category, list(sub$DayOfWeek, sub$PdDistrict)), summary))

b <- with( sub, tapply(sub$Category, list(sub$DayOfWeek, sub$PdDistrict), summary))