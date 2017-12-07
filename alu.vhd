library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ALU is 


Port (

clk : in std_logic;
ps2_code_new	: in std_logic;
ps2_code: in std_logic_vector(7 downto 0);
output : out unsigned(7 downto 0);
inval : out unsigned(7 downto 0));

End ALU;

architecture ALu of ALU is 


signal numA,numB,numC, A1,A2,A3,B1,B2,B3,C1,C2,C3 : unsigned (7 downto 0);
signal A2E,A3E,B2E,B3E,C2E,C3E : std_logic;

signal Op : std_logic_vector (2 downto 0);
signal typeOfInput : std_logic_vector (1 downto 0);  -- 0 for number, 1 for Operand ,2 for equals
signal vals,result,result2 : unsigned (7 downto 0);
signal clr : std_logic;
signal temp,a,b,c: unsigned (7 downto 0);
signal cnt : std_logic;
signal quotient,dd,ds,sm:std_logic_vector(7 downto 0);

type state_type is (idle, InA1,InA2,InA3,OPIn,InB1,InB2,InB3, Comp, Insqrt,InC1,InC2,InC3);
signal current_state: state_type := idle;
signal next_state : state_type := idle;
signal rising_clk : std_LOGIC;

signal startConv, convDone,valid : std_logic;

--signal conc,multiconc,num1,num2,num3,num4,num5,num6,firNum,seNum,c : unsigned(7 downto 0);
--signal compute, num2E,num3E,num5E,num6E : std_logic:= '0';
--signal operat : std_logic_vector(2 downto 0);


--signal counter : unsigned (3 downto 0):= "0000";

component multiplier is

port ( 

inputA,inputB: in unsigned ( 7 downto 0);
output : out unsigned ( 7 downto 0));
end component;

Component Ps2CodeToBinaryNumber is 
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
end Component;

component threeDigitstoBinary is 
port (

clk : in std_logic;
clr : in std_logic;

 startConv : in std_logic;
 A1,A2,A3,B1,B2,B3,C1,C2,C3 : in unsigned (7 downto 0);
 A2E,A3E,B2E,B3E,C2E,C3E : in std_logic;
 convDone : out std_logic;
 numA,numB,numC: out unsigned (7 downto 0)

);

end component;



begin

mult: multiplier port map (numA,numB,result);




conv: ps2CodeToBinaryNumber port map(clk, ps2_code, ps2_code_new, typeOfInput, vals, op,clr,valid);
tobin: threeDigitstoBinary port map(
clk => clk,
clr => clr,
startConv=> startConv,
A1 => A1,
A2=>A2,
A3=>A3,
B1=>B1,
B2=>B2,
B3=>B3,
C1=>C1,
C2=>C2,
C3=>C3,

A2E=>A2E,
A3E=>A3E,
B2E=>B2E,
B3E=>B3E,
C2E=>C2E,
C3E=>C3E,

convDone =>convDone,
numA=>numA,
numB=>numB,
numC=>numC

);

drive : process(clk,clr)

begin
	if(rising_edge(clk)) then
		rising_clk <= '1';
		if (clr = '1') then
			

			current_state <= idle;
			
			else
				current_state <= next_state;
				
			end if;
			
		else
		rising_clk <= '0';
		end if;
		end process;




calcFSM : process (current_state,valid)


begin

next_state <= idle;

C <= (others => '0');
A1 <= (others => '0');
A2 <= (others => '0');
A3 <= (others => '0');
B1 <= (others => '0');
B2 <= (others => '0');
B3 <= (others => '0');
C1 <= (others => '0');
C2 <= (others => '0');
C3 <= (others => '0');
A2E <=  '0';
A3E <= '0';
B2E <= '0';
B3E <= '0';
C2E <= '0';
C3E <= '0';
output <= (others => '0');
startConv <= '0';





case current_state is

when idle =>
			
			
		if(typeOfInput = "00") then	
		A1 <= vals;       
		inval<=A1;
		next_state <= InA1;
		
	
		elsif(Op = "100") then
		next_state <= Insqrt;

	 
		else
		next_state<=idle;
	

		end if;
		
		

when inA1 =>
		output <= "00000000";

	if(typeOfInput = "00") then
	A2 <= vals;

	A2E <= '1';
	next_state <= inA2;


	elsif(typeOfInput = "01") then
		
	
	next_state <= OPIn;
	
	else

	next_state<=idle;
	end if;





when inA2 =>
	output <= "00000000";


	if(typeOfInput = "00") then
	A3 <= vals;
	A3E <= '1';

	next_state <= InA3  ;

	elsif (typeOfInput = "01") then

	next_state <= OPIn ;

	else
	next_state<=idle;
	
	end if;






when inA3 =>
			output <= "00000000";

	if(typeOfInput = "01") then
	
	next_state<= OPIn ;


	else
	next_state<=idle;

	end if;



when OPIn =>
			output <= "00000000";

	if(typeOfInput = "00") then
	B1 <= vals;

	next_state <=  inB1;

	else
	next_state<=idle;

	end if;




when inB1 =>
			output <= "00000000";

	if(typeOfInput = "00") then
	B2 <= vals;
	B2E <= '1';

	next_state <= inB2 ;

	elsif (typeOfInput = "10") then
	next_state <= Comp ;

	else
	next_state<=idle;

	end if;


when inB2 =>
			output <= "00000000";

	if(typeOfInput = "00") then
	B3 <= vals;
	next_state <= inB3 ;

	elsif (typeOfInput = "10") then
	next_state <=  Comp;

	else
	next_state<=idle;

	end if;



when inB3 =>
				output <= "00000000";

	if (typeOfInput = "10") then
	next_state <=  Comp;
	B3E <= '1';


	else
	next_state<=idle;

	end if;




when Insqrt =>
			output<= "00000000";

	if (typeOfInput = "00") then
	C1 <= vals;
	else
	next_state<=idle;

	end if;



when inC1=>		
output <= "00000000";

	if (typeOfInput = "00") then
	C2 <= vals;
		C2E <= '1';

	else
	next_state<=idle;

	end if;


when inC2=>
			output <= "00000000";

	if (typeOfInput = "00") then
	C3 <= vals;
			C3E <= '1';

	else
	next_state<=idle;

	end if;


when inC3=>			
output <= "00000000";

	if (typeOfInput = "10") then
	next_state <= Comp;
	else
	next_state<=idle;

	end if;

when Comp=>
 -- Convert 3 separate decimal digits to a binary number
  
	startConv <= '1';
	if (Op ="000") then
	output <= unsigned(numA + numB);

	elsif (Op = "001") then
	output <= numA - numB;

	elsif (Op = "010") then
		
	output <= to_unsigned(to_integer(numA * numB),output'range'(8));

	elsif (Op = "011") then
	output <= numA / numB;

	elsif (Op = "100") then

	
	
	if(to_integer(numC) < 4) then
	c <= "00000001";
	elsif(to_integer(numC) < 9)then
	c <= "00000010";
	elsif(to_integer(numC)< 16)then
	c <= "00000011";
	elsif(to_integer(numC)< 25)then
	c <= "00000100";
	elsif(to_integer(numC) < 36)then
	c <= "00000101";
	elsif(to_integer(numC) < 49)then
	c <= "00000110";
	elsif(to_integer(numC)  <64)then
	c <= "00000111";
	elsif(to_integer(numC) < 81)then
	c <= "00001000";
	elsif(to_integer(numC)<  100)then
	c <= "00001001";
	elsif(to_integer(numC) < 121)then
	c <= "00001010";
	elsif(to_integer(numC) < 144)then
	c <="00001011";
	elsif(to_integer(numC) < 169)then
	c <= "00001100";
	elsif(to_integer(numC) < 196)then
	c <="00001101";
	elsif(to_integer(numC)<  225)then
	c <= "00001110";
	elsif(to_integer(numC) < 256)then
	c <= "00001111";
	else
	c <= "00000000";
	end if;
		
		
		output <= c;
	
	--elsif (Op = 101) then

	
	--output = result2;
	else 
	output <= "00000000";
	
	end if;


when others =>

	next_state <= idle;


end case;


end process;

--detecttypeOfInput	: process(ps2_code)
--begin
--end process;

--output <= conc;
end ALU;