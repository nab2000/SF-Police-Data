## Program to run and initialize all SF programs necessary to obtain 
## required data output for kaggle Competition
SF_init <- function(file_name_train = "train.csv", file_dir ="C:/Users/ndr/Documents/Projects/R Projects/SF Crime/",
                    save_as_clean ="clean_df", prob_start = 4, prob_save_as = "prob_table",
                    test_file_name = "test.csv", Analy_start = 1) {
    
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Analysis.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Cleaning.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Prob.R")
    source("C:/Users/ndr/Documents/Projects/R Projects/SF Crime/SF_Prob.R")
    SF_clean(file_name_train, file_dir, save_as_clean)
    SF_Prob(save_as_clean, file_dir, 
           prob_start, prob_save_as)
    SF_Analy(test_file_name, prob_save_as, Analy_start, file_dir)
    SF_compiler(no_files = 10, file_name = "results", 
                output_file_name = "Final_Results",
                file_dir)
    
}
