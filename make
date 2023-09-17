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

hhmm=$(date '+%H%M: ' -d "$timespec")
yymmdd=$(date '+%y%m%d' -d "$timespec")

for topic in "${topics[@]}"; do
  mkdir -p "entries/$topic"
  echo "$hhmm$entry" >> "entries/$topic/$yymmdd.entry"
done
