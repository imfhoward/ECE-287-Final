LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY debounce IS
  GENERIC(
    counter_size  :  INTEGER := 1); --counter size (19 bits gives 10.5ms with 50MHz clock)
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    button  : IN  STD_LOGIC;  --input signal to be debounced
    result  : OUT STD_LOGIC); --debounced signal
END debounce;

ARCHITECTURE logic OF debounce IS
  SIGNAL flipflops   : STD_LOGIC_VECTOR(1 DOWNTO 0); --input flip flops
  SIGNAL counter_set : STD_LOGIC;                    --sync reset to zero
  SIGNAL counter_out : STD_LOGIC_VECTOR(counter_size DOWNTO 0) := (OTHERS => '0'); --counter output
BEGIN

  counter_set <= flipflops(0) xor flipflops(1);   --determine when to start/reset counter
  
  PROCESS(clk)
  BEGIN
    IF(clk'EVENT and clk = '1') THEN
      flipflops(0) <= button;
      flipflops(1) <= flipflops(0);
      If(counter_set = '1') THEN                  --reset counter because input is changing
        counter_out <= (OTHERS => '0');
      ELSIF(counter_out(counter_size) = '0') THEN --stable input time is not yet met
        counter_out <= counter_out + 1;
      ELSE                                        --stable input time is met
        result <= flipflops(1);
      END IF;    
    END IF;
  END PROCESS;
END logic;





LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Keyboard IS
  GENERIC(
    clk_freq              : INTEGER := 50_000_000; --system clock frequency in Hz
    debounce_counter_size : INTEGER := 8);         --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
  PORT(
    clk          : IN  STD_LOGIC;                     --system clock
    ps2_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
    ps2_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
    ps2_code_new : inOUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    ps2_code     : inOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 LCD_ENABLE 	: OUT STD_LOGIC;
		LCD_RW 	: OUT STD_LOGIC;
		LCD_RS 	: OUT STD_LOGIC;
		LCD_DATA 	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --code received from PS/2
END Keyboard;

ARCHITECTURE logic OF Keyboard IS
  SIGNAL sync_ffs     : STD_LOGIC_VECTOR(1 DOWNTO 0);       --synchronizer flip-flops for PS/2 signals
  SIGNAL ps2_clk_int  : STD_LOGIC;                          --debounced clock signal from PS/2 keyboard
  SIGNAL ps2_data_int : STD_LOGIC;                          --debounced data signal from PS/2 keyboard
  SIGNAL ps2_word     : STD_LOGIC_VECTOR(10 DOWNTO 0);      --stores the ps2 data word
  SIGNAL error        : STD_LOGIC;                          --validate parity, start, and stop bits
  SIGNAL count_idle   : INTEGER RANGE 0 TO clk_freq/18_000; --counter to determine PS/2 is idle
  type state_type is (	S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, 
							S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, 
							S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, 
							S30, S31, S32, S33, S34, S35, S36, S37, S38, S39,
							S40,S41,S42,S43,S44,S45,S46,S47,S48,S49,S50,S51,
							S52,S53,S54,S55,S56,S57,S58,S59,S60,S61,S62,S63,
							S64,S65,S66,S67,S68,S69,S70,S71,S72,S73,S74,S75,
							S76,S77,S78,S79,S80,S81,S82,S83,S84,S85,S86,S87,
							S88,S89,S90,S91,S92,S93,IDLE);
  signal current_state: state_type;
  
  --declare debounce component for debouncing PS2 input signals
  COMPONENT debounce IS
    GENERIC(
      counter_size : INTEGER); --debounce period (in seconds) = 2^counter_size/(clk freq in Hz)
    PORT(
      clk    : IN  STD_LOGIC;  --input clock
      button : IN  STD_LOGIC;  --input signal to be debounced
      result : OUT STD_LOGIC); --debounced signal
  END COMPONENT;
BEGIN

  --synchronizer flip-flops
  PROCESS(clk)
  BEGIN
    IF(clk'EVENT AND clk = '1') THEN  --rising edge of system clock
      sync_ffs(0) <= ps2_clk;           --synchronize PS/2 clock signal
      sync_ffs(1) <= ps2_data;          --synchronize PS/2 data signal
    END IF;
  END PROCESS;

  --debounce PS2 input signals
  debounce_ps2_clk: debounce
    GENERIC MAP(counter_size => debounce_counter_size)
    PORT MAP(clk => clk, button => sync_ffs(0), result => ps2_clk_int);
  debounce_ps2_data: debounce
    GENERIC MAP(counter_size => debounce_counter_size)
    PORT MAP(clk => clk, button => sync_ffs(1), result => ps2_data_int);

  --input PS2 data
  PROCESS(ps2_clk_int)
  BEGIN
    IF(ps2_clk_int'EVENT AND ps2_clk_int = '0') THEN    --falling edge of PS2 clock
      ps2_word <= ps2_data_int & ps2_word(10 DOWNTO 1);   --shift in PS2 data bit
    END IF;
  END PROCESS;
    
  --verify that parity, start, and stop bits are all correct
  error <= NOT (NOT ps2_word(0) AND ps2_word(10) AND (ps2_word(9) XOR ps2_word(8) XOR
        ps2_word(7) XOR ps2_word(6) XOR ps2_word(5) XOR ps2_word(4) XOR ps2_word(3) XOR 
        ps2_word(2) XOR ps2_word(1)));  

  --determine if PS2 port is idle (i.e. last transaction is finished) and output result
  PROCESS(clk)
  BEGIN
    IF(clk'EVENT AND clk = '1') THEN           --rising edge of system clock
    
      IF(ps2_clk_int = '0') THEN                 --low PS2 clock, PS/2 is active
        count_idle <= 0;                           --reset idle counter
      ELSIF(count_idle /= clk_freq/18_000) THEN  --PS2 clock has been high less than a half clock period (<55us)
          count_idle <= count_idle + 1;            --continue counting
      END IF;
      
      IF(count_idle = clk_freq/18_000 AND error = '0') THEN  --idle threshold reached and no errors detected
        ps2_code_new <= '1';                                   --set flag that new PS/2 code is available
        ps2_code <= ps2_word(8 DOWNTO 1);                      --output new PS/2 code
      ELSE                                                   --PS/2 port active or error detected
        ps2_code_new <= '0';                                   --set flag that PS/2 transaction is in progress
      END IF;
      
    END IF;
  END PROCESS;
  
  Process(clk)
  begin
 IF (ps2_code_new' event) and (ps2_code_new = '1') then
  case current_state is
  -------------------Function Set-------------------
  when S0 =>
				current_state <= S1;
				
				LCD_DATA		<= "00110000";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';

			 when S1 =>
				current_state <= S2;

				LCD_DATA		<= "00110000";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S2 =>
				current_state <= S3;

				LCD_DATA		<= "00110000";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';

-------------------Reset Display-------------------				
			 when S3 =>
				current_state <= S4;

				LCD_DATA		<= "00000001";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S4 =>
				current_state <= S5;

				LCD_DATA		<= "00000001";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';	
				
			 when S5 =>
				current_state <= S6;				
				
				LCD_DATA		<= "00000001";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';

-------------------Display On-------------------				
			 when S6 =>
				current_state <= S7;					

				LCD_DATA		<= "00111100";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S7 =>
				current_state <= S8;
	
				LCD_DATA		<= "00111100";
				
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			 when S8 =>
				current_state <= S9;	

				LCD_DATA		<= "00111100";
				
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write '0'-------------------				
			when s9 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S10;
				end if;
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S10 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			   current_state <= S11;
				end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write ' '-------------------				
			when s11 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			current_state <= S12;
			end if;
			if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S12 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			   current_state <= S13;
				end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s13 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S14;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

 
			when S14 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			   current_state <= S15;
				end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write '1'-------------------				
			when s15 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S16;	
		end if;		
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

 
			when S16 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			   current_state <= S17;
				end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s17 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S18;	
		end if;		
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

 
			when S18 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			   current_state <= S19;
				end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s19 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S20;	
		end if;		
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S20 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			   current_state <= S21;
				end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write '2'-------------------				
			when s21 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S22;	
		end if;		
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S22 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
			   current_state <= S23;
				end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s23 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S24;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S24 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S25;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s25 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S26;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

 
			when S26 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S27;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write '3'-------------------				
			when s27=>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S28;
	end if;
	end if;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

 
			when S28 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S29;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s29 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S30;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

 
			when S30 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S31;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s31 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S32;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';

 
			when S32 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S33;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write '4'-------------------				
			when s33 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S34;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S34 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S35;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';

-------------------Write ' '-------------------				
			when s35 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S36;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			when S36 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S37;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write ' '-------------------				
			when s37 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S38;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
				
			when S38 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S39;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write '5'-------------------				
			when s39 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S40;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S40 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S41;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write ' '-------------------				
			when s41 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S42;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S42 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S43;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s43 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S44;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S44 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S45;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write '6'-------------------				
			when s45 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S46;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S46 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S47;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s47 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S48;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S48 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S49;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s49 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S50;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S50 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S51;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write '7'-------------------				
			when s51 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S52;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S52 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S53;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';					
-------------------Write ' '-------------------				
			when s53 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S54;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S54 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S55;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s55 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S56;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S56 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S57;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write '8'-------------------				
			when s57 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S58;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S58 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S59;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
-------------------Write ' '-------------------				
			when s59 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S60;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S60 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S61;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s61 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S62;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S62 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S63;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
-------------------Write '9'-------------------				
			when s63 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S64;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S64 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S65;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
-------------------Write ' '-------------------				
			when s65 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S66;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S66 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S67;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s67 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S68;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S68 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S69;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write '7'-------------------				
			when s69 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S70;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S70 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S71;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
-------------------Write ' '-------------------				
			when s71 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S72;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S72 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S73;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s73 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S74;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S74 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S75;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write '7'-------------------				
			when s75 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S76;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S76 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S77;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
-------------------Write ' '-------------------				
			when s77 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S78;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S78 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S79;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s79 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S80;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S80 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S81;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write '7'-------------------				
			when s81 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S82;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S82 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S83;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
-------------------Write ' '-------------------				
			when s83 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S84;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S84 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S85;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s85 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S86;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S86 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S87;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
-------------------Write '7'-------------------				
			when s87 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S88;
	end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '1';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';
 
			when S88 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S89;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';	
-------------------Write ' '-------------------				
			when s89 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S90;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
 
			when S90 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S91;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';			
-------------------Write ' '-------------------				
			when s91 =>
				if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S92;
			end if;			
				if ps2_code(7 downto 0)="01110000" then			
				LCD_DATA		<= X"30";
				elsif ps2_code(7 downto 0)="01101001" then
				LCD_DATA		<= X"31";
				elsif ps2_code(7 downto 0)="01110010" then
				LCD_DATA		<= X"32";
				elsif ps2_code(7 downto 0)="01111010" then
				LCD_DATA		<= X"33";
				elsif ps2_code(7 downto 0)="01101011" then
				LCD_DATA		<= X"34";
				elsif ps2_code(7 downto 0)="01110011" then
				LCD_DATA		<= X"35";
				elsif ps2_code(7 downto 0)="01110100" then
				LCD_DATA		<= X"36";
				elsif ps2_code(7 downto 0)="01101100" then
				LCD_DATA		<= X"37";
				elsif ps2_code(7 downto 0)="01110101" then
				LCD_DATA		<= X"38";
				elsif ps2_code(7 downto 0)="01111101" then
				LCD_DATA		<= X"39";
				elsif ps2_code(7 downto 0)="01111001" then
				LCD_DATA		<= X"2B";
				elsif ps2_code(7 downto 0)="01111011" then
				LCD_DATA		<= X"2D";
				elsif ps2_code(7 downto 0)="01111100" then
				LCD_DATA		<= X"2A";
				elsif ps2_code(7 downto 0)="01001010" then
				LCD_DATA		<= X"2F";
				elsif ps2_code(7 downto 0)="01010101" then
				LCD_DATA		<= X"3D";
				elsif ps2_code(7 downto 0)="00110100" then
				LCD_DATA		<= X"47";
				elsE
				LCD_DATA		<= X"10";
				end if;
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '0';
-------------------Write 'fIANL'-------------------	 
			when S92 =>
			   if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= S93;
	end if;
				LCD_DATA<= X"00";
				LCD_ENABLE	<= '0';
				LCD_RW 		<= '0';
				LCD_RS		<= '1';				
		
		
		
		
			when S93 =>
			if ps2_code(7 downto 0)="01100110" then
				current_state <= S4;
				else
				current_state <= IDLE;				
				end if;
			 when IDLE	=>
				current_state <= s4;
				
		    when others =>
				current_state <= S4;
end case;	

	END IF;
	
END PROCESS;
  
  
  
END logic;
