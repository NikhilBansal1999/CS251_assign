if [[ -z "$1" ]]
then
  echo "No input file specified"
  exit
fi

if [[ -e calculate ]]
then
  read -p "Do you want to see register state at entry to C library functions also (y or n):" C_lib
  File=$1
  echo "set breakpoint pending on" > gdb_script
  echo "b add" >> gdb_script
  echo "b subtract" >> gdb_script
  echo "b multiply" >> gdb_script
  echo "b divide" >> gdb_script
  if [[ $C_lib == 'y' ]]
  then
     echo "b printf" >> gdb_script
     echo "b fopen" >> gdb_script
     echo "b feof" >> gdb_script
     echo "b fscanf" >> gdb_script
     echo "b fclose" >> gdb_script

     echo "command 5" >> gdb_script
     echo "i all-registers" >> gdb_script
     echo "c" >> gdb_script
     echo "end" >> gdb_script

     echo "command 6" >> gdb_script
     echo "i all-registers" >> gdb_script
     echo "c" >> gdb_script
     echo "end" >> gdb_script

     echo "command 7" >> gdb_script
     echo "i all-registers" >> gdb_script
     echo "c" >> gdb_script
     echo "end" >> gdb_script

     echo "command 8" >> gdb_script
     echo "i all-registers" >> gdb_script
     echo "c" >> gdb_script
     echo "end" >> gdb_script

     echo "command 9" >> gdb_script
     echo "i all-registers" >> gdb_script
     echo "c" >> gdb_script
     echo "end" >> gdb_script
  fi

  echo "command 1" >> gdb_script
  echo "i all-registers" >> gdb_script
  echo "c" >> gdb_script
  echo "end" >> gdb_script

  echo "command 2" >> gdb_script
  echo "i all-registers" >> gdb_script
  echo "c" >> gdb_script
  echo "end" >> gdb_script

  echo "command 3" >> gdb_script
  echo "i all-registers" >> gdb_script
  echo "c" >> gdb_script
  echo "end" >> gdb_script

  echo "command 4" >> gdb_script
  echo "i all-registers" >> gdb_script
  echo "c" >> gdb_script
  echo "end" >> gdb_script


  echo "r $File" >> gdb_script

  gdb --batch --command=gdb_script calculate
else
  echo "Target executable not found"
  echo "Do you want to build it (y or n):"
  read agree
  if [[ $agree == 'y' ]]
  then
    ./script1.sh
    ./script2.sh $1
  else
    echo "Execution aborted!"
  fi
fi
