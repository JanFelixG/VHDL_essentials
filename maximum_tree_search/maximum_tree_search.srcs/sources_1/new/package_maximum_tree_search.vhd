library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package package_maximum_tree_search is

type t_maximum_array is array(integer range <>) of integer range 0 to 7;

function f_maximum_tree_search(
v_maximum_array: in t_maximum_array)
return integer;

end package;

package body package_maximum_tree_search is
--define function for maximum search here
function f_maximum_tree_search(v_maximum_array: t_maximum_array) 
return integer is
variable v_max_location : integer;
variable v_left : t_maximum_array(0 to (v_maximum_array'length/2)-1); --integer division rounds down in vhdl
variable v_right : t_maximum_array(0 to (v_maximum_array'length-1)/2); --change for uneven length arrays
begin
length_check: if(v_maximum_array'length = 1) then --if array-length is 1 return location
    v_max_location := v_maximum_array(0);
else --split array and compare recursively
    --split array --simplify this
    --0 to 3, length 4
    v_left := v_maximum_array(0 to (v_maximum_array'length/2)-1); --smaller if unequal
    --4 to 8, length 5
    v_right := v_maximum_array(v_maximum_array'length/2 to v_maximum_array'length-1); --larger if unequal
    --compare left and right halves of array
    recurse_if: if(f_maximum_tree_search(v_left) > f_maximum_tree_search(v_right)) then --if maximum is in left half keep location, else add array-length/2 for right
        v_max_location := f_maximum_tree_search(v_left);
    else
        v_max_location := f_maximum_tree_search(v_right) + v_maximum_array'length/2; 
    end if recurse_if;
end if length_check;    
return v_max_location;
end f_maximum_tree_search;
end package body;