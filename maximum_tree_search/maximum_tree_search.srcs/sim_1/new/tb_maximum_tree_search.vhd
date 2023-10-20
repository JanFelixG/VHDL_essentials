library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.package_maximum_tree_search.all;

entity tb_maximum_tree_search is
end tb_maximum_tree_search;

architecture Behavioral of tb_maximum_tree_search is
--clock period here
constant c_period : time := 40ns;

--generic constants here
constant c_array_length : integer := 9;
constant c_dim1 : integer := 2;
constant c_dim2 : integer := 2;
constant c_dim3 : integer := 2;

--uut here
component maximum_tree_search is
generic(
    array_length : integer := 9; --defines maximum measurement time range
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
end component maximum_tree_search;

--signals for simulation here
signal s_clk : std_logic := '0';
signal s_array : t_maximum_array(0 to c_array_length-1) := (others=> 0);
signal s_maximum : integer := 0;

--3D part here
signal s_array_3D : t_maximum_array_3D(0 to c_dim1-1,0 to c_dim2-1,0 to c_dim3-1) := (others=>(others=>(others=>0)));
signal s_maximum_3D : t_maximum_3D(0 to 2) := (0,0,0);

begin
-- Instantiate the Unit Under Test (UUT)
UUT : maximum_tree_search
generic map(
array_length => c_array_length,
dim1 => c_dim1,
dim2 => c_dim2,
dim3 => c_dim3
)
port map(
i_clk     => s_clk,
i_array    => s_array,
i_array_3D  => s_array_3D,
o_maximum  => s_maximum,
o_maximum_3D => s_maximum_3D
);
 
clock_generation : process is --process for clock switching
begin
wait for c_period/2;
s_clk <= not s_clk;
end process clock_generation; 

signal_generation : process is --process for input signal genration
begin
wait for 100 ns;
s_array(0) <= 0;
s_array(1) <= 1;
wait for 100 ns;
s_array(1) <= 0;
s_array(2) <= 1;
wait for 100 ns;
s_array(2) <= 0;
s_array(3) <= 1;
wait for 100 ns;
s_array(3) <= 0;
s_array(4) <= 1;
wait for 100 ns;
s_array(4) <= 0;
s_array(5) <= 1;
wait for 100 ns;
s_array(5) <= 0;
s_array(6) <= 1;
wait for 100 ns;
s_array(6) <= 0;
s_array(7) <= 1;
wait for 100 ns;
s_array(7) <= 0;
s_array(8) <= 1;
wait for 100 ns;
s_array(0) <= 0;
s_array(1) <= 1;
s_array(2) <= 2;
s_array(3) <= 3;
s_array(4) <= 4;
s_array(5) <= 5;
s_array(6) <= 6;
s_array(8) <= 7;

end process signal_generation;

end Behavioral;
