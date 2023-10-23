#!/bin/bash

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

hhmm=$(date '+%H%M: ')

if [ "$#" -le 0 ]; then
  read -p "$hhmm" entry
else
  entry=$(echo "$@")
fi

timespec=$(grep -P -o '(?<=[@]).+' <<<"$entry" || echo 'now')

topics=('general')
topics+=( $(grep -P -o '(?<=[#])\w+' <<<"$entry") )

yymmddhhmm=$(date '+%y%m%d%H%M: ' -d "$timespec")
hhmm="${yymmddhhmm:6:6}"
yymmdd="${yymmddhhmm:0:6}"

if [ "$#" -le 0 ]; then
  echo -e "\033[1A\033[999D\033[32m$hhmm\033[0m\033[6D"
fi

for topic in "${topics[@]}"; do
  mkdir -p "entries/$topic"
  echo "$hhmm$entry" >> "entries/$topic/$yymmdd.entry"
done
