#create timing constraint for main clock
create_clock -period 7.813 -name i_clk -waveform 0.000 3.907 [get_ports i_clk]
