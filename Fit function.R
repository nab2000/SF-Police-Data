##fitting loop

for(i in 1:39){
    col_no <- i+4
    var_name <- colnames(y)[col_no]
    fit_name <- paste("fit_", var_name, sep = "")
    assign(fit_name, glm(get(var_name)~Year + PdDistrict + Month + DayOfWeek, 
                         data = y, family = "poisson"))
    
}