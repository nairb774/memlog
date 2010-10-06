#!/usr/bin/python
import sys

last = 0
count = 0
for l in sys.stdin:
  l = int(l.strip())
  if l != last:
    print last, count
  last = l
  count += 1

print last, count
