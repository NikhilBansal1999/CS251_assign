                                    TASK 1
-- First the file from previous assignment is run to gather all the required data. (called from bash script)
-- The bash script is then run to generate the R script.
-- Appropriate libraries are imported.
-- Then data is loaded into the R dataframe to be plotted.
-- Then ggplot library are used to generate line graphs and bar graphs.
-- The data for different test-cases is plotted in different facets.
-- Also data for different cases are shown in different colors.
-- To run the program run the following:
    ./gcov_script.sh      (Provide appropriate inputs when prompted)

                                     TASK 2
-- First the file from previous assignment is used to gather data.
    Run: python3 gprof.py
-- The R script is then run using :     Rscript gprof_plot.R
-- The R script first loads the csv data into dataframes.
-- Since the data had 4 columns with parent child relationship, the data-frame is first split into two parts.
  One part has parent functions with their time
  The other part has child functions with their time.
-- These two dataframes are then merged into a single data frame to get the required data.
-- "Unique" function is used to remove redundant rows.
-- The data is then plotted with function on x-axis and time on y-axis.
-- Different bars are then assigned different colours.
