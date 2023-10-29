library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--simple inverter
--only needed for generate loop in ring oscillator
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
