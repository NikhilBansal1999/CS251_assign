                                  TASK 1
-- The four C files and a main driver program is written in C.
-- The script1.sh files first checks if all the required files for compilation exists.
-- It then compiles the add.c and sub.c files to produce the object files.
-- The object files are then archived to produce a static library.
-- Then mpy.c and div.c are compiled into a dynamic library libmd.so
-- Finally the two libraries and main program are compiled and linked together to produce the required executable.

-- script1.sh also provides a clean mode to remove all the files generated.
-- To clean run "./script1.sh clean"

                                      TASK 2
-- script2.sh produces the gdb script and executes it to show the state of registers at the entry to each library function.
-- It first checks if an input file is provided and aborts with an error message if te file is not found
-- It then checks if the target executable "calculate" is present.
-- If the executable is not found it asks the user if he wants to build it.
-- If the user selects no the program is aborted.
-- If the user agrees or the executable was already present, the script begins generating a gdb_script.
-- It also asks the user if he wants to see all the library function states (including C library) or just the four functions made by us.
-- Depending on the choice it sets a breakpoint on the required functions.
-- It then writes the commands that are to be executed at the breakpoints.
-- Specifically "i all-registers" is used to print the value of all registers at breakpoints.
-- Then "c" is used to continue the program
-- Finally after all the breakpoints are set it runs the program with user supplied input file.
-- The gdb script is finished.
-- Now it is executed using gdb 
