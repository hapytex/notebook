#!/bin/bash

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

hhmm=$(date '+%H%M: ')

if [ "$#" -le 0 ]; then
  read -p "$hhmm" entry
else
  entry=$(echo "$@")
fi

echo "$hhmm$entry" >> "$(date +%y%m%d).entry"
