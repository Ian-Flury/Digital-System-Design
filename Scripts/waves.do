restart -f
add wave sim:/debounce_tb/debounce_instance/*
vcd file debounce.vcd
vcd add debounce_tb/debounce_instance/*
run -all
wave zoom full