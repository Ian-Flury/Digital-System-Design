#!/bin/bash
vlib work
vcom -work work -2008 -explicit "./debounce.vhd" 
vcom -work work -2008 -explicit "./debounce_tb.vhd" 

# run modelsim simulation and visualize waves 
vsim -gui -voptargs="+acc" work.debounce_tb -do waves.do

# run modelsim simulation and quit
## vsim -voptargs="+acc" work.debounce_tb -do runsim.do
# to visualize the waves:
# - you can use gtkwave
#   gtkwave debounce.vcd
# - or you can use modelsim
#   vsim -gui vsim.wlf

# NOTE: Enabling design object visibility with the +acc option
