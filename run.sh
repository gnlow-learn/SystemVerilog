name=$1

iverilog -g2012 -o $name.vvp $name.sv\
&& vvp $name.vvp\
&& rm -f $name.vvp
