set terminal png size 1920, 1200
set xdata time
set timefmt "%Y-%m-%dT%H:%M:%S"

set output "load.png"
system "cut -f1,2-4 memlog > load.data"
plot "load.data" using 1:2 title "1 min avg" with lines, \
     "load.data" using 1:3 title "5 min avg" with lines, \
     "load.data" using 1:4 title "15min avg" with lines

set output "mem.png"
system "cut -f1,7,8,9,14 memlog > mem.data"
plot "mem.data" using 1:2 title "available" with lines, \
     "mem.data" using 1:($3+$5) title "used" with lines, \
     "mem.data" using 1:5 title "swapped" with lines, \
     "mem.data" using 1:4 title "free" with lines

set output "load-mem.png"
plot "load.data" using 1:4 title "15 min avg" with lines, \
     "mem.data" using 1:($3+$5) axis x1y2 title "used" with lines
