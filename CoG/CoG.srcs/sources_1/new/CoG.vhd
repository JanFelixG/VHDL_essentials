library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.type_package.all;

entity CoG is
generic(
    dim1 : integer := 3; --define range for each dimension
    dim2 : integer := 3;
    dim3 : integer := 3    
);
Port ( 
    i_clk : in STD_LOGIC;
    i_array : in array_3D(0 to dim1-1,0 to dim2-1, 0 to dim3-1);
    o_CoG : out CoG_array_3D
);           
end CoG;

architecture Behavioral of CoG is
--define internals signals here
signal s_CoG : CoG_array_3D := (others =>0);
signal s_totalweight : integer := 0;

begin
CoG_process: process(i_clk)
--define process variables here
variable var_totalweight : integer := 0;
variable var_CoG : CoG_array_3D := (others =>0);
begin
clock_if: if(rising_edge(i_clk)) then
for x in 0 to dim1-1 loop --loop through all elements of array
for y in 0 to dim2-1 loop
for z in 0 to dim3-1 loop
    var_CoG(0) := var_CoG(0) + i_array(x,y,z)*x; --add up pT values
    var_CoG(1) := var_CoG(0) + i_array(x,y,z)*y; --add up phi values
    var_CoG(2) := var_CoG(0) + i_array(x,y,z)*z; --add up theta values
    var_totalweight := var_totalweight + i_array(x,y,z);
end loop;
end loop;
end loop;

s_CoG <= var_CoG;
s_totalweight <= var_totalweight;

end if clock_if;
end process CoG_process;
--assign outputs
o_CoG(0) <= s_CoG(0)/s_totalweight; -- change to multiplication with reciprocal
o_CoG(1) <= s_CoG(1)/s_totalweight; --currently using integer
o_CoG(2) <= s_CoG(2)/s_totalweight; --automatically rounds down numbers

end Behavioral;
