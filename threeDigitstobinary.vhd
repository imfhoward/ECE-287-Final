library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity threeDigitstoBinary is 
port (
clk :in std_logic;
clr : in std_logic;
 startConv : in std_logic;
 A1,A2,A3,B1,B2,B3,C1,C2,C3 : in unsigned (7 downto 0);
 A2E,A3E,B2E,B3E,C2E,C3E : in std_logic;
 convDone : out std_logic;
 numA,numB,numC: out unsigned (7 downto 0)

);

end threeDigitstoBinary;

architecture convert of threeDigitstoBinary is

type state_type is (state1,state2);
signal current_state: state_type := state1;
signal next_state : state_type := state1;
signal rising_clk : std_logic;

begin


drive : process(clk,clr)

begin
	if(rising_edge(clk)) then
		rising_clk <= '1';
		if (clr = '1') then
			current_state <= state1;
			
			else
				current_state <= next_state;
				
			end if;
			
		else
		rising_clk <= '0';
		end if;
		end process;





process (startConv,current_state)
begin

convDone <= '0';


case  current_state is

when state1 =>
if(startConv'event and startConv = '1') then

if(A2E = '1') then
		if (A3E = '1') then
				numA <= to_unsigned(to_integer(A1)*100 + to_integer(A2)*10 + to_integer(A3),numA'range'(8));
		elsif (A3E = '0') then
		numA <= to_unsigned(to_integer(A1)*10 + to_integer(A2), numA'range'(8));
		end if;

	elsif(A2E = '0') then
		numA <= A1;
	end if;
	
	if(B2E = '1') then
		if (B3E = '1') then
				numB <= to_unsigned(to_integer(B1)*100 + to_integer(B2)*10 + to_integer(B3),numB'range'(8));
		else
		numB <= to_unsigned(to_integer(B1)*10 + to_integer(B2), numB'range'(8));
		end if;
	else
		numB <= B1;
	end if;
	
  if(C2E = '1') then
		if (C3E = '1') then
				numC <= to_unsigned(to_integer(C1)*100 + to_integer(C2)*10 + to_integer(C3),numC'range'(8));
		else
		numC <= to_unsigned(to_integer(C1)*10 + to_integer(C2), numC'range'(8));
		end if;
	else
		numC <= C1;
	end if;
	
next_state <= state2;	
end if;

when state2 =>

convDone <= '1';
next_state <= state1;

when others => 
convDone <= '0';
next_state <= state1;

end case;
	end process;
	
	end convert;