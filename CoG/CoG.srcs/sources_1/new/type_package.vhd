library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


package type_package is

type array_3D is array(integer range <>,integer range <>,integer range <>) of integer range 0 to 7; --switch to integer
type CoG_array_3D is array(0 to 2) of integer; --CoG only on voxels not in between
--type CoG_array_3D_float is array(0 to 2) of float;  --float for vhdl 2008 only

end package;
