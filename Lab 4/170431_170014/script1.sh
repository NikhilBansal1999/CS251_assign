if [[ $1 == "clean" ]]
then
  rm -f *.o *.a *.so calculate
  exit
fi

if [[ ! -e add.c ]]
then
  echo "ERROR: add.c not found"
  exit
fi

if [[ ! -e sub.c ]]
then
  echo "ERROR: sub.c not found"
  exit
fi

if [[ ! -e mpy.c ]]
then
  echo "ERROR: mpy.c not found"
  exit
fi

if [[ ! -e div.c ]]
then
  echo "ERROR: div.c not found"
  exit
fi

if [[ ! -e calculate.c ]]
then
  echo "ERROR: calculate.c not found"
  exit
fi

if [[ ! -e calculate.h ]]
then
  echo "ERROR: calculate.h not found"
  exit
fi

gcc -g -c add.c sub.c
ar -rc libas.a add.o sub.o
rm add.o sub.o
gcc -fPIC -shared -g -o libmd.so mpy.c div.c
gcc -g -o calculate calculate.c libas.a "$PWD"/libmd.so
