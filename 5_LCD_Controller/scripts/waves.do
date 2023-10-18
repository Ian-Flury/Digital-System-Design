restart -f
add wave sim:/lcd_top_level_tb/lcd_top_level_instance/*
vcd file lcd_top_level.vcd
vcd add lcd_top_level_tb/lcd_top_level_instance/*
run -all
wave zoom full