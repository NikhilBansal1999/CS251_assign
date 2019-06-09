prev_line=""
new_line=""
while wget http://static.cricinfo.com/rss/livescores.xml > /dev/null 2>/dev/null
do
  new_line=`grep -i "^<title>.*$1" livescores.xml | sed 's/\&amp; /\&/g'`
  if [[ $new_line != $prev_line ]]
  then
    notify-send "${new_line: 7:-8}"
  fi
  prev_line=$new_line
  rm livescores.xml*
  sleep 10
done
