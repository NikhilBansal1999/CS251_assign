while read -r line || [[ -n $line ]];
do
  arr=($line)

  if file -b ${arr[0]} | grep -i pdf > /dev/null
  then
    if [[ ${arr[2]: -1} == "/" ]]
    then
      directory="${arr[2]}doc"
    else
      directory="${arr[2]}/doc"
    fi
  elif file -b ${arr[0]} | grep -i -e "executable" -e "interpreter" > /dev/null
  then
    if [[ ${arr[2]: -1} == "/" ]]
    then
      directory="${arr[2]}bin"
    else
      directory="${arr[2]}/bin"
    fi
  elif file -b ${arr[0]} | grep -i -e "ASCII" -e "C Source" > /dev/null
  then
    if [[ ${arr[2]: -1} == "/" ]]
    then
      directory="${arr[2]}include"
    else
      directory="${arr[2]}/include"
    fi
  else
    if [[ ${arr[2]: -1} == "/" ]]
    then
      directory="${arr[2]}lib"
    else
      directory="${arr[2]}/lib"
    fi
  fi

  permission=""
  if echo ${arr[1]} | grep -i Read > /dev/null
  then
    permission+="r"
  fi
  if echo ${arr[1]} | grep -i Write > /dev/null
  then
    permission+="w"
  fi
  if echo ${arr[1]} | grep -i Execute > /dev/null
  then
    permission+="x"
  fi

  mkdir -p $directory
  cp ${arr[0]} "${directory}/${arr[0]}"
  chmod u=$permission "${directory}/${arr[0]}"

done < $1
