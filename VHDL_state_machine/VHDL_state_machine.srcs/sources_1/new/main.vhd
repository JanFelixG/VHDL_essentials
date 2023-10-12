library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( i_clk : in STD_LOGIC;
           i_switch : in STD_LOGIC_VECTOR (1 downto 0);
           o_leds : out STD_LOGIC_VECTOR (1 downto 0));
end main;

architecture Behavioral of main is
signal s_leds : std_logic_vector(1 downto 0);

begin

process(i_clk)
begin
case i_switch is
when "00" =>
    s_leds <= "00";
when "01" =>
    s_leds <= "01";
when "10" =>
    s_leds <= "10";
when "11" =>
    s_leds <= "11";
end case;
end process;

--assign outputs
o_leds <= s_leds;

end Behavioral;
