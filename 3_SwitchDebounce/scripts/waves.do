restart -f
add wave sim:/swdbnc_tb/swdbnc_instance/*
vcd file swdbnc.vcd
vcd add swdbnc_tb/swdbnc_instance/*
run -all
wave zoom full