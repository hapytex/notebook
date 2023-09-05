#!/bin/bash

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

if [ "$#" -le 0 ]; then
  read -p 'entry> ' entry
else
  entry=$(echo "$@")
fi

echo "$(date +%H%M): $entry" >> "$(date +%y%m%d).entry"
