library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--module takes in reference clock with known frequency
--sum up all rising edges of signal during fixed number of 
--rising_edges from reference clock 
--return counter-value as integer
--freq-counter is dead time free, precisions is determined by frequency of reference
entity Freq_counter is
generic(
    measurement_range : integer := 4095; --defines maximum measurement time range
    interval : integer := 1023 --defines time intervals between measurement points
);
    Port ( i_ref : in STD_LOGIC; --reference clock
           i_signal : in STD_LOGIC; --signal clock
           o_signal_counter : out integer range 0 to measurement_range;
           o_reference_counter : out integer range 0 to measurement_range
           );
end Freq_counter;

architecture Behavioral of Freq_counter is
--declare internal signals here
--signals for counting up clock_edges
signal s_freq_counter,s_ref_counter : integer range 0 to measurement_range := 0; --range defines maximum measurement interval
--temp signals for storange
signal s_freq_counter_temp,s_ref_counter_temp : integer range 0 to measurement_range := 0;
 
begin
signal_counter: process(i_signal) --sum up edges of signal
begin
clock_if: if(rising_edge(i_signal)) then
    s_freq_counter <= s_freq_counter + 1;
end if clock_if;
end process signal_counter;    

ref_counter: process(i_ref) --sum up edges of reference
begin
clock_if: if(rising_edge(i_ref)) then
if(s_ref_counter /= 0) then
    s_ref_counter <= s_ref_counter - 1; 
else --if 0 reset signal 
    s_ref_counter <= interval;    
    s_freq_counter_temp <= s_freq_counter; --have to make sure signal is stable before assignement
    s_ref_counter_temp <= s_ref_counter;  
end if;
end if clock_if;
end process ref_counter;  

--divide for frequency
--s_frequency 

--assign outputs
o_signal_counter <= s_freq_counter_temp;
o_reference_counter <= s_ref_counter_temp;

end Behavioral;
