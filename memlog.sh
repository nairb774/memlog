#!/bin/bash

cd ${0%/*}
{
  {
    date +%FT%T.%N
    cat /proc/loadavg
    free -o | tail -n+2 | sed -r 's/\s+/\t/g' | cut -f2-7
    vmstat 1 2 | tail -n1 | sed -r 's/\s+/\t/g' | cut -f2,3,8-17
  } | tr '\n' '\t'
  echo
} | sed -r 's/\s+/\t/g' >> memlog
