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

yymmddhhmm=$(date '+%y%m%d%H%M:' -d "$timespec")
hhmm="${yymmddhhmm:6:5}"
yymmdd="${yymmddhhmm:0:6}"

for topic in "${topics[@]}"; do
  mkdir -p "entries/$topic"
  echo "$hhmm$entry" >> "entries/$topic/$yymmdd.entry"
done
