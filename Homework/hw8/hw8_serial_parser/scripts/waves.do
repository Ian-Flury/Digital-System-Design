restart -f
add wave sim:/serial_tb/serial_instance/*
vcd file serial.vcd
vcd add serial_tb/serial_instance/*
run -all
wave zoom full