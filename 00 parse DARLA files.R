# This script looks inside the folder "data" for any CSV files.
# It opens them one by one and tries to join all of them in one 
# new file.

# Install (if necessary) and load pacman.
if (!require(pacman)){
  install.packages('pacman')
  }
library(pacman)

# Install needed packages
p_load(tidyverse, rio)

# Name the folder where the CSV files with formant measurements
# are saved.
datadir <- "data/"

# List all CSV files in that folder.
files <- list.files(path = datadir, pattern = "\\.csv$")

# What name is the resulting master file going to have?
resultfilename <- paste0("vowels_parsed_", 
                         format(Sys.Date(), format = "%m%d"), 
                         ".csv")

# Execute opening the files one by one through a for-loop.
for (i in 1:length(files)){
  
  # this file will be called f
  f <- paste0(datadir, files[i])
  
  # open, read the file into a dataframe with name df
  df <- import(f)
  
  # either write the file content to the top of the result
  # file or append it at the bottom
  if(i == 1) {
    df %>% write_csv(resultfilename,
                       append = F)
  } else {
    df %>% write_csv(resultfilename,
                       append = T)
  }
}

# Open the result file and write a message to screen
# stating the number of rows, i.e. size of the dataset.
df <- import(resultfilename)
cat(paste("\n\n\nAssembled all CSV files in your folder in a master file: ",
          "\n  ", resultfilename, ".",
          "\nThe data has", 
          format(nrow(df), big.mark = ","), "rows.",
          "\nEnjoy the rest of your day.\nGod speed.\n\n\n"))
rm(df)

