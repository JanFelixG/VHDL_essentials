create_clock -period 10.000 -name i_clk -waveform {0.000 5.000} [get_ports i_clk]
#set_input_delay -clock [get_clocks i_clk] -min -add_delay 2.000 [get_ports i_UART_data]
#set_input_delay -clock [get_clocks i_clk] -max -add_delay 3.000 [get_ports i_UART_data]
#set_output_delay -clock [get_clocks i_clk] -min -add_delay -1.000 [get_ports o_UART_data]
#set_output_delay -clock [get_clocks i_clk] -max -add_delay 2.000 [get_ports o_UART_data]

