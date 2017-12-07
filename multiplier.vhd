library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier is

port ( 
inputA,inputB: in unsigned ( 7 downto 0);
output : out unsigned ( 7 downto 0)
);
end multiplier;

architecture multiply of multiplier is
begin
process(inputA,inputB)
begin 
output <= to_unsigned(to_integer(inputA * inputB),output'range'(8));
end process;
end multiply;