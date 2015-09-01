## Program to run and initialize all SF programs necessary to obtain 
## required data output for kaggle Competition
SF_init <- function(file_name_train = "train.csv", file_dir ="C:/Users/ndr/Documents/Projects/R Projects/SF Crime/",
                    save_as_clean ="clean_df",  prob_save_as = "prob_table",
                    test_file_name = "test.csv", Analy_start = 1, Analy_save_as = "results", 
                    comp_no_files = 10, out_file_name = "Final_Results",
                    test_file_name = "test.csv", Analy_start = 1){

    
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Analysis.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Cleaning.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Prob.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Prob.R")
    SF_clean(file_name_train, file_dir, save_as_clean)
    SF_Prob(save_as_clean, file_dir, prob_save_as)
    SF_Analy(test_file_name, prob_save_as, Analy_start, Analy_save_as, file_dir)
    SF_compiler(comp_no_files, Analy_save_as, out_file_name,  file_dir)
    
    
}
