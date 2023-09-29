restart -f
add wave sim:/cmp_tb/cmp_instance/*
vcd file cmp.vcd
vcd add cmp_tb/cmp_instance/*
run -all
wave zoom full