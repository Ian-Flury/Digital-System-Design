restart -f
add wave sim:/d_flip_flop_tb/d_flip_flop_instance/*
vcd file d_flip_flop.vcd
vcd add d_flip_flop_tb/d_flip_flop_instance/*
run -all
wave zoom full
