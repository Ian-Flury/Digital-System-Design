restart -f
add wave sim:/mux_tb/mux_instance/*
vcd file mux.vcd
vcd add mux_tb/mux_instance/*
run -all
