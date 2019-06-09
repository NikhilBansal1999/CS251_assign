                                                      TASK 1
-- The user is first prompted to enter the name of required C file.
-- The program then asks the user if an input file is supplied and if so than accepts the file name as passes the contents of the
   file as the argument to program.
-- The program is compiled with appropriate compilation flags.
-- gcov is then run with flags -bci. The resultant output od gcov is then opened and parsed.
   In the output file provided by gcov, the lines starting with "lcount" represents the number of times the corresponding line
   was executed.
-- The gcov is then run with -b flag to get branch bias.
-- Every line with "branch 0" is caught. Also the previous line is cached. Together they help to get the branch bias. The previous
   line give branch line number and the current line gives branch bias.

                                                       TASK 2
-- The user is asked the name of the program and the program is compiled with appropriate flags.
-- The program then asks the user if an input file is supplied and if so than accepts the file name as passes the contents of the
   file as the argument to program.
-- gprof is then run with -bq flag. The result file is parsed to get the names of the function which gprof caught while profiling.
-- gprof is then run with -bp flag to produce flat profile. This is used to get the time taken by various functions.
-- gprof is again run with -bq to generate call graph to get the time of some functions which didnt show up in flat profile.
-- Now gprof is run with -bq followed by the name of the function to get the part of call graph in which the specified function is
   is a parent. This is then parsed to get the child functions of the function.
-- This process is repeated for each function and the data gathered is stored in a list.
-- Finally the csv file is opened for writing and the data is written to the file.
