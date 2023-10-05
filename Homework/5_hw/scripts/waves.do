restart -f
add wave sim:/hw5_tb/hw5_instance/*
vcd file hw5.vcd
vcd add hw5_tb/hw5_instance/*
run -all
wave zoom full
