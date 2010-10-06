#!/usr/bin/python
import sys

s = 0
c = 0
for l in sys.stdin:
  s += int(l.strip())
  c += 1

print s/c
