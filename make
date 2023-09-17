#!/bin/bash

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

hhmm=$(date '+%H%M: ')

if [ "$#" -le 0 ]; then
  read -p "$hhmm" entry
else
  entry=$(echo "$@")
fi

topics=('general')
topics+=( $(grep -P -o '(?<=[#])\w+' <<<"$entry") )

hhmm=$(date '+%H%M: ')
yymmdd=$(date '+%y%m%d')

for topic in "${topics[@]}"; do
  mkdir -p "entries/$topic"
  echo "$hhmm$entry" >> "entries/$topic/$yymmdd.entry"
done
