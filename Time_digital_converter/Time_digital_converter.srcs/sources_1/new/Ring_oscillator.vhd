library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

--ring oscillator to generate clock
entity ring_oscillator is
Port(
o_ring_clk: out std_logic --generate clock here
);
end ring_oscillator;

architecture Behavioral of ring_oscillator is

--define components here
component Inverter is --build ring_oscillator from inverters
Port (
i_bit: in STD_LOGIC;
o_inverted_bit: out STD_LOGIC);
end component;

signal a,b : std_logic_vector (6 downto 0);

begin

--generate ring_oscillator from at least 5 inverters, otherwise frequency might be too high and could melt the chip
GEN_INV: 
for i in 0 to 6 generate --use uneven number for ring-oscillator
    inve0:
    if (i=0) generate
        inv1 : Inverter port map
        (i_bit=>b(6),
        o_inverted_bit=>b(i));
    end generate;
    inve1:
    if(i/=0) generate
        inv1 : Inverter port map
        (i_bit=>b(i-1),o_inverted_bit=>b(i));
    end generate;
end generate;

--assign outputs here
o_ring_clk <= b(0); --assign any bit from ring to output, all have the same frequency

end Behavioral;