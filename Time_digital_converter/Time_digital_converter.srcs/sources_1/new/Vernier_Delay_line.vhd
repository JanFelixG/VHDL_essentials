library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--Vernier Delay line
--increase time resolution from pure frequency counter
--only measures short time intervals, not dead-time free
--output is the number of passed delay blocks
--maximum time that can be measured is 
--delay-time * #number_of_delay_elements
--combine with frequency counter for long dead-time free time measurement
entity Vernier_delay_line is
Port(
i_start: in std_logic; --start-signal
i_stop: in std_logic; --stop signal
o_time: std_logic_vector(7 downto 0) --time between start and stop signal
);
end Vernier_delay_line;

architecture Behavioral of Vernier_delay_line is

--define types here

--define signals here

begin

process(i_start, i_stop)
begin
if(rising_edge(i_start)) then



end if;
end process;

--assign outputs


end Behavioral;
