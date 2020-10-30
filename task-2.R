#reading in the data from online
file <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=44025h2011.txt.gz&dir=data/historical/stdmet/"
readLines(file, n = 4)
str(file)

#read it into a table
buoy44025 <- read_table(file, 
                        col_names = FALSE,
                        skip = 2)
?read_table
#used read_table to make sure all the line lengths were the same
?scan
buoy_measure <- scan(file, nlines = 1, what = character()) %>% 
  str_remove('#')
buoy_measure
buoy_units <- scan(file, skip = 1, nlines = 1, what = character()) %>% 
  str_remove('#') %>% 
  str_replace('/', '_per_')
buoy_units
names(buoy44025) <- paste0(buoy_measure,'_',buoy_units)
names(buoy44025)

