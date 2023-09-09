#!/bin/bash

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

hhmm=$(date '+%H%M: ')
yymmdd=$(date '+%y%m%d')

if [ "$#" -le 0 ]; then
  read -p "$hhmm" entry
else
  entry=$(echo "$@")
fi

echo "$hhmm$entry" >> "entries/$yymmdd.entry"
