library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--top module for TDC
--takes in start signal and stop signal and computes time between signals
--uses frequency counter for long time measurements
--and vernier delay line for high resolution
entity Inverter is
Port(
i_bit: in STD_LOGIC;
o_inverted_bit : out STD_LOGIC
);
end Inverter;

architecture Behavioral of Inverter is

begin

o_inverted_bit <= not i_bit;

end Behavioral;
