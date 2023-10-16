library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.package_maximum_tree_search.all;

--takes in a 1D-array and returns the maximum location
--using tree search
entity maximum_tree_search is
generic(
    array_length : integer := 9 --defines maximum measurement time range
);
    Port ( i_clk : in STD_LOGIC; --synchronized design, can be done combinatorially
           i_array : in t_maximum_array(0 to array_length-1); --array with values
           o_maximum : out integer --location of maximum in array
           );
end maximum_tree_search;

architecture Behavioral of maximum_tree_search is
--declare internal signals here
signal s_maximum : integer range 0 to array_length-1;
begin
process(i_clk)
begin
clock_if: if(rising_edge(i_clk)) then
--calculate maximum location on rising_edge
s_maximum <= f_maximum_tree_search(i_array);   
end if clock_if;
end process;

--assign outputs
o_maximum <= s_maximum;

end Behavioral;
