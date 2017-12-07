library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity Ps2CodeToBinaryNumber is 
port (

clk	:in std_logic;
ps2_code			:in std_logic_vector(7 downto 0);
ps2_code_new	: in std_logic;

InputType		: out std_logic_vector (1 downto 0);
NumberVal				: out unsigned(7 downto 0);
Operation					: out std_logic_vector (2 downto 0);
clr			: out std_logic;
valid		: inout std_logic


);
end Ps2CodeToBinaryNumber;

architecture codeToBinary of Ps2CodeToBinaryNumber is 

--signal inputType		:  std_logic_vector (1 downto 0);
signal Val				:  unsigned(7 downto 0);
signal Op					:  std_logic_vector (2 downto 0);

begin


 process(clk)
begin
if(clk'event and clk = '1') then
--IF (ps2_code_new'event) and (ps2_code_new = '1') then

if(ps2_code = "01111001") then
	inputType <= "01";  	--for addi
	Op <= "000";
	if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01111011") then
	inputType <= "01";   	-- for sub	
	Op <= "001";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01111100") then
	inputType <= "01";   	-- for mul
	Op <= "010";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01001010") then
	inputType <= "01";   	-- for div	
	Op <= "011";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "00011011") then
	inputType <= "01";   	-- for sqrt
	Op <= "100";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
--elsif(ps2_code = "00110100") then
	--inputType <= "01";   	-- for GCD
	--Op <= "101";

elsif(ps2_code = "01110000") then
	inputType <= "00";   	-- 0
	val <= "00000000";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01101001") then
	inputType <= "00";   	-- 1
	val <= "00000001";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01110010") then
	inputType <= "00";   	-- 2
	val <= "00000010";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01111010") then	
	inputType <= "00";   	-- 3
	val <= "00000011";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01101011") then
	inputType <= "00";   	-- 4
	val <= "00000100";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01110011") then
	inputType <= "00";   	-- 5
	val <= "00000101";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01110100") then
	inputType <= "00";   	-- 6
	val <= "00000110";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01101100") then
	inputType <= "00";   	-- 7
	val <= "00000111";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01110101") then
	inputType <= "00";   	-- 8
	val <= "00001000";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;
elsif(ps2_code = "01111101") then
	inputType <= "00";   	-- 9
	val <= "00001001";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;


elsif(ps2_code = "01010101") then
	inputType <= "10";   	-- =
	--Op <= "110";
if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;

elsif( ps2_code = "01100110") then
	clr <= '1';		-- backspace (clear);
else
	if (valid <= '1') then
		valid <= '0';
		else
		valid <= '1';
		end if;

	
end if;
end if;

end process;

numberVal <= val;
Operation <= op;

end codetoBinary;