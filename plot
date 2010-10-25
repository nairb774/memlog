binwidth=16384
bin(x,width)=width*floor(x/width)

set terminal png size 1920, 1200

system "cut -f8,14 memlog | awk '{print $1+$2;}' | sort -n > mem.histo"
system "./accum.py < mem.histo > mem.accum"
set output "mem-histo.png"
set y2tics

avg=`./avg.py < mem.histo`
stdev=`./stdev.py < mem.histo`

set arrow from avg, graph 0 to avg, graph 1 lw 2 nohead
set arrow from (avg-stdev), graph 0 to (avg-stdev), graph 1 nohead
set arrow from (avg+stdev), graph 0 to (avg+stdev), graph 1 nohead
set arrow from (avg-2*stdev), graph 0 to (avg-2*stdev), graph 1 nohead
set arrow from (avg+2*stdev), graph 0 to (avg+2*stdev), graph 1 nohead

plot "mem.histo" using (bin($1,binwidth)):(1.0) smooth freq title "Histogram" with boxes, \
     "mem.accum" using 1:2 smooth bezier axis x1y2 title "Cumulative Count" with lines

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

system "awk 'NF >= 27 {print $0;}' memlog | cut -f1,2,18-21 > load-io.data"

set output "load-io.png"
plot "load-io.data" using 1:2 title "1 min avg" with lines, \
     "load-io.data" using 1:3 axis x1y2 title "si" with lines, \
     "load-io.data" using 1:4 axis x1y2 title "s0" with lines, \
     "load-io.data" using 1:5 axis x1y2 title "bi" with lines, \
     "load-io.data" using 1:6 axis x1y2 title "b0" with lines

system "awk 'NF >= 27 {print $0;}' memlog | cut -f1,2,24,27 > load-cpu.data"

set output "load-cpu.png"
plot "load-cpu.data" using 1:2 title "1 min avg" with lines, \
     "load-cpu.data" using 1:3 axis x1y2 title "user" with lines, \
     "load-cpu.data" using 1:4 axis x1y2 title "wait" with lines
