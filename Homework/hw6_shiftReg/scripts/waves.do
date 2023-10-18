restart -f
add wave sim:/shiftReg_tb/shiftReg_instance/*
vcd file shiftReg.vcd
vcd add shiftReg_tb/shiftReg_instance/*
run -all
wave zoom full