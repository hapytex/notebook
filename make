#!/bin/bash

read -p 'entry> ' entry

echo "$(date +%H%M): $entry" >> "$(date +%y%m%d).entry"
