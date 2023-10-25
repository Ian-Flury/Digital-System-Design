restart -f
add wave sim:/sqrWv_tb/sqrWv_instance/*
vcd file sqrWv.vcd
vcd add sqrWv_tb/sqrWv_instance/*
run -all
wave zoom full