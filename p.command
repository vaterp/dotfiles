#!/bin/bash
rm output.txt 2>/dev/null

echo "Paste data:"

cat | awk '/^Neigh/,EOF' | python3 /Users/bssnyder/Documents/f/process.py > output.txt

#head output.txt;
#echo "**********"
#tail output.txt
open -a TextEdit output.txt
