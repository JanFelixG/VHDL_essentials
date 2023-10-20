library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.package_maximum_tree_search.all;

--takes in a 1D-array and returns the maximum location
--using tree search
entity maximum_tree_search is
generic(
    array_length : integer := 8; --defines maximum measurement time range
    dim1 : integer := 2;
    dim2 : integer := 2;
    dim3 : integer := 2
);
Port( 
    i_clk : in STD_LOGIC; --synchronized design, can be done combinatorially
    i_array : in t_maximum_array(0 to array_length-1); --array with values
    i_array_3D : in t_maximum_array_3D(0 to dim1-1,0 to dim2-1,0 to dim3-1); --3D array with values           
    o_maximum : out integer; --location of maximum in array
    o_maximum_3D : out t_maximum_3D(0 to 2)    
);
end maximum_tree_search;

architecture search_1D of maximum_tree_search is
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

end search_1D;

--architecture search_3D of maximum_tree_search is
----declare internal signals here
--signal s_maximum : integer range 0 to dim1*dim2*dim3-1; --location of maximum in array
--signal s_maximum_3D : t_maximum_3D(0 to 2);  --3D location of maximum
--signal s_array : t_maximum_array(0 to dim1*dim2*dim3-1);

--begin
--splitting: process(i_array_3D)
--begin
--for x in 0 to dim1-1 loop
--for y in 0 to dim2-1 loop
--for z in 0 to dim3-1 loop
--    --split 3D-array into 1D-array
--    s_array(x+dim1*y+dim1*dim2*z) <= i_array_3D(x,y,z);
--end loop;
--end loop;
--end loop;
--end process splitting;

--max_search: process(i_clk)
--begin
--clock_if: if(rising_edge(i_clk)) then
----calculate maximum location on rising_edge
--s_maximum <= f_maximum_tree_search(s_array);   
--end if clock_if;
--end process max_search;

----assign outputs
----encode to 3D location here
--o_maximum_3D(2) <= s_maximum/(dim1*dim2);
--o_maximum_3D(1) <= s_maximum/(dim1)-dim2*s_maximum/(dim2*dim1);
--o_maximum_3D(0) <= s_maximum-dim1*(s_maximum/(dim1)-dim2*s_maximum/(dim2*dim1));

--end search_3D;

