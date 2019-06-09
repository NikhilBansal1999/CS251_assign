#!/bin/sh

echo "Enter the name of a team: "
read name
oldscore=""
newscore=""

rm -f livescores.xml

while [ 0 ]; do
  wget -O livescores.xml http://static.cricinfo.com/rss/livescores.xml > /dev/null 2>&1
  newscore=$(cat livescores.xml | grep -i "$name.*title" | cut -d "<" -f 2 | cut -d ">" -f 2 | sed 's/amp; //g')
  if [ "$oldscore" != "$newscore" ]; then
      oldscore="$newscore"
      notify-send "$newscore"
  fi
  rm livescores.xml
  sleep 15
done
