name=$1

files=()

for file in "$@"; do
    file=$file.sv
    files+=($file)
done

iverilog -g2012 -o $name.vvp ${files[@]}\
&& vvp $name.vvp\
&& rm -f $name.vvp
