#!/usr/bin/python3

import sys

item=""
for line in sys.stdin:
    line=line.strip()
    #print(line)
    if (line == ""):
        continue;
    if "chevron_down" in line:
        continue;
    if (item == ""):
        item=line
        #print("item set")
        continue;
    if (line.isnumeric()):
        #print("numeric")
        print(item+","+line)
        item = ""
        continue

