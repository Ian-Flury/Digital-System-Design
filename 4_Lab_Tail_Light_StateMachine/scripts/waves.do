restart -f
add wave sim:/tail_light_top_tb/tail_light_top_instance/*
vcd file tail_light_top.vcd
vcd add tail_light_top_tb/tail_light_top_instance/*
run -all
wave zoom full