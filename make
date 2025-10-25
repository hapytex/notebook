#!/bin/bash

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"



hhmm=$(date '+%H%M')
title=$(echo -n -e "\033]0;📓 $hhmm Notebook entry\a  \033[93m$hhmm: \033[0m\033[1m")

if [ "$#" -le 0 ]; then
  read -p "$title" entry
else
  entry=$(echo "$@")
fi
echo -en '\033[0m'

if [ "$entry" == 'CLEAR' ]; then
  for _ in $(seq `tput lines`); do
    echo
  done
fi

timespec=$(grep -P -o '(?<=[@]).+' <<<"$entry" || echo 'now')

topics=('general')
topics+=( $(grep -P -o '(?<=[#])\w+' <<<"$entry") )

yymmddhhmm=$(date '+%y%m%d%H%M' -d "$timespec")
hhmm="${yymmddhhmm:6:4}"
yymmdd="${yymmddhhmm:0:6}"

# redacted version
wht=$(echo -en "\033[37m\e[47m")
ned=$(echo -en "\033[0m")
red=$(sed -e "s/[|][^|]*[|]/$wht\\0$ned/g" <<<"$entry")

if [ "$#" -le 0 ]; then
  echo -e "\033[1A\r\033[32m✓ $hhmm: \033[0m$red\033[0m\r"
fi

for topic in "${topics[@]}"; do
  topic=$(sed -E 's/\W+/_/g' <<<"$topic" | tr '[:upper:]' '[:lower:]')
  mkdir -p "entries/$topic"
  echo "$hhmm: $entry" >> "entries/$topic/$yymmdd.entry"
done
