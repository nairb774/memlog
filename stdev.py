#!/usr/bin/python
import math
import sys

s = 0
c = 0
sq = 0
for l in sys.stdin:
  l = int(l.strip())
  s += l
  c += 1
  sq += l * l

avg = s / c
print math.sqrt(sq / c - avg * avg)
