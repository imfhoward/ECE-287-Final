-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Web Edition"

-- DATE "12/06/2017 03:07:07"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Keyboard IS
    PORT (
	clk : IN std_logic;
	ps2_clk : IN std_logic;
	ps2_data : IN std_logic;
	ps2_code_new : INOUT std_logic;
	ps2_code : INOUT std_logic_vector(7 DOWNTO 0);
	LCD_ENABLE : OUT std_logic;
	LCD_RW : OUT std_logic;
	LCD_RS : OUT std_logic;
	LCD_DATA : OUT std_logic_vector(7 DOWNTO 0)
	);
END Keyboard;

-- Design Ports Information
-- LCD_ENABLE	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_RW	=>  Location: PIN_M1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_RS	=>  Location: PIN_M2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[0]	=>  Location: PIN_L3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[1]	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[2]	=>  Location: PIN_L2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[3]	=>  Location: PIN_K7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[4]	=>  Location: PIN_K1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[5]	=>  Location: PIN_K2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[6]	=>  Location: PIN_M3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LCD_DATA[7]	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code_new	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[0]	=>  Location: PIN_E21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[1]	=>  Location: PIN_E22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[2]	=>  Location: PIN_E25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[3]	=>  Location: PIN_E24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[4]	=>  Location: PIN_H21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[5]	=>  Location: PIN_G20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[6]	=>  Location: PIN_G22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_code[7]	=>  Location: PIN_G21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_Y2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_clk	=>  Location: PIN_G6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ps2_data	=>  Location: PIN_H5,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Keyboard IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_ps2_clk : std_logic;
SIGNAL ww_ps2_data : std_logic;
SIGNAL ww_LCD_ENABLE : std_logic;
SIGNAL ww_LCD_RW : std_logic;
SIGNAL ww_LCD_RS : std_logic;
SIGNAL ww_LCD_DATA : std_logic_vector(7 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ps2_code_new~reg0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \debounce_ps2_clk|result~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ps2_code_new~input_o\ : std_logic;
SIGNAL \ps2_code[0]~input_o\ : std_logic;
SIGNAL \ps2_code[1]~input_o\ : std_logic;
SIGNAL \ps2_code[2]~input_o\ : std_logic;
SIGNAL \ps2_code[3]~input_o\ : std_logic;
SIGNAL \ps2_code[4]~input_o\ : std_logic;
SIGNAL \ps2_code[5]~input_o\ : std_logic;
SIGNAL \ps2_code[6]~input_o\ : std_logic;
SIGNAL \ps2_code[7]~input_o\ : std_logic;
SIGNAL \ps2_code_new~output_o\ : std_logic;
SIGNAL \ps2_code[0]~output_o\ : std_logic;
SIGNAL \ps2_code[1]~output_o\ : std_logic;
SIGNAL \ps2_code[2]~output_o\ : std_logic;
SIGNAL \ps2_code[3]~output_o\ : std_logic;
SIGNAL \ps2_code[4]~output_o\ : std_logic;
SIGNAL \ps2_code[5]~output_o\ : std_logic;
SIGNAL \ps2_code[6]~output_o\ : std_logic;
SIGNAL \ps2_code[7]~output_o\ : std_logic;
SIGNAL \LCD_ENABLE~output_o\ : std_logic;
SIGNAL \LCD_RW~output_o\ : std_logic;
SIGNAL \LCD_RS~output_o\ : std_logic;
SIGNAL \LCD_DATA[0]~output_o\ : std_logic;
SIGNAL \LCD_DATA[1]~output_o\ : std_logic;
SIGNAL \LCD_DATA[2]~output_o\ : std_logic;
SIGNAL \LCD_DATA[3]~output_o\ : std_logic;
SIGNAL \LCD_DATA[4]~output_o\ : std_logic;
SIGNAL \LCD_DATA[5]~output_o\ : std_logic;
SIGNAL \LCD_DATA[6]~output_o\ : std_logic;
SIGNAL \LCD_DATA[7]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \count_idle[0]~12_combout\ : std_logic;
SIGNAL \ps2_clk~input_o\ : std_logic;
SIGNAL \debounce_ps2_clk|result~1_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[0]~1_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~0_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[0]~9_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~1\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~2_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[1]~8_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~3\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~4_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[2]~7_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~5\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~6_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[3]~6_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~7\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~8_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[4]~5_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~9\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~10_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[5]~4_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~11\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~12_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[6]~3_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~13\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~14_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out[7]~2_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~15\ : std_logic;
SIGNAL \debounce_ps2_clk|Add0~16_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|counter_out~0_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|result~0_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|result~feeder_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|result~q\ : std_logic;
SIGNAL \count_idle[3]~20\ : std_logic;
SIGNAL \count_idle[4]~21_combout\ : std_logic;
SIGNAL \count_idle[4]~22\ : std_logic;
SIGNAL \count_idle[5]~23_combout\ : std_logic;
SIGNAL \count_idle[5]~24\ : std_logic;
SIGNAL \count_idle[6]~25_combout\ : std_logic;
SIGNAL \count_idle[6]~26\ : std_logic;
SIGNAL \count_idle[7]~27_combout\ : std_logic;
SIGNAL \count_idle[7]~28\ : std_logic;
SIGNAL \count_idle[8]~29_combout\ : std_logic;
SIGNAL \count_idle[8]~30\ : std_logic;
SIGNAL \count_idle[9]~31_combout\ : std_logic;
SIGNAL \count_idle[9]~32\ : std_logic;
SIGNAL \count_idle[10]~33_combout\ : std_logic;
SIGNAL \count_idle[10]~34\ : std_logic;
SIGNAL \count_idle[11]~35_combout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \count_idle[4]~14_combout\ : std_logic;
SIGNAL \count_idle[0]~13\ : std_logic;
SIGNAL \count_idle[1]~15_combout\ : std_logic;
SIGNAL \count_idle[1]~16\ : std_logic;
SIGNAL \count_idle[2]~17_combout\ : std_logic;
SIGNAL \count_idle[2]~18\ : std_logic;
SIGNAL \count_idle[3]~19_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \debounce_ps2_clk|result~clkctrl_outclk\ : std_logic;
SIGNAL \ps2_data~input_o\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[0]~1_combout\ : std_logic;
SIGNAL \debounce_ps2_data|result~1_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~0_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[0]~9_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~1\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~2_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[1]~8_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~3\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~4_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[2]~7_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~5\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~6_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[3]~6_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~7\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~8_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[4]~5_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~9\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~10_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[5]~4_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~11\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~12_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[6]~3_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~13\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~14_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out[7]~2_combout\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~15\ : std_logic;
SIGNAL \debounce_ps2_data|Add0~16_combout\ : std_logic;
SIGNAL \debounce_ps2_data|counter_out~0_combout\ : std_logic;
SIGNAL \debounce_ps2_data|result~0_combout\ : std_logic;
SIGNAL \debounce_ps2_data|result~q\ : std_logic;
SIGNAL \ps2_word[10]~feeder_combout\ : std_logic;
SIGNAL \ps2_word[8]~feeder_combout\ : std_logic;
SIGNAL \ps2_word[7]~feeder_combout\ : std_logic;
SIGNAL \ps2_word[6]~feeder_combout\ : std_logic;
SIGNAL \ps2_word[4]~feeder_combout\ : std_logic;
SIGNAL \ps2_word[3]~feeder_combout\ : std_logic;
SIGNAL \ps2_word[2]~feeder_combout\ : std_logic;
SIGNAL \error~1_combout\ : std_logic;
SIGNAL \error~0_combout\ : std_logic;
SIGNAL \process_2~2_combout\ : std_logic;
SIGNAL \process_2~3_combout\ : std_logic;
SIGNAL \process_2~4_combout\ : std_logic;
SIGNAL \ps2_code_new~reg0_q\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \ps2_code~17_combout\ : std_logic;
SIGNAL \ps2_code[0]~reg0_q\ : std_logic;
SIGNAL \ps2_code~19_combout\ : std_logic;
SIGNAL \ps2_code[1]~reg0_q\ : std_logic;
SIGNAL \ps2_code~23_combout\ : std_logic;
SIGNAL \ps2_code[2]~reg0_q\ : std_logic;
SIGNAL \ps2_code~16_combout\ : std_logic;
SIGNAL \ps2_code[3]~reg0_q\ : std_logic;
SIGNAL \ps2_code~22_combout\ : std_logic;
SIGNAL \ps2_code[4]~reg0_q\ : std_logic;
SIGNAL \ps2_code~18_combout\ : std_logic;
SIGNAL \ps2_code[5]~reg0_q\ : std_logic;
SIGNAL \ps2_code~20_combout\ : std_logic;
SIGNAL \ps2_code[6]~reg0_q\ : std_logic;
SIGNAL \ps2_code~21_combout\ : std_logic;
SIGNAL \ps2_code[7]~reg0_q\ : std_logic;
SIGNAL \ps2_code_new~reg0clkctrl_outclk\ : std_logic;
SIGNAL \Equal8~0_combout\ : std_logic;
SIGNAL \Equal4~0_combout\ : std_logic;
SIGNAL \current_state~182_combout\ : std_logic;
SIGNAL \current_state.S88~q\ : std_logic;
SIGNAL \current_state~133_combout\ : std_logic;
SIGNAL \current_state.S89~q\ : std_logic;
SIGNAL \current_state~183_combout\ : std_logic;
SIGNAL \current_state.S90~q\ : std_logic;
SIGNAL \current_state~134_combout\ : std_logic;
SIGNAL \current_state.S91~q\ : std_logic;
SIGNAL \current_state~142_combout\ : std_logic;
SIGNAL \current_state.S92~q\ : std_logic;
SIGNAL \current_state~99_combout\ : std_logic;
SIGNAL \current_state.S93~q\ : std_logic;
SIGNAL \current_state~100_combout\ : std_logic;
SIGNAL \current_state.IDLE~q\ : std_logic;
SIGNAL \current_state.S0~feeder_combout\ : std_logic;
SIGNAL \current_state.S0~q\ : std_logic;
SIGNAL \current_state.S1~0_combout\ : std_logic;
SIGNAL \current_state.S1~q\ : std_logic;
SIGNAL \current_state.S2~q\ : std_logic;
SIGNAL \current_state.S3~q\ : std_logic;
SIGNAL \Selector0~11_combout\ : std_logic;
SIGNAL \Selector0~12_combout\ : std_logic;
SIGNAL \Selector0~10_combout\ : std_logic;
SIGNAL \Selector0~3_combout\ : std_logic;
SIGNAL \Selector0~2_combout\ : std_logic;
SIGNAL \Selector0~1_combout\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \Selector0~4_combout\ : std_logic;
SIGNAL \Selector0~6_combout\ : std_logic;
SIGNAL \Selector0~5_combout\ : std_logic;
SIGNAL \Selector0~7_combout\ : std_logic;
SIGNAL \Selector0~8_combout\ : std_logic;
SIGNAL \Selector0~9_combout\ : std_logic;
SIGNAL \Selector0~13_combout\ : std_logic;
SIGNAL \Selector7~5_combout\ : std_logic;
SIGNAL \Selector7~6_combout\ : std_logic;
SIGNAL \Selector7~3_combout\ : std_logic;
SIGNAL \Selector7~1_combout\ : std_logic;
SIGNAL \Selector7~2_combout\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \Selector7~4_combout\ : std_logic;
SIGNAL \Selector7~8_combout\ : std_logic;
SIGNAL \Selector7~9_combout\ : std_logic;
SIGNAL \Selector7~10_combout\ : std_logic;
SIGNAL \Selector0~14_combout\ : std_logic;
SIGNAL \Selector0~15_combout\ : std_logic;
SIGNAL \current_state.S4~q\ : std_logic;
SIGNAL \current_state.S5~q\ : std_logic;
SIGNAL \current_state.S6~q\ : std_logic;
SIGNAL \current_state.S7~q\ : std_logic;
SIGNAL \current_state.S8~q\ : std_logic;
SIGNAL \current_state.S9~q\ : std_logic;
SIGNAL \current_state~156_combout\ : std_logic;
SIGNAL \current_state.S10~q\ : std_logic;
SIGNAL \current_state~135_combout\ : std_logic;
SIGNAL \current_state.S11~q\ : std_logic;
SIGNAL \current_state~157_combout\ : std_logic;
SIGNAL \current_state.S12~q\ : std_logic;
SIGNAL \current_state~136_combout\ : std_logic;
SIGNAL \current_state.S13~q\ : std_logic;
SIGNAL \current_state~143_combout\ : std_logic;
SIGNAL \current_state.S14~q\ : std_logic;
SIGNAL \current_state~101_combout\ : std_logic;
SIGNAL \current_state.S15~q\ : std_logic;
SIGNAL \current_state~158_combout\ : std_logic;
SIGNAL \current_state.S16~q\ : std_logic;
SIGNAL \current_state~137_combout\ : std_logic;
SIGNAL \current_state.S17~q\ : std_logic;
SIGNAL \current_state~159_combout\ : std_logic;
SIGNAL \current_state.S18~q\ : std_logic;
SIGNAL \current_state~138_combout\ : std_logic;
SIGNAL \current_state.S19~q\ : std_logic;
SIGNAL \current_state~144_combout\ : std_logic;
SIGNAL \current_state.S20~q\ : std_logic;
SIGNAL \current_state~102_combout\ : std_logic;
SIGNAL \current_state.S21~q\ : std_logic;
SIGNAL \current_state~160_combout\ : std_logic;
SIGNAL \current_state.S22~q\ : std_logic;
SIGNAL \current_state~139_combout\ : std_logic;
SIGNAL \current_state.S23~q\ : std_logic;
SIGNAL \current_state~161_combout\ : std_logic;
SIGNAL \current_state.S24~q\ : std_logic;
SIGNAL \current_state~140_combout\ : std_logic;
SIGNAL \current_state.S25~q\ : std_logic;
SIGNAL \current_state~145_combout\ : std_logic;
SIGNAL \current_state.S26~q\ : std_logic;
SIGNAL \current_state~103_combout\ : std_logic;
SIGNAL \current_state.S27~q\ : std_logic;
SIGNAL \current_state~162_combout\ : std_logic;
SIGNAL \current_state.S28~q\ : std_logic;
SIGNAL \current_state~141_combout\ : std_logic;
SIGNAL \current_state.S29~q\ : std_logic;
SIGNAL \current_state~163_combout\ : std_logic;
SIGNAL \current_state.S30~q\ : std_logic;
SIGNAL \current_state~114_combout\ : std_logic;
SIGNAL \current_state.S31~q\ : std_logic;
SIGNAL \current_state~146_combout\ : std_logic;
SIGNAL \current_state.S32~q\ : std_logic;
SIGNAL \current_state~104_combout\ : std_logic;
SIGNAL \current_state.S33~q\ : std_logic;
SIGNAL \current_state~164_combout\ : std_logic;
SIGNAL \current_state.S34~q\ : std_logic;
SIGNAL \current_state~115_combout\ : std_logic;
SIGNAL \current_state.S35~q\ : std_logic;
SIGNAL \current_state~165_combout\ : std_logic;
SIGNAL \current_state.S36~q\ : std_logic;
SIGNAL \current_state~116_combout\ : std_logic;
SIGNAL \current_state.S37~q\ : std_logic;
SIGNAL \current_state~147_combout\ : std_logic;
SIGNAL \current_state.S38~q\ : std_logic;
SIGNAL \current_state~105_combout\ : std_logic;
SIGNAL \current_state.S39~q\ : std_logic;
SIGNAL \current_state~166_combout\ : std_logic;
SIGNAL \current_state.S40~q\ : std_logic;
SIGNAL \current_state~117_combout\ : std_logic;
SIGNAL \current_state.S41~q\ : std_logic;
SIGNAL \current_state~167_combout\ : std_logic;
SIGNAL \current_state.S42~q\ : std_logic;
SIGNAL \current_state~118_combout\ : std_logic;
SIGNAL \current_state.S43~q\ : std_logic;
SIGNAL \current_state~148_combout\ : std_logic;
SIGNAL \current_state.S44~q\ : std_logic;
SIGNAL \current_state~106_combout\ : std_logic;
SIGNAL \current_state.S45~q\ : std_logic;
SIGNAL \current_state~168_combout\ : std_logic;
SIGNAL \current_state.S46~q\ : std_logic;
SIGNAL \current_state~119_combout\ : std_logic;
SIGNAL \current_state.S47~q\ : std_logic;
SIGNAL \current_state~169_combout\ : std_logic;
SIGNAL \current_state.S48~q\ : std_logic;
SIGNAL \current_state~120_combout\ : std_logic;
SIGNAL \current_state.S49~q\ : std_logic;
SIGNAL \current_state~149_combout\ : std_logic;
SIGNAL \current_state.S50~q\ : std_logic;
SIGNAL \current_state~107_combout\ : std_logic;
SIGNAL \current_state.S51~q\ : std_logic;
SIGNAL \current_state~170_combout\ : std_logic;
SIGNAL \current_state.S52~q\ : std_logic;
SIGNAL \current_state~121_combout\ : std_logic;
SIGNAL \current_state.S53~q\ : std_logic;
SIGNAL \current_state~171_combout\ : std_logic;
SIGNAL \current_state.S54~q\ : std_logic;
SIGNAL \current_state~122_combout\ : std_logic;
SIGNAL \current_state.S55~q\ : std_logic;
SIGNAL \current_state~150_combout\ : std_logic;
SIGNAL \current_state.S56~q\ : std_logic;
SIGNAL \current_state~108_combout\ : std_logic;
SIGNAL \current_state.S57~q\ : std_logic;
SIGNAL \current_state~172_combout\ : std_logic;
SIGNAL \current_state.S58~q\ : std_logic;
SIGNAL \current_state~123_combout\ : std_logic;
SIGNAL \current_state.S59~q\ : std_logic;
SIGNAL \current_state~173_combout\ : std_logic;
SIGNAL \current_state.S60~q\ : std_logic;
SIGNAL \current_state~124_combout\ : std_logic;
SIGNAL \current_state.S61~q\ : std_logic;
SIGNAL \current_state~151_combout\ : std_logic;
SIGNAL \current_state.S62~q\ : std_logic;
SIGNAL \current_state~109_combout\ : std_logic;
SIGNAL \current_state.S63~q\ : std_logic;
SIGNAL \current_state~174_combout\ : std_logic;
SIGNAL \current_state.S64~q\ : std_logic;
SIGNAL \current_state~125_combout\ : std_logic;
SIGNAL \current_state.S65~q\ : std_logic;
SIGNAL \current_state~175_combout\ : std_logic;
SIGNAL \current_state.S66~q\ : std_logic;
SIGNAL \current_state~126_combout\ : std_logic;
SIGNAL \current_state.S67~q\ : std_logic;
SIGNAL \current_state~152_combout\ : std_logic;
SIGNAL \current_state.S68~q\ : std_logic;
SIGNAL \current_state~110_combout\ : std_logic;
SIGNAL \current_state.S69~q\ : std_logic;
SIGNAL \current_state~176_combout\ : std_logic;
SIGNAL \current_state.S70~q\ : std_logic;
SIGNAL \current_state~127_combout\ : std_logic;
SIGNAL \current_state.S71~q\ : std_logic;
SIGNAL \current_state~177_combout\ : std_logic;
SIGNAL \current_state.S72~q\ : std_logic;
SIGNAL \current_state~128_combout\ : std_logic;
SIGNAL \current_state.S73~q\ : std_logic;
SIGNAL \current_state~153_combout\ : std_logic;
SIGNAL \current_state.S74~q\ : std_logic;
SIGNAL \current_state~111_combout\ : std_logic;
SIGNAL \current_state.S75~q\ : std_logic;
SIGNAL \current_state~178_combout\ : std_logic;
SIGNAL \current_state.S76~q\ : std_logic;
SIGNAL \current_state~129_combout\ : std_logic;
SIGNAL \current_state.S77~q\ : std_logic;
SIGNAL \current_state~179_combout\ : std_logic;
SIGNAL \current_state.S78~q\ : std_logic;
SIGNAL \current_state~130_combout\ : std_logic;
SIGNAL \current_state.S79~q\ : std_logic;
SIGNAL \current_state~154_combout\ : std_logic;
SIGNAL \current_state.S80~q\ : std_logic;
SIGNAL \current_state~112_combout\ : std_logic;
SIGNAL \current_state.S81~q\ : std_logic;
SIGNAL \current_state~180_combout\ : std_logic;
SIGNAL \current_state.S82~q\ : std_logic;
SIGNAL \current_state~131_combout\ : std_logic;
SIGNAL \current_state.S83~q\ : std_logic;
SIGNAL \current_state~181_combout\ : std_logic;
SIGNAL \current_state.S84~q\ : std_logic;
SIGNAL \current_state~132_combout\ : std_logic;
SIGNAL \current_state.S85~q\ : std_logic;
SIGNAL \current_state~155_combout\ : std_logic;
SIGNAL \current_state.S86~q\ : std_logic;
SIGNAL \current_state~113_combout\ : std_logic;
SIGNAL \current_state.S87~q\ : std_logic;
SIGNAL \Selector8~4_combout\ : std_logic;
SIGNAL \Selector8~1_combout\ : std_logic;
SIGNAL \Selector8~3_combout\ : std_logic;
SIGNAL \Selector8~2_combout\ : std_logic;
SIGNAL \Selector8~5_combout\ : std_logic;
SIGNAL \WideOr11~0_combout\ : std_logic;
SIGNAL \Selector8~0_combout\ : std_logic;
SIGNAL \Selector8~6_combout\ : std_logic;
SIGNAL \LCD_ENABLE~reg0_q\ : std_logic;
SIGNAL \WideOr11~2_combout\ : std_logic;
SIGNAL \WideOr11~1_combout\ : std_logic;
SIGNAL \WideOr11~3_combout\ : std_logic;
SIGNAL \WideOr11~4_combout\ : std_logic;
SIGNAL \Selector9~2_combout\ : std_logic;
SIGNAL \LCD_RS~reg0_q\ : std_logic;
SIGNAL \WideOr11~5_combout\ : std_logic;
SIGNAL \Selector7~7_combout\ : std_logic;
SIGNAL \Equal2~0_combout\ : std_logic;
SIGNAL \Equal4~1_combout\ : std_logic;
SIGNAL \Equal13~0_combout\ : std_logic;
SIGNAL \Equal17~0_combout\ : std_logic;
SIGNAL \Equal17~1_combout\ : std_logic;
SIGNAL \Equal15~1_combout\ : std_logic;
SIGNAL \Equal15~0_combout\ : std_logic;
SIGNAL \Equal15~2_combout\ : std_logic;
SIGNAL \Equal16~0_combout\ : std_logic;
SIGNAL \Equal16~1_combout\ : std_logic;
SIGNAL \Equal16~2_combout\ : std_logic;
SIGNAL \LCD_DATA~0_combout\ : std_logic;
SIGNAL \LCD_DATA~3_combout\ : std_logic;
SIGNAL \LCD_DATA~1_combout\ : std_logic;
SIGNAL \LCD_DATA~15_combout\ : std_logic;
SIGNAL \LCD_DATA~2_combout\ : std_logic;
SIGNAL \LCD_DATA~4_combout\ : std_logic;
SIGNAL \Selector7~11_combout\ : std_logic;
SIGNAL \LCD_DATA[0]~reg0_q\ : std_logic;
SIGNAL \LCD_DATA~6_combout\ : std_logic;
SIGNAL \LCD_DATA~5_combout\ : std_logic;
SIGNAL \LCD_DATA~7_combout\ : std_logic;
SIGNAL \LCD_DATA~8_combout\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \LCD_DATA[1]~reg0_q\ : std_logic;
SIGNAL \Selector5~15_combout\ : std_logic;
SIGNAL \Selector5~18_combout\ : std_logic;
SIGNAL \Selector5~19_combout\ : std_logic;
SIGNAL \Selector5~17_combout\ : std_logic;
SIGNAL \Selector5~13_combout\ : std_logic;
SIGNAL \Selector5~11_combout\ : std_logic;
SIGNAL \Selector5~12_combout\ : std_logic;
SIGNAL \Selector5~14_combout\ : std_logic;
SIGNAL \Selector5~16_combout\ : std_logic;
SIGNAL \LCD_DATA[2]~reg0_q\ : std_logic;
SIGNAL \Selector4~9_combout\ : std_logic;
SIGNAL \Selector4~10_combout\ : std_logic;
SIGNAL \Selector4~8_combout\ : std_logic;
SIGNAL \Selector4~17_combout\ : std_logic;
SIGNAL \Selector4~16_combout\ : std_logic;
SIGNAL \Equal2~1_combout\ : std_logic;
SIGNAL \LCD_DATA~9_combout\ : std_logic;
SIGNAL \LCD_DATA~10_combout\ : std_logic;
SIGNAL \Selector4~15_combout\ : std_logic;
SIGNAL \LCD_DATA[3]~reg0_q\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \LCD_DATA~13_combout\ : std_logic;
SIGNAL \LCD_DATA~11_combout\ : std_logic;
SIGNAL \LCD_DATA~12_combout\ : std_logic;
SIGNAL \LCD_DATA~14_combout\ : std_logic;
SIGNAL \Selector3~1_combout\ : std_logic;
SIGNAL \LCD_DATA[4]~reg0_q\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \Selector2~1_combout\ : std_logic;
SIGNAL \LCD_DATA[5]~reg0_q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \LCD_DATA[6]~reg0_q\ : std_logic;
SIGNAL sync_ffs : std_logic_vector(1 DOWNTO 0);
SIGNAL ps2_word : std_logic_vector(10 DOWNTO 0);
SIGNAL count_idle : std_logic_vector(11 DOWNTO 0);
SIGNAL \debounce_ps2_clk|flipflops\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \debounce_ps2_clk|counter_out\ : std_logic_vector(8 DOWNTO 0);
SIGNAL \debounce_ps2_data|counter_out\ : std_logic_vector(8 DOWNTO 0);
SIGNAL \debounce_ps2_data|flipflops\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\ : std_logic;
SIGNAL \debounce_ps2_clk|ALT_INV_result~q\ : std_logic;

BEGIN

ww_clk <= clk;
ww_ps2_clk <= ps2_clk;
ww_ps2_data <= ps2_data;
LCD_ENABLE <= ww_LCD_ENABLE;
LCD_RW <= ww_LCD_RW;
LCD_RS <= ww_LCD_RS;
LCD_DATA <= ww_LCD_DATA;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

\ps2_code_new~reg0clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \ps2_code_new~reg0_q\);

\debounce_ps2_clk|result~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \debounce_ps2_clk|result~q\);
\debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\ <= NOT \debounce_ps2_clk|result~clkctrl_outclk\;
\debounce_ps2_clk|ALT_INV_result~q\ <= NOT \debounce_ps2_clk|result~q\;

-- Location: IOOBUF_X58_Y73_N16
\ps2_code_new~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code_new~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code_new~output_o\);

-- Location: IOOBUF_X107_Y73_N9
\ps2_code[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[0]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[0]~output_o\);

-- Location: IOOBUF_X111_Y73_N9
\ps2_code[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[1]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[1]~output_o\);

-- Location: IOOBUF_X83_Y73_N2
\ps2_code[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[2]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[2]~output_o\);

-- Location: IOOBUF_X85_Y73_N23
\ps2_code[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[3]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[3]~output_o\);

-- Location: IOOBUF_X72_Y73_N16
\ps2_code[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[4]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[4]~output_o\);

-- Location: IOOBUF_X74_Y73_N16
\ps2_code[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[5]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[5]~output_o\);

-- Location: IOOBUF_X72_Y73_N23
\ps2_code[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[6]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[6]~output_o\);

-- Location: IOOBUF_X74_Y73_N23
\ps2_code[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ps2_code[7]~reg0_q\,
	oe => VCC,
	devoe => ww_devoe,
	o => \ps2_code[7]~output_o\);

-- Location: IOOBUF_X0_Y52_N2
\LCD_ENABLE~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_ENABLE~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_ENABLE~output_o\);

-- Location: IOOBUF_X0_Y44_N23
\LCD_RW~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LCD_RW~output_o\);

-- Location: IOOBUF_X0_Y44_N16
\LCD_RS~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_RS~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_RS~output_o\);

-- Location: IOOBUF_X0_Y52_N16
\LCD_DATA[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_DATA[0]~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_DATA[0]~output_o\);

-- Location: IOOBUF_X0_Y44_N9
\LCD_DATA[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_DATA[1]~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_DATA[1]~output_o\);

-- Location: IOOBUF_X0_Y44_N2
\LCD_DATA[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_DATA[2]~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_DATA[2]~output_o\);

-- Location: IOOBUF_X0_Y49_N9
\LCD_DATA[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_DATA[3]~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_DATA[3]~output_o\);

-- Location: IOOBUF_X0_Y54_N9
\LCD_DATA[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_DATA[4]~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_DATA[4]~output_o\);

-- Location: IOOBUF_X0_Y55_N23
\LCD_DATA[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_DATA[5]~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_DATA[5]~output_o\);

-- Location: IOOBUF_X0_Y51_N16
\LCD_DATA[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \LCD_DATA[6]~reg0_q\,
	devoe => ww_devoe,
	o => \LCD_DATA[6]~output_o\);

-- Location: IOOBUF_X0_Y47_N2
\LCD_DATA[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \LCD_DATA[7]~output_o\);

-- Location: IOIBUF_X0_Y36_N15
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G4
\clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: LCCOMB_X65_Y71_N4
\count_idle[0]~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[0]~12_combout\ = count_idle(0) $ (VCC)
-- \count_idle[0]~13\ = CARRY(count_idle(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => count_idle(0),
	datad => VCC,
	combout => \count_idle[0]~12_combout\,
	cout => \count_idle[0]~13\);

-- Location: IOIBUF_X0_Y67_N15
\ps2_clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ps2_clk,
	o => \ps2_clk~input_o\);

-- Location: FF_X54_Y70_N13
\sync_ffs[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \ps2_clk~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => sync_ffs(0));

-- Location: FF_X55_Y70_N31
\debounce_ps2_clk|flipflops[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => sync_ffs(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|flipflops\(0));

-- Location: FF_X55_Y70_N25
\debounce_ps2_clk|flipflops[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \debounce_ps2_clk|flipflops\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|flipflops\(1));

-- Location: LCCOMB_X55_Y70_N30
\debounce_ps2_clk|result~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|result~1_combout\ = (\debounce_ps2_clk|counter_out\(8) & (\debounce_ps2_clk|flipflops\(0) $ (!\debounce_ps2_clk|flipflops\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_clk|counter_out\(8),
	datac => \debounce_ps2_clk|flipflops\(0),
	datad => \debounce_ps2_clk|flipflops\(1),
	combout => \debounce_ps2_clk|result~1_combout\);

-- Location: LCCOMB_X55_Y70_N24
\debounce_ps2_clk|counter_out[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[0]~1_combout\ = (!\debounce_ps2_clk|counter_out\(8) & (\debounce_ps2_clk|flipflops\(0) $ (!\debounce_ps2_clk|flipflops\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000100100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|flipflops\(0),
	datab => \debounce_ps2_clk|counter_out\(8),
	datac => \debounce_ps2_clk|flipflops\(1),
	combout => \debounce_ps2_clk|counter_out[0]~1_combout\);

-- Location: LCCOMB_X54_Y70_N6
\debounce_ps2_clk|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~0_combout\ = \debounce_ps2_clk|counter_out\(0) $ (VCC)
-- \debounce_ps2_clk|Add0~1\ = CARRY(\debounce_ps2_clk|counter_out\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|counter_out\(0),
	datad => VCC,
	combout => \debounce_ps2_clk|Add0~0_combout\,
	cout => \debounce_ps2_clk|Add0~1\);

-- Location: LCCOMB_X54_Y70_N26
\debounce_ps2_clk|counter_out[0]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[0]~9_combout\ = (\debounce_ps2_clk|result~1_combout\ & ((\debounce_ps2_clk|counter_out\(0)) # ((\debounce_ps2_clk|counter_out[0]~1_combout\ & \debounce_ps2_clk|Add0~0_combout\)))) # (!\debounce_ps2_clk|result~1_combout\ & 
-- (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~1_combout\,
	datab => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(0),
	datad => \debounce_ps2_clk|Add0~0_combout\,
	combout => \debounce_ps2_clk|counter_out[0]~9_combout\);

-- Location: FF_X54_Y70_N27
\debounce_ps2_clk|counter_out[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(0));

-- Location: LCCOMB_X54_Y70_N8
\debounce_ps2_clk|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~2_combout\ = (\debounce_ps2_clk|counter_out\(1) & (!\debounce_ps2_clk|Add0~1\)) # (!\debounce_ps2_clk|counter_out\(1) & ((\debounce_ps2_clk|Add0~1\) # (GND)))
-- \debounce_ps2_clk|Add0~3\ = CARRY((!\debounce_ps2_clk|Add0~1\) # (!\debounce_ps2_clk|counter_out\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|counter_out\(1),
	datad => VCC,
	cin => \debounce_ps2_clk|Add0~1\,
	combout => \debounce_ps2_clk|Add0~2_combout\,
	cout => \debounce_ps2_clk|Add0~3\);

-- Location: LCCOMB_X55_Y70_N2
\debounce_ps2_clk|counter_out[1]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[1]~8_combout\ = (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~2_combout\) # ((\debounce_ps2_clk|result~1_combout\ & \debounce_ps2_clk|counter_out\(1))))) # 
-- (!\debounce_ps2_clk|counter_out[0]~1_combout\ & (\debounce_ps2_clk|result~1_combout\ & (\debounce_ps2_clk|counter_out\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datab => \debounce_ps2_clk|result~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(1),
	datad => \debounce_ps2_clk|Add0~2_combout\,
	combout => \debounce_ps2_clk|counter_out[1]~8_combout\);

-- Location: FF_X55_Y70_N3
\debounce_ps2_clk|counter_out[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[1]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(1));

-- Location: LCCOMB_X54_Y70_N10
\debounce_ps2_clk|Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~4_combout\ = (\debounce_ps2_clk|counter_out\(2) & (\debounce_ps2_clk|Add0~3\ $ (GND))) # (!\debounce_ps2_clk|counter_out\(2) & (!\debounce_ps2_clk|Add0~3\ & VCC))
-- \debounce_ps2_clk|Add0~5\ = CARRY((\debounce_ps2_clk|counter_out\(2) & !\debounce_ps2_clk|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_clk|counter_out\(2),
	datad => VCC,
	cin => \debounce_ps2_clk|Add0~3\,
	combout => \debounce_ps2_clk|Add0~4_combout\,
	cout => \debounce_ps2_clk|Add0~5\);

-- Location: LCCOMB_X54_Y70_N0
\debounce_ps2_clk|counter_out[2]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[2]~7_combout\ = (\debounce_ps2_clk|result~1_combout\ & ((\debounce_ps2_clk|counter_out\(2)) # ((\debounce_ps2_clk|counter_out[0]~1_combout\ & \debounce_ps2_clk|Add0~4_combout\)))) # (!\debounce_ps2_clk|result~1_combout\ & 
-- (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~1_combout\,
	datab => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(2),
	datad => \debounce_ps2_clk|Add0~4_combout\,
	combout => \debounce_ps2_clk|counter_out[2]~7_combout\);

-- Location: FF_X54_Y70_N1
\debounce_ps2_clk|counter_out[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[2]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(2));

-- Location: LCCOMB_X54_Y70_N12
\debounce_ps2_clk|Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~6_combout\ = (\debounce_ps2_clk|counter_out\(3) & (!\debounce_ps2_clk|Add0~5\)) # (!\debounce_ps2_clk|counter_out\(3) & ((\debounce_ps2_clk|Add0~5\) # (GND)))
-- \debounce_ps2_clk|Add0~7\ = CARRY((!\debounce_ps2_clk|Add0~5\) # (!\debounce_ps2_clk|counter_out\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_clk|counter_out\(3),
	datad => VCC,
	cin => \debounce_ps2_clk|Add0~5\,
	combout => \debounce_ps2_clk|Add0~6_combout\,
	cout => \debounce_ps2_clk|Add0~7\);

-- Location: LCCOMB_X54_Y70_N2
\debounce_ps2_clk|counter_out[3]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[3]~6_combout\ = (\debounce_ps2_clk|result~1_combout\ & ((\debounce_ps2_clk|counter_out\(3)) # ((\debounce_ps2_clk|counter_out[0]~1_combout\ & \debounce_ps2_clk|Add0~6_combout\)))) # (!\debounce_ps2_clk|result~1_combout\ & 
-- (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~1_combout\,
	datab => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(3),
	datad => \debounce_ps2_clk|Add0~6_combout\,
	combout => \debounce_ps2_clk|counter_out[3]~6_combout\);

-- Location: FF_X54_Y70_N3
\debounce_ps2_clk|counter_out[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[3]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(3));

-- Location: LCCOMB_X54_Y70_N14
\debounce_ps2_clk|Add0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~8_combout\ = (\debounce_ps2_clk|counter_out\(4) & (\debounce_ps2_clk|Add0~7\ $ (GND))) # (!\debounce_ps2_clk|counter_out\(4) & (!\debounce_ps2_clk|Add0~7\ & VCC))
-- \debounce_ps2_clk|Add0~9\ = CARRY((\debounce_ps2_clk|counter_out\(4) & !\debounce_ps2_clk|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_clk|counter_out\(4),
	datad => VCC,
	cin => \debounce_ps2_clk|Add0~7\,
	combout => \debounce_ps2_clk|Add0~8_combout\,
	cout => \debounce_ps2_clk|Add0~9\);

-- Location: LCCOMB_X55_Y70_N22
\debounce_ps2_clk|counter_out[4]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[4]~5_combout\ = (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~8_combout\) # ((\debounce_ps2_clk|result~1_combout\ & \debounce_ps2_clk|counter_out\(4))))) # 
-- (!\debounce_ps2_clk|counter_out[0]~1_combout\ & (\debounce_ps2_clk|result~1_combout\ & (\debounce_ps2_clk|counter_out\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datab => \debounce_ps2_clk|result~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(4),
	datad => \debounce_ps2_clk|Add0~8_combout\,
	combout => \debounce_ps2_clk|counter_out[4]~5_combout\);

-- Location: FF_X55_Y70_N23
\debounce_ps2_clk|counter_out[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[4]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(4));

-- Location: LCCOMB_X54_Y70_N16
\debounce_ps2_clk|Add0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~10_combout\ = (\debounce_ps2_clk|counter_out\(5) & (!\debounce_ps2_clk|Add0~9\)) # (!\debounce_ps2_clk|counter_out\(5) & ((\debounce_ps2_clk|Add0~9\) # (GND)))
-- \debounce_ps2_clk|Add0~11\ = CARRY((!\debounce_ps2_clk|Add0~9\) # (!\debounce_ps2_clk|counter_out\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_clk|counter_out\(5),
	datad => VCC,
	cin => \debounce_ps2_clk|Add0~9\,
	combout => \debounce_ps2_clk|Add0~10_combout\,
	cout => \debounce_ps2_clk|Add0~11\);

-- Location: LCCOMB_X54_Y70_N4
\debounce_ps2_clk|counter_out[5]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[5]~4_combout\ = (\debounce_ps2_clk|result~1_combout\ & ((\debounce_ps2_clk|counter_out\(5)) # ((\debounce_ps2_clk|counter_out[0]~1_combout\ & \debounce_ps2_clk|Add0~10_combout\)))) # (!\debounce_ps2_clk|result~1_combout\ & 
-- (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~10_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~1_combout\,
	datab => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(5),
	datad => \debounce_ps2_clk|Add0~10_combout\,
	combout => \debounce_ps2_clk|counter_out[5]~4_combout\);

-- Location: FF_X54_Y70_N5
\debounce_ps2_clk|counter_out[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[5]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(5));

-- Location: LCCOMB_X54_Y70_N18
\debounce_ps2_clk|Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~12_combout\ = (\debounce_ps2_clk|counter_out\(6) & (\debounce_ps2_clk|Add0~11\ $ (GND))) # (!\debounce_ps2_clk|counter_out\(6) & (!\debounce_ps2_clk|Add0~11\ & VCC))
-- \debounce_ps2_clk|Add0~13\ = CARRY((\debounce_ps2_clk|counter_out\(6) & !\debounce_ps2_clk|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_clk|counter_out\(6),
	datad => VCC,
	cin => \debounce_ps2_clk|Add0~11\,
	combout => \debounce_ps2_clk|Add0~12_combout\,
	cout => \debounce_ps2_clk|Add0~13\);

-- Location: LCCOMB_X54_Y70_N28
\debounce_ps2_clk|counter_out[6]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[6]~3_combout\ = (\debounce_ps2_clk|result~1_combout\ & ((\debounce_ps2_clk|counter_out\(6)) # ((\debounce_ps2_clk|counter_out[0]~1_combout\ & \debounce_ps2_clk|Add0~12_combout\)))) # (!\debounce_ps2_clk|result~1_combout\ & 
-- (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~12_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~1_combout\,
	datab => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(6),
	datad => \debounce_ps2_clk|Add0~12_combout\,
	combout => \debounce_ps2_clk|counter_out[6]~3_combout\);

-- Location: FF_X54_Y70_N29
\debounce_ps2_clk|counter_out[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[6]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(6));

-- Location: LCCOMB_X54_Y70_N20
\debounce_ps2_clk|Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~14_combout\ = (\debounce_ps2_clk|counter_out\(7) & (!\debounce_ps2_clk|Add0~13\)) # (!\debounce_ps2_clk|counter_out\(7) & ((\debounce_ps2_clk|Add0~13\) # (GND)))
-- \debounce_ps2_clk|Add0~15\ = CARRY((!\debounce_ps2_clk|Add0~13\) # (!\debounce_ps2_clk|counter_out\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|counter_out\(7),
	datad => VCC,
	cin => \debounce_ps2_clk|Add0~13\,
	combout => \debounce_ps2_clk|Add0~14_combout\,
	cout => \debounce_ps2_clk|Add0~15\);

-- Location: LCCOMB_X54_Y70_N30
\debounce_ps2_clk|counter_out[7]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out[7]~2_combout\ = (\debounce_ps2_clk|result~1_combout\ & ((\debounce_ps2_clk|counter_out\(7)) # ((\debounce_ps2_clk|counter_out[0]~1_combout\ & \debounce_ps2_clk|Add0~14_combout\)))) # (!\debounce_ps2_clk|result~1_combout\ & 
-- (\debounce_ps2_clk|counter_out[0]~1_combout\ & ((\debounce_ps2_clk|Add0~14_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~1_combout\,
	datab => \debounce_ps2_clk|counter_out[0]~1_combout\,
	datac => \debounce_ps2_clk|counter_out\(7),
	datad => \debounce_ps2_clk|Add0~14_combout\,
	combout => \debounce_ps2_clk|counter_out[7]~2_combout\);

-- Location: FF_X54_Y70_N31
\debounce_ps2_clk|counter_out[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(7));

-- Location: LCCOMB_X54_Y70_N22
\debounce_ps2_clk|Add0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|Add0~16_combout\ = \debounce_ps2_clk|Add0~15\ $ (!\debounce_ps2_clk|counter_out\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \debounce_ps2_clk|counter_out\(8),
	cin => \debounce_ps2_clk|Add0~15\,
	combout => \debounce_ps2_clk|Add0~16_combout\);

-- Location: LCCOMB_X54_Y70_N24
\debounce_ps2_clk|counter_out~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|counter_out~0_combout\ = (\debounce_ps2_clk|counter_out\(8) & (\debounce_ps2_clk|flipflops\(1) $ ((!\debounce_ps2_clk|flipflops\(0))))) # (!\debounce_ps2_clk|counter_out\(8) & (\debounce_ps2_clk|Add0~16_combout\ & 
-- (\debounce_ps2_clk|flipflops\(1) $ (!\debounce_ps2_clk|flipflops\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100110010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|flipflops\(1),
	datab => \debounce_ps2_clk|flipflops\(0),
	datac => \debounce_ps2_clk|counter_out\(8),
	datad => \debounce_ps2_clk|Add0~16_combout\,
	combout => \debounce_ps2_clk|counter_out~0_combout\);

-- Location: FF_X54_Y70_N25
\debounce_ps2_clk|counter_out[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|counter_out~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|counter_out\(8));

-- Location: LCCOMB_X55_Y70_N26
\debounce_ps2_clk|result~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|result~0_combout\ = (\debounce_ps2_clk|result~q\ & ((\debounce_ps2_clk|flipflops\(1)) # ((\debounce_ps2_clk|flipflops\(0)) # (!\debounce_ps2_clk|counter_out\(8))))) # (!\debounce_ps2_clk|result~q\ & (\debounce_ps2_clk|flipflops\(1) & 
-- (\debounce_ps2_clk|flipflops\(0) & \debounce_ps2_clk|counter_out\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~q\,
	datab => \debounce_ps2_clk|flipflops\(1),
	datac => \debounce_ps2_clk|flipflops\(0),
	datad => \debounce_ps2_clk|counter_out\(8),
	combout => \debounce_ps2_clk|result~0_combout\);

-- Location: LCCOMB_X55_Y70_N14
\debounce_ps2_clk|result~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_clk|result~feeder_combout\ = \debounce_ps2_clk|result~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \debounce_ps2_clk|result~0_combout\,
	combout => \debounce_ps2_clk|result~feeder_combout\);

-- Location: FF_X55_Y70_N15
\debounce_ps2_clk|result\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_clk|result~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_clk|result~q\);

-- Location: LCCOMB_X65_Y71_N10
\count_idle[3]~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[3]~19_combout\ = (count_idle(3) & (!\count_idle[2]~18\)) # (!count_idle(3) & ((\count_idle[2]~18\) # (GND)))
-- \count_idle[3]~20\ = CARRY((!\count_idle[2]~18\) # (!count_idle(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(3),
	datad => VCC,
	cin => \count_idle[2]~18\,
	combout => \count_idle[3]~19_combout\,
	cout => \count_idle[3]~20\);

-- Location: LCCOMB_X65_Y71_N12
\count_idle[4]~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[4]~21_combout\ = (count_idle(4) & (\count_idle[3]~20\ $ (GND))) # (!count_idle(4) & (!\count_idle[3]~20\ & VCC))
-- \count_idle[4]~22\ = CARRY((count_idle(4) & !\count_idle[3]~20\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(4),
	datad => VCC,
	cin => \count_idle[3]~20\,
	combout => \count_idle[4]~21_combout\,
	cout => \count_idle[4]~22\);

-- Location: FF_X65_Y71_N13
\count_idle[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[4]~21_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(4));

-- Location: LCCOMB_X65_Y71_N14
\count_idle[5]~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[5]~23_combout\ = (count_idle(5) & (!\count_idle[4]~22\)) # (!count_idle(5) & ((\count_idle[4]~22\) # (GND)))
-- \count_idle[5]~24\ = CARRY((!\count_idle[4]~22\) # (!count_idle(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => count_idle(5),
	datad => VCC,
	cin => \count_idle[4]~22\,
	combout => \count_idle[5]~23_combout\,
	cout => \count_idle[5]~24\);

-- Location: FF_X65_Y71_N15
\count_idle[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[5]~23_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(5));

-- Location: LCCOMB_X65_Y71_N16
\count_idle[6]~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[6]~25_combout\ = (count_idle(6) & (\count_idle[5]~24\ $ (GND))) # (!count_idle(6) & (!\count_idle[5]~24\ & VCC))
-- \count_idle[6]~26\ = CARRY((count_idle(6) & !\count_idle[5]~24\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => count_idle(6),
	datad => VCC,
	cin => \count_idle[5]~24\,
	combout => \count_idle[6]~25_combout\,
	cout => \count_idle[6]~26\);

-- Location: FF_X65_Y71_N17
\count_idle[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[6]~25_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(6));

-- Location: LCCOMB_X65_Y71_N18
\count_idle[7]~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[7]~27_combout\ = (count_idle(7) & (!\count_idle[6]~26\)) # (!count_idle(7) & ((\count_idle[6]~26\) # (GND)))
-- \count_idle[7]~28\ = CARRY((!\count_idle[6]~26\) # (!count_idle(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(7),
	datad => VCC,
	cin => \count_idle[6]~26\,
	combout => \count_idle[7]~27_combout\,
	cout => \count_idle[7]~28\);

-- Location: FF_X65_Y71_N19
\count_idle[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[7]~27_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(7));

-- Location: LCCOMB_X65_Y71_N20
\count_idle[8]~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[8]~29_combout\ = (count_idle(8) & (\count_idle[7]~28\ $ (GND))) # (!count_idle(8) & (!\count_idle[7]~28\ & VCC))
-- \count_idle[8]~30\ = CARRY((count_idle(8) & !\count_idle[7]~28\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(8),
	datad => VCC,
	cin => \count_idle[7]~28\,
	combout => \count_idle[8]~29_combout\,
	cout => \count_idle[8]~30\);

-- Location: FF_X65_Y71_N21
\count_idle[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[8]~29_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(8));

-- Location: LCCOMB_X65_Y71_N22
\count_idle[9]~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[9]~31_combout\ = (count_idle(9) & (!\count_idle[8]~30\)) # (!count_idle(9) & ((\count_idle[8]~30\) # (GND)))
-- \count_idle[9]~32\ = CARRY((!\count_idle[8]~30\) # (!count_idle(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(9),
	datad => VCC,
	cin => \count_idle[8]~30\,
	combout => \count_idle[9]~31_combout\,
	cout => \count_idle[9]~32\);

-- Location: FF_X65_Y71_N23
\count_idle[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[9]~31_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(9));

-- Location: LCCOMB_X65_Y71_N24
\count_idle[10]~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[10]~33_combout\ = (count_idle(10) & (\count_idle[9]~32\ $ (GND))) # (!count_idle(10) & (!\count_idle[9]~32\ & VCC))
-- \count_idle[10]~34\ = CARRY((count_idle(10) & !\count_idle[9]~32\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => count_idle(10),
	datad => VCC,
	cin => \count_idle[9]~32\,
	combout => \count_idle[10]~33_combout\,
	cout => \count_idle[10]~34\);

-- Location: FF_X65_Y71_N25
\count_idle[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[10]~33_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(10));

-- Location: LCCOMB_X65_Y71_N26
\count_idle[11]~35\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[11]~35_combout\ = \count_idle[10]~34\ $ (count_idle(11))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => count_idle(11),
	cin => \count_idle[10]~34\,
	combout => \count_idle[11]~35_combout\);

-- Location: FF_X65_Y71_N27
\count_idle[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[11]~35_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(11));

-- Location: LCCOMB_X65_Y71_N28
\Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = (count_idle(11) & (!count_idle(8) & (count_idle(9) & !count_idle(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(11),
	datab => count_idle(8),
	datac => count_idle(9),
	datad => count_idle(10),
	combout => \Equal0~2_combout\);

-- Location: LCCOMB_X65_Y71_N30
\Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = (count_idle(4) & (count_idle(6) & (!count_idle(5) & count_idle(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(4),
	datab => count_idle(6),
	datac => count_idle(5),
	datad => count_idle(7),
	combout => \Equal0~1_combout\);

-- Location: LCCOMB_X65_Y71_N2
\count_idle[4]~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[4]~14_combout\ = (((!\Equal0~0_combout\) # (!\Equal0~1_combout\)) # (!\Equal0~2_combout\)) # (!\debounce_ps2_clk|result~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_clk|result~q\,
	datab => \Equal0~2_combout\,
	datac => \Equal0~1_combout\,
	datad => \Equal0~0_combout\,
	combout => \count_idle[4]~14_combout\);

-- Location: FF_X65_Y71_N5
\count_idle[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[0]~12_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(0));

-- Location: LCCOMB_X65_Y71_N6
\count_idle[1]~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[1]~15_combout\ = (count_idle(1) & (!\count_idle[0]~13\)) # (!count_idle(1) & ((\count_idle[0]~13\) # (GND)))
-- \count_idle[1]~16\ = CARRY((!\count_idle[0]~13\) # (!count_idle(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(1),
	datad => VCC,
	cin => \count_idle[0]~13\,
	combout => \count_idle[1]~15_combout\,
	cout => \count_idle[1]~16\);

-- Location: FF_X65_Y71_N7
\count_idle[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[1]~15_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(1));

-- Location: LCCOMB_X65_Y71_N8
\count_idle[2]~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \count_idle[2]~17_combout\ = (count_idle(2) & (\count_idle[1]~16\ $ (GND))) # (!count_idle(2) & (!\count_idle[1]~16\ & VCC))
-- \count_idle[2]~18\ = CARRY((count_idle(2) & !\count_idle[1]~16\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => count_idle(2),
	datad => VCC,
	cin => \count_idle[1]~16\,
	combout => \count_idle[2]~17_combout\,
	cout => \count_idle[2]~18\);

-- Location: FF_X65_Y71_N9
\count_idle[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[2]~17_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(2));

-- Location: FF_X65_Y71_N11
\count_idle[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \count_idle[3]~19_combout\,
	sclr => \debounce_ps2_clk|ALT_INV_result~q\,
	ena => \count_idle[4]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count_idle(3));

-- Location: LCCOMB_X65_Y71_N0
\Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = (count_idle(3) & (count_idle(0) & (!count_idle(2) & !count_idle(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => count_idle(3),
	datab => count_idle(0),
	datac => count_idle(2),
	datad => count_idle(1),
	combout => \Equal0~0_combout\);

-- Location: CLKCTRL_G11
\debounce_ps2_clk|result~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \debounce_ps2_clk|result~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \debounce_ps2_clk|result~clkctrl_outclk\);

-- Location: IOIBUF_X0_Y59_N22
\ps2_data~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ps2_data,
	o => \ps2_data~input_o\);

-- Location: FF_X12_Y60_N9
\sync_ffs[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \ps2_data~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => sync_ffs(1));

-- Location: FF_X12_Y60_N11
\debounce_ps2_data|flipflops[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => sync_ffs(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|flipflops\(0));

-- Location: FF_X13_Y60_N27
\debounce_ps2_data|flipflops[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \debounce_ps2_data|flipflops\(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|flipflops\(1));

-- Location: LCCOMB_X13_Y60_N26
\debounce_ps2_data|counter_out[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[0]~1_combout\ = (!\debounce_ps2_data|counter_out\(8) & (\debounce_ps2_data|flipflops\(0) $ (!\debounce_ps2_data|flipflops\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_data|flipflops\(0),
	datac => \debounce_ps2_data|flipflops\(1),
	datad => \debounce_ps2_data|counter_out\(8),
	combout => \debounce_ps2_data|counter_out[0]~1_combout\);

-- Location: LCCOMB_X13_Y60_N28
\debounce_ps2_data|result~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|result~1_combout\ = (\debounce_ps2_data|counter_out\(8) & (\debounce_ps2_data|flipflops\(1) $ (!\debounce_ps2_data|flipflops\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010010000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|flipflops\(1),
	datab => \debounce_ps2_data|counter_out\(8),
	datac => \debounce_ps2_data|flipflops\(0),
	combout => \debounce_ps2_data|result~1_combout\);

-- Location: LCCOMB_X12_Y60_N8
\debounce_ps2_data|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~0_combout\ = \debounce_ps2_data|counter_out\(0) $ (VCC)
-- \debounce_ps2_data|Add0~1\ = CARRY(\debounce_ps2_data|counter_out\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out\(0),
	datad => VCC,
	combout => \debounce_ps2_data|Add0~0_combout\,
	cout => \debounce_ps2_data|Add0~1\);

-- Location: LCCOMB_X12_Y60_N6
\debounce_ps2_data|counter_out[0]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[0]~9_combout\ = (\debounce_ps2_data|counter_out[0]~1_combout\ & ((\debounce_ps2_data|Add0~0_combout\) # ((\debounce_ps2_data|result~1_combout\ & \debounce_ps2_data|counter_out\(0))))) # 
-- (!\debounce_ps2_data|counter_out[0]~1_combout\ & (\debounce_ps2_data|result~1_combout\ & (\debounce_ps2_data|counter_out\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out[0]~1_combout\,
	datab => \debounce_ps2_data|result~1_combout\,
	datac => \debounce_ps2_data|counter_out\(0),
	datad => \debounce_ps2_data|Add0~0_combout\,
	combout => \debounce_ps2_data|counter_out[0]~9_combout\);

-- Location: FF_X12_Y60_N7
\debounce_ps2_data|counter_out[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[0]~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(0));

-- Location: LCCOMB_X12_Y60_N10
\debounce_ps2_data|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~2_combout\ = (\debounce_ps2_data|counter_out\(1) & (!\debounce_ps2_data|Add0~1\)) # (!\debounce_ps2_data|counter_out\(1) & ((\debounce_ps2_data|Add0~1\) # (GND)))
-- \debounce_ps2_data|Add0~3\ = CARRY((!\debounce_ps2_data|Add0~1\) # (!\debounce_ps2_data|counter_out\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out\(1),
	datad => VCC,
	cin => \debounce_ps2_data|Add0~1\,
	combout => \debounce_ps2_data|Add0~2_combout\,
	cout => \debounce_ps2_data|Add0~3\);

-- Location: LCCOMB_X13_Y60_N30
\debounce_ps2_data|counter_out[1]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[1]~8_combout\ = (\debounce_ps2_data|Add0~2_combout\ & ((\debounce_ps2_data|counter_out[0]~1_combout\) # ((\debounce_ps2_data|counter_out\(1) & \debounce_ps2_data|result~1_combout\)))) # (!\debounce_ps2_data|Add0~2_combout\ & 
-- (((\debounce_ps2_data|counter_out\(1) & \debounce_ps2_data|result~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|Add0~2_combout\,
	datab => \debounce_ps2_data|counter_out[0]~1_combout\,
	datac => \debounce_ps2_data|counter_out\(1),
	datad => \debounce_ps2_data|result~1_combout\,
	combout => \debounce_ps2_data|counter_out[1]~8_combout\);

-- Location: FF_X13_Y60_N31
\debounce_ps2_data|counter_out[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[1]~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(1));

-- Location: LCCOMB_X12_Y60_N12
\debounce_ps2_data|Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~4_combout\ = (\debounce_ps2_data|counter_out\(2) & (\debounce_ps2_data|Add0~3\ $ (GND))) # (!\debounce_ps2_data|counter_out\(2) & (!\debounce_ps2_data|Add0~3\ & VCC))
-- \debounce_ps2_data|Add0~5\ = CARRY((\debounce_ps2_data|counter_out\(2) & !\debounce_ps2_data|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out\(2),
	datad => VCC,
	cin => \debounce_ps2_data|Add0~3\,
	combout => \debounce_ps2_data|Add0~4_combout\,
	cout => \debounce_ps2_data|Add0~5\);

-- Location: LCCOMB_X12_Y60_N26
\debounce_ps2_data|counter_out[2]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[2]~7_combout\ = (\debounce_ps2_data|counter_out[0]~1_combout\ & ((\debounce_ps2_data|Add0~4_combout\) # ((\debounce_ps2_data|result~1_combout\ & \debounce_ps2_data|counter_out\(2))))) # 
-- (!\debounce_ps2_data|counter_out[0]~1_combout\ & (\debounce_ps2_data|result~1_combout\ & (\debounce_ps2_data|counter_out\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out[0]~1_combout\,
	datab => \debounce_ps2_data|result~1_combout\,
	datac => \debounce_ps2_data|counter_out\(2),
	datad => \debounce_ps2_data|Add0~4_combout\,
	combout => \debounce_ps2_data|counter_out[2]~7_combout\);

-- Location: FF_X12_Y60_N27
\debounce_ps2_data|counter_out[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[2]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(2));

-- Location: LCCOMB_X12_Y60_N14
\debounce_ps2_data|Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~6_combout\ = (\debounce_ps2_data|counter_out\(3) & (!\debounce_ps2_data|Add0~5\)) # (!\debounce_ps2_data|counter_out\(3) & ((\debounce_ps2_data|Add0~5\) # (GND)))
-- \debounce_ps2_data|Add0~7\ = CARRY((!\debounce_ps2_data|Add0~5\) # (!\debounce_ps2_data|counter_out\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out\(3),
	datad => VCC,
	cin => \debounce_ps2_data|Add0~5\,
	combout => \debounce_ps2_data|Add0~6_combout\,
	cout => \debounce_ps2_data|Add0~7\);

-- Location: LCCOMB_X12_Y60_N30
\debounce_ps2_data|counter_out[3]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[3]~6_combout\ = (\debounce_ps2_data|counter_out[0]~1_combout\ & ((\debounce_ps2_data|Add0~6_combout\) # ((\debounce_ps2_data|result~1_combout\ & \debounce_ps2_data|counter_out\(3))))) # 
-- (!\debounce_ps2_data|counter_out[0]~1_combout\ & (\debounce_ps2_data|result~1_combout\ & (\debounce_ps2_data|counter_out\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out[0]~1_combout\,
	datab => \debounce_ps2_data|result~1_combout\,
	datac => \debounce_ps2_data|counter_out\(3),
	datad => \debounce_ps2_data|Add0~6_combout\,
	combout => \debounce_ps2_data|counter_out[3]~6_combout\);

-- Location: FF_X12_Y60_N31
\debounce_ps2_data|counter_out[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[3]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(3));

-- Location: LCCOMB_X12_Y60_N16
\debounce_ps2_data|Add0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~8_combout\ = (\debounce_ps2_data|counter_out\(4) & (\debounce_ps2_data|Add0~7\ $ (GND))) # (!\debounce_ps2_data|counter_out\(4) & (!\debounce_ps2_data|Add0~7\ & VCC))
-- \debounce_ps2_data|Add0~9\ = CARRY((\debounce_ps2_data|counter_out\(4) & !\debounce_ps2_data|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out\(4),
	datad => VCC,
	cin => \debounce_ps2_data|Add0~7\,
	combout => \debounce_ps2_data|Add0~8_combout\,
	cout => \debounce_ps2_data|Add0~9\);

-- Location: LCCOMB_X13_Y60_N20
\debounce_ps2_data|counter_out[4]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[4]~5_combout\ = (\debounce_ps2_data|Add0~8_combout\ & ((\debounce_ps2_data|counter_out[0]~1_combout\) # ((\debounce_ps2_data|result~1_combout\ & \debounce_ps2_data|counter_out\(4))))) # (!\debounce_ps2_data|Add0~8_combout\ & 
-- (\debounce_ps2_data|result~1_combout\ & (\debounce_ps2_data|counter_out\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|Add0~8_combout\,
	datab => \debounce_ps2_data|result~1_combout\,
	datac => \debounce_ps2_data|counter_out\(4),
	datad => \debounce_ps2_data|counter_out[0]~1_combout\,
	combout => \debounce_ps2_data|counter_out[4]~5_combout\);

-- Location: FF_X13_Y60_N21
\debounce_ps2_data|counter_out[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[4]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(4));

-- Location: LCCOMB_X12_Y60_N18
\debounce_ps2_data|Add0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~10_combout\ = (\debounce_ps2_data|counter_out\(5) & (!\debounce_ps2_data|Add0~9\)) # (!\debounce_ps2_data|counter_out\(5) & ((\debounce_ps2_data|Add0~9\) # (GND)))
-- \debounce_ps2_data|Add0~11\ = CARRY((!\debounce_ps2_data|Add0~9\) # (!\debounce_ps2_data|counter_out\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_data|counter_out\(5),
	datad => VCC,
	cin => \debounce_ps2_data|Add0~9\,
	combout => \debounce_ps2_data|Add0~10_combout\,
	cout => \debounce_ps2_data|Add0~11\);

-- Location: LCCOMB_X12_Y60_N4
\debounce_ps2_data|counter_out[5]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[5]~4_combout\ = (\debounce_ps2_data|counter_out[0]~1_combout\ & ((\debounce_ps2_data|Add0~10_combout\) # ((\debounce_ps2_data|result~1_combout\ & \debounce_ps2_data|counter_out\(5))))) # 
-- (!\debounce_ps2_data|counter_out[0]~1_combout\ & (\debounce_ps2_data|result~1_combout\ & (\debounce_ps2_data|counter_out\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out[0]~1_combout\,
	datab => \debounce_ps2_data|result~1_combout\,
	datac => \debounce_ps2_data|counter_out\(5),
	datad => \debounce_ps2_data|Add0~10_combout\,
	combout => \debounce_ps2_data|counter_out[5]~4_combout\);

-- Location: FF_X12_Y60_N5
\debounce_ps2_data|counter_out[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[5]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(5));

-- Location: LCCOMB_X12_Y60_N20
\debounce_ps2_data|Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~12_combout\ = (\debounce_ps2_data|counter_out\(6) & (\debounce_ps2_data|Add0~11\ $ (GND))) # (!\debounce_ps2_data|counter_out\(6) & (!\debounce_ps2_data|Add0~11\ & VCC))
-- \debounce_ps2_data|Add0~13\ = CARRY((\debounce_ps2_data|counter_out\(6) & !\debounce_ps2_data|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_data|counter_out\(6),
	datad => VCC,
	cin => \debounce_ps2_data|Add0~11\,
	combout => \debounce_ps2_data|Add0~12_combout\,
	cout => \debounce_ps2_data|Add0~13\);

-- Location: LCCOMB_X12_Y60_N2
\debounce_ps2_data|counter_out[6]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[6]~3_combout\ = (\debounce_ps2_data|counter_out[0]~1_combout\ & ((\debounce_ps2_data|Add0~12_combout\) # ((\debounce_ps2_data|result~1_combout\ & \debounce_ps2_data|counter_out\(6))))) # 
-- (!\debounce_ps2_data|counter_out[0]~1_combout\ & (\debounce_ps2_data|result~1_combout\ & (\debounce_ps2_data|counter_out\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out[0]~1_combout\,
	datab => \debounce_ps2_data|result~1_combout\,
	datac => \debounce_ps2_data|counter_out\(6),
	datad => \debounce_ps2_data|Add0~12_combout\,
	combout => \debounce_ps2_data|counter_out[6]~3_combout\);

-- Location: FF_X12_Y60_N3
\debounce_ps2_data|counter_out[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[6]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(6));

-- Location: LCCOMB_X12_Y60_N22
\debounce_ps2_data|Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~14_combout\ = (\debounce_ps2_data|counter_out\(7) & (!\debounce_ps2_data|Add0~13\)) # (!\debounce_ps2_data|counter_out\(7) & ((\debounce_ps2_data|Add0~13\) # (GND)))
-- \debounce_ps2_data|Add0~15\ = CARRY((!\debounce_ps2_data|Add0~13\) # (!\debounce_ps2_data|counter_out\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \debounce_ps2_data|counter_out\(7),
	datad => VCC,
	cin => \debounce_ps2_data|Add0~13\,
	combout => \debounce_ps2_data|Add0~14_combout\,
	cout => \debounce_ps2_data|Add0~15\);

-- Location: LCCOMB_X12_Y60_N0
\debounce_ps2_data|counter_out[7]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out[7]~2_combout\ = (\debounce_ps2_data|counter_out[0]~1_combout\ & ((\debounce_ps2_data|Add0~14_combout\) # ((\debounce_ps2_data|result~1_combout\ & \debounce_ps2_data|counter_out\(7))))) # 
-- (!\debounce_ps2_data|counter_out[0]~1_combout\ & (\debounce_ps2_data|result~1_combout\ & (\debounce_ps2_data|counter_out\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|counter_out[0]~1_combout\,
	datab => \debounce_ps2_data|result~1_combout\,
	datac => \debounce_ps2_data|counter_out\(7),
	datad => \debounce_ps2_data|Add0~14_combout\,
	combout => \debounce_ps2_data|counter_out[7]~2_combout\);

-- Location: FF_X12_Y60_N1
\debounce_ps2_data|counter_out[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out[7]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(7));

-- Location: LCCOMB_X12_Y60_N24
\debounce_ps2_data|Add0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|Add0~16_combout\ = \debounce_ps2_data|Add0~15\ $ (!\debounce_ps2_data|counter_out\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \debounce_ps2_data|counter_out\(8),
	cin => \debounce_ps2_data|Add0~15\,
	combout => \debounce_ps2_data|Add0~16_combout\);

-- Location: LCCOMB_X12_Y60_N28
\debounce_ps2_data|counter_out~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|counter_out~0_combout\ = (\debounce_ps2_data|counter_out\(8) & (\debounce_ps2_data|flipflops\(0) $ ((!\debounce_ps2_data|flipflops\(1))))) # (!\debounce_ps2_data|counter_out\(8) & (\debounce_ps2_data|Add0~16_combout\ & 
-- (\debounce_ps2_data|flipflops\(0) $ (!\debounce_ps2_data|flipflops\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100110010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|flipflops\(0),
	datab => \debounce_ps2_data|flipflops\(1),
	datac => \debounce_ps2_data|counter_out\(8),
	datad => \debounce_ps2_data|Add0~16_combout\,
	combout => \debounce_ps2_data|counter_out~0_combout\);

-- Location: FF_X12_Y60_N29
\debounce_ps2_data|counter_out[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|counter_out~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|counter_out\(8));

-- Location: LCCOMB_X13_Y60_N12
\debounce_ps2_data|result~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \debounce_ps2_data|result~0_combout\ = (\debounce_ps2_data|flipflops\(1) & ((\debounce_ps2_data|result~q\) # ((\debounce_ps2_data|flipflops\(0) & \debounce_ps2_data|counter_out\(8))))) # (!\debounce_ps2_data|flipflops\(1) & (\debounce_ps2_data|result~q\ & 
-- ((\debounce_ps2_data|flipflops\(0)) # (!\debounce_ps2_data|counter_out\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \debounce_ps2_data|flipflops\(1),
	datab => \debounce_ps2_data|flipflops\(0),
	datac => \debounce_ps2_data|result~q\,
	datad => \debounce_ps2_data|counter_out\(8),
	combout => \debounce_ps2_data|result~0_combout\);

-- Location: FF_X13_Y60_N13
\debounce_ps2_data|result\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \debounce_ps2_data|result~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \debounce_ps2_data|result~q\);

-- Location: LCCOMB_X66_Y71_N30
\ps2_word[10]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_word[10]~feeder_combout\ = \debounce_ps2_data|result~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \debounce_ps2_data|result~q\,
	combout => \ps2_word[10]~feeder_combout\);

-- Location: FF_X66_Y71_N31
\ps2_word[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	d => \ps2_word[10]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(10));

-- Location: FF_X66_Y71_N9
\ps2_word[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	asdata => ps2_word(10),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(9));

-- Location: LCCOMB_X66_Y71_N12
\ps2_word[8]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_word[8]~feeder_combout\ = ps2_word(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ps2_word(9),
	combout => \ps2_word[8]~feeder_combout\);

-- Location: FF_X66_Y71_N13
\ps2_word[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	d => \ps2_word[8]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(8));

-- Location: LCCOMB_X66_Y71_N0
\ps2_word[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_word[7]~feeder_combout\ = ps2_word(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ps2_word(8),
	combout => \ps2_word[7]~feeder_combout\);

-- Location: FF_X66_Y71_N1
\ps2_word[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	d => \ps2_word[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(7));

-- Location: LCCOMB_X66_Y71_N14
\ps2_word[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_word[6]~feeder_combout\ = ps2_word(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ps2_word(7),
	combout => \ps2_word[6]~feeder_combout\);

-- Location: FF_X66_Y71_N15
\ps2_word[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	d => \ps2_word[6]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(6));

-- Location: FF_X66_Y71_N11
\ps2_word[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	asdata => ps2_word(6),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(5));

-- Location: LCCOMB_X66_Y71_N2
\ps2_word[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_word[4]~feeder_combout\ = ps2_word(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ps2_word(5),
	combout => \ps2_word[4]~feeder_combout\);

-- Location: FF_X66_Y71_N3
\ps2_word[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	d => \ps2_word[4]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(4));

-- Location: LCCOMB_X66_Y71_N16
\ps2_word[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_word[3]~feeder_combout\ = ps2_word(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ps2_word(4),
	combout => \ps2_word[3]~feeder_combout\);

-- Location: FF_X66_Y71_N17
\ps2_word[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	d => \ps2_word[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(3));

-- Location: LCCOMB_X66_Y71_N26
\ps2_word[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_word[2]~feeder_combout\ = ps2_word(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => ps2_word(3),
	combout => \ps2_word[2]~feeder_combout\);

-- Location: FF_X66_Y71_N27
\ps2_word[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	d => \ps2_word[2]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(2));

-- Location: FF_X66_Y71_N23
\ps2_word[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	asdata => ps2_word(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(1));

-- Location: LCCOMB_X66_Y71_N10
\error~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \error~1_combout\ = ps2_word(2) $ (ps2_word(4) $ (ps2_word(5) $ (ps2_word(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(2),
	datab => ps2_word(4),
	datac => ps2_word(5),
	datad => ps2_word(3),
	combout => \error~1_combout\);

-- Location: LCCOMB_X66_Y71_N8
\error~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \error~0_combout\ = ps2_word(8) $ (ps2_word(6) $ (ps2_word(9) $ (ps2_word(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(8),
	datab => ps2_word(6),
	datac => ps2_word(9),
	datad => ps2_word(7),
	combout => \error~0_combout\);

-- Location: FF_X66_Y71_N5
\ps2_word[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \debounce_ps2_clk|ALT_INV_result~clkctrl_outclk\,
	asdata => ps2_word(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ps2_word(0));

-- Location: LCCOMB_X66_Y71_N4
\process_2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \process_2~2_combout\ = (ps2_word(10) & !ps2_word(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(10),
	datac => ps2_word(0),
	combout => \process_2~2_combout\);

-- Location: LCCOMB_X66_Y71_N28
\process_2~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \process_2~3_combout\ = (\process_2~2_combout\ & (ps2_word(1) $ (\error~1_combout\ $ (\error~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(1),
	datab => \error~1_combout\,
	datac => \error~0_combout\,
	datad => \process_2~2_combout\,
	combout => \process_2~3_combout\);

-- Location: LCCOMB_X63_Y71_N4
\process_2~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \process_2~4_combout\ = (\Equal0~0_combout\ & (\Equal0~2_combout\ & (\Equal0~1_combout\ & \process_2~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~0_combout\,
	datab => \Equal0~2_combout\,
	datac => \Equal0~1_combout\,
	datad => \process_2~3_combout\,
	combout => \process_2~4_combout\);

-- Location: FF_X63_Y71_N5
\ps2_code_new~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \process_2~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code_new~reg0_q\);

-- Location: LCCOMB_X66_Y71_N22
\Equal0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = (\Equal0~0_combout\ & (\Equal0~2_combout\ & \Equal0~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~0_combout\,
	datab => \Equal0~2_combout\,
	datad => \Equal0~1_combout\,
	combout => \Equal0~3_combout\);

-- Location: LCCOMB_X67_Y71_N26
\ps2_code~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~17_combout\ = (\Equal0~3_combout\ & ((\process_2~3_combout\ & (ps2_word(1))) # (!\process_2~3_combout\ & ((\ps2_code[0]~reg0_q\))))) # (!\Equal0~3_combout\ & (((\ps2_code[0]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(1),
	datab => \Equal0~3_combout\,
	datac => \ps2_code[0]~reg0_q\,
	datad => \process_2~3_combout\,
	combout => \ps2_code~17_combout\);

-- Location: FF_X67_Y71_N27
\ps2_code[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[0]~reg0_q\);

-- Location: LCCOMB_X66_Y71_N6
\ps2_code~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~19_combout\ = (\process_2~3_combout\ & ((\Equal0~3_combout\ & (ps2_word(2))) # (!\Equal0~3_combout\ & ((\ps2_code[1]~reg0_q\))))) # (!\process_2~3_combout\ & (((\ps2_code[1]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(2),
	datab => \process_2~3_combout\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \Equal0~3_combout\,
	combout => \ps2_code~19_combout\);

-- Location: FF_X66_Y71_N7
\ps2_code[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~19_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[1]~reg0_q\);

-- Location: LCCOMB_X66_Y71_N24
\ps2_code~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~23_combout\ = (\Equal0~3_combout\ & ((\process_2~3_combout\ & (ps2_word(3))) # (!\process_2~3_combout\ & ((\ps2_code[2]~reg0_q\))))) # (!\Equal0~3_combout\ & (((\ps2_code[2]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~3_combout\,
	datab => ps2_word(3),
	datac => \ps2_code[2]~reg0_q\,
	datad => \process_2~3_combout\,
	combout => \ps2_code~23_combout\);

-- Location: FF_X66_Y71_N25
\ps2_code[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~23_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[2]~reg0_q\);

-- Location: LCCOMB_X67_Y71_N16
\ps2_code~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~16_combout\ = (\Equal0~3_combout\ & ((\process_2~3_combout\ & (ps2_word(4))) # (!\process_2~3_combout\ & ((\ps2_code[3]~reg0_q\))))) # (!\Equal0~3_combout\ & (((\ps2_code[3]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(4),
	datab => \Equal0~3_combout\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \process_2~3_combout\,
	combout => \ps2_code~16_combout\);

-- Location: FF_X67_Y71_N17
\ps2_code[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[3]~reg0_q\);

-- Location: LCCOMB_X67_Y71_N4
\ps2_code~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~22_combout\ = (\Equal0~3_combout\ & ((\process_2~3_combout\ & (ps2_word(5))) # (!\process_2~3_combout\ & ((\ps2_code[4]~reg0_q\))))) # (!\Equal0~3_combout\ & (((\ps2_code[4]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(5),
	datab => \Equal0~3_combout\,
	datac => \ps2_code[4]~reg0_q\,
	datad => \process_2~3_combout\,
	combout => \ps2_code~22_combout\);

-- Location: FF_X67_Y71_N5
\ps2_code[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~22_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[4]~reg0_q\);

-- Location: LCCOMB_X66_Y71_N18
\ps2_code~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~18_combout\ = (\process_2~3_combout\ & ((\Equal0~3_combout\ & (ps2_word(6))) # (!\Equal0~3_combout\ & ((\ps2_code[5]~reg0_q\))))) # (!\process_2~3_combout\ & (((\ps2_code[5]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(6),
	datab => \process_2~3_combout\,
	datac => \ps2_code[5]~reg0_q\,
	datad => \Equal0~3_combout\,
	combout => \ps2_code~18_combout\);

-- Location: FF_X66_Y71_N19
\ps2_code[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[5]~reg0_q\);

-- Location: LCCOMB_X66_Y71_N20
\ps2_code~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~20_combout\ = (\Equal0~3_combout\ & ((\process_2~3_combout\ & (ps2_word(7))) # (!\process_2~3_combout\ & ((\ps2_code[6]~reg0_q\))))) # (!\Equal0~3_combout\ & (((\ps2_code[6]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~3_combout\,
	datab => ps2_word(7),
	datac => \ps2_code[6]~reg0_q\,
	datad => \process_2~3_combout\,
	combout => \ps2_code~20_combout\);

-- Location: FF_X66_Y71_N21
\ps2_code[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[6]~reg0_q\);

-- Location: LCCOMB_X67_Y71_N24
\ps2_code~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \ps2_code~21_combout\ = (\Equal0~3_combout\ & ((\process_2~3_combout\ & (ps2_word(8))) # (!\process_2~3_combout\ & ((\ps2_code[7]~reg0_q\))))) # (!\Equal0~3_combout\ & (((\ps2_code[7]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => ps2_word(8),
	datab => \Equal0~3_combout\,
	datac => \ps2_code[7]~reg0_q\,
	datad => \process_2~3_combout\,
	combout => \ps2_code~21_combout\);

-- Location: FF_X67_Y71_N25
\ps2_code[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \ps2_code~21_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ps2_code[7]~reg0_q\);

-- Location: CLKCTRL_G12
\ps2_code_new~reg0clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \ps2_code_new~reg0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \ps2_code_new~reg0clkctrl_outclk\);

-- Location: LCCOMB_X68_Y71_N20
\Equal8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal8~0_combout\ = (!\ps2_code[3]~reg0_q\ & (!\ps2_code[0]~reg0_q\ & \ps2_code[2]~reg0_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[3]~reg0_q\,
	datac => \ps2_code[0]~reg0_q\,
	datad => \ps2_code[2]~reg0_q\,
	combout => \Equal8~0_combout\);

-- Location: LCCOMB_X67_Y71_N6
\Equal4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal4~0_combout\ = (!\ps2_code[7]~reg0_q\ & (\ps2_code[6]~reg0_q\ & (\ps2_code[1]~reg0_q\ & \ps2_code[5]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[7]~reg0_q\,
	datab => \ps2_code[6]~reg0_q\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \ps2_code[5]~reg0_q\,
	combout => \Equal4~0_combout\);

-- Location: LCCOMB_X72_Y71_N2
\current_state~182\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~182_combout\ = (\current_state.S87~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S87~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~182_combout\);

-- Location: FF_X72_Y71_N3
\current_state.S88\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~182_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S88~q\);

-- Location: LCCOMB_X72_Y71_N6
\current_state~133\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~133_combout\ = (\current_state.S88~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S88~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~133_combout\);

-- Location: FF_X72_Y71_N7
\current_state.S89\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S89~q\);

-- Location: LCCOMB_X72_Y71_N24
\current_state~183\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~183_combout\ = (\current_state.S89~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S89~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~183_combout\);

-- Location: FF_X72_Y71_N25
\current_state.S90\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~183_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S90~q\);

-- Location: LCCOMB_X73_Y71_N0
\current_state~134\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~134_combout\ = (\current_state.S90~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal4~0_combout\,
	datac => \current_state.S90~q\,
	datad => \Equal8~0_combout\,
	combout => \current_state~134_combout\);

-- Location: FF_X73_Y71_N1
\current_state.S91\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S91~q\);

-- Location: LCCOMB_X75_Y71_N2
\current_state~142\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~142_combout\ = (\current_state.S91~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S91~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~142_combout\);

-- Location: FF_X72_Y71_N23
\current_state.S92\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state~142_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S92~q\);

-- Location: LCCOMB_X72_Y71_N4
\current_state~99\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~99_combout\ = (\current_state.S92~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S92~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~99_combout\);

-- Location: FF_X72_Y71_N5
\current_state.S93\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~99_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S93~q\);

-- Location: LCCOMB_X69_Y71_N24
\current_state~100\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~100_combout\ = (\current_state.S93~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \current_state.S93~q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~100_combout\);

-- Location: FF_X72_Y71_N15
\current_state.IDLE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state~100_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.IDLE~q\);

-- Location: LCCOMB_X70_Y71_N10
\current_state.S0~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state.S0~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \current_state.S0~feeder_combout\);

-- Location: FF_X70_Y71_N11
\current_state.S0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state.S0~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S0~q\);

-- Location: LCCOMB_X70_Y71_N24
\current_state.S1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state.S1~0_combout\ = !\current_state.S0~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \current_state.S0~q\,
	combout => \current_state.S1~0_combout\);

-- Location: FF_X70_Y71_N25
\current_state.S1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state.S1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S1~q\);

-- Location: FF_X69_Y71_N9
\current_state.S2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state.S1~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S2~q\);

-- Location: FF_X70_Y71_N31
\current_state.S3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state.S2~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S3~q\);

-- Location: LCCOMB_X72_Y71_N10
\Selector0~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~11_combout\ = (\current_state.S86~q\) # ((\current_state.S88~q\) # ((\current_state.S82~q\) # (\current_state.S84~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S86~q\,
	datab => \current_state.S88~q\,
	datac => \current_state.S82~q\,
	datad => \current_state.S84~q\,
	combout => \Selector0~11_combout\);

-- Location: LCCOMB_X72_Y71_N30
\Selector0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~12_combout\ = (\current_state.S92~q\) # ((\current_state.S90~q\) # ((\current_state.S93~q\) # (\Selector0~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S92~q\,
	datab => \current_state.S90~q\,
	datac => \current_state.S93~q\,
	datad => \Selector0~11_combout\,
	combout => \Selector0~12_combout\);

-- Location: LCCOMB_X74_Y72_N16
\Selector0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~10_combout\ = (\current_state.S80~q\) # ((\current_state.S74~q\) # ((\current_state.S76~q\) # (\current_state.S78~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S80~q\,
	datab => \current_state.S74~q\,
	datac => \current_state.S76~q\,
	datad => \current_state.S78~q\,
	combout => \Selector0~10_combout\);

-- Location: LCCOMB_X74_Y72_N30
\Selector0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~3_combout\ = (\current_state.S36~q\) # ((\current_state.S34~q\) # ((\current_state.S38~q\) # (\current_state.S40~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S36~q\,
	datab => \current_state.S34~q\,
	datac => \current_state.S38~q\,
	datad => \current_state.S40~q\,
	combout => \Selector0~3_combout\);

-- Location: LCCOMB_X74_Y71_N18
\Selector0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~2_combout\ = (\current_state.S26~q\) # ((\current_state.S32~q\) # ((\current_state.S28~q\) # (\current_state.S30~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S26~q\,
	datab => \current_state.S32~q\,
	datac => \current_state.S28~q\,
	datad => \current_state.S30~q\,
	combout => \Selector0~2_combout\);

-- Location: LCCOMB_X76_Y71_N16
\Selector0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~1_combout\ = (\current_state.S22~q\) # ((\current_state.S20~q\) # ((\current_state.S24~q\) # (\current_state.S18~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S22~q\,
	datab => \current_state.S20~q\,
	datac => \current_state.S24~q\,
	datad => \current_state.S18~q\,
	combout => \Selector0~1_combout\);

-- Location: LCCOMB_X76_Y71_N28
\Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = (\current_state.S10~q\) # ((\current_state.S12~q\) # ((\current_state.S16~q\) # (\current_state.S14~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S10~q\,
	datab => \current_state.S12~q\,
	datac => \current_state.S16~q\,
	datad => \current_state.S14~q\,
	combout => \Selector0~0_combout\);

-- Location: LCCOMB_X74_Y71_N8
\Selector0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~4_combout\ = (\Selector0~3_combout\) # ((\Selector0~2_combout\) # ((\Selector0~1_combout\) # (\Selector0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector0~3_combout\,
	datab => \Selector0~2_combout\,
	datac => \Selector0~1_combout\,
	datad => \Selector0~0_combout\,
	combout => \Selector0~4_combout\);

-- Location: LCCOMB_X74_Y71_N26
\Selector0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~6_combout\ = (\current_state.S52~q\) # ((\current_state.S50~q\) # ((\current_state.S54~q\) # (\current_state.S56~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S52~q\,
	datab => \current_state.S50~q\,
	datac => \current_state.S54~q\,
	datad => \current_state.S56~q\,
	combout => \Selector0~6_combout\);

-- Location: LCCOMB_X73_Y72_N30
\Selector0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~5_combout\ = (\current_state.S46~q\) # ((\current_state.S44~q\) # ((\current_state.S42~q\) # (\current_state.S48~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S46~q\,
	datab => \current_state.S44~q\,
	datac => \current_state.S42~q\,
	datad => \current_state.S48~q\,
	combout => \Selector0~5_combout\);

-- Location: LCCOMB_X75_Y71_N12
\Selector0~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~7_combout\ = (\current_state.S58~q\) # ((\current_state.S62~q\) # ((\current_state.S64~q\) # (\current_state.S60~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S58~q\,
	datab => \current_state.S62~q\,
	datac => \current_state.S64~q\,
	datad => \current_state.S60~q\,
	combout => \Selector0~7_combout\);

-- Location: LCCOMB_X74_Y70_N18
\Selector0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~8_combout\ = (\current_state.S70~q\) # ((\current_state.S66~q\) # ((\current_state.S68~q\) # (\current_state.S72~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S70~q\,
	datab => \current_state.S66~q\,
	datac => \current_state.S68~q\,
	datad => \current_state.S72~q\,
	combout => \Selector0~8_combout\);

-- Location: LCCOMB_X74_Y71_N16
\Selector0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~9_combout\ = (\Selector0~6_combout\) # ((\Selector0~5_combout\) # ((\Selector0~7_combout\) # (\Selector0~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector0~6_combout\,
	datab => \Selector0~5_combout\,
	datac => \Selector0~7_combout\,
	datad => \Selector0~8_combout\,
	combout => \Selector0~9_combout\);

-- Location: LCCOMB_X74_Y71_N22
\Selector0~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~13_combout\ = (\Selector0~12_combout\) # ((\Selector0~10_combout\) # ((\Selector0~4_combout\) # (\Selector0~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector0~12_combout\,
	datab => \Selector0~10_combout\,
	datac => \Selector0~4_combout\,
	datad => \Selector0~9_combout\,
	combout => \Selector0~13_combout\);

-- Location: LCCOMB_X72_Y71_N20
\Selector7~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~5_combout\ = (!\current_state.S89~q\ & (!\current_state.S83~q\ & (!\current_state.S79~q\ & !\current_state.S85~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S89~q\,
	datab => \current_state.S83~q\,
	datac => \current_state.S79~q\,
	datad => \current_state.S85~q\,
	combout => \Selector7~5_combout\);

-- Location: LCCOMB_X73_Y71_N30
\Selector7~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~6_combout\ = (!\current_state.S91~q\ & \Selector7~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \current_state.S91~q\,
	datad => \Selector7~5_combout\,
	combout => \Selector7~6_combout\);

-- Location: LCCOMB_X74_Y70_N0
\Selector7~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~3_combout\ = (!\current_state.S77~q\ & (!\current_state.S73~q\ & (!\current_state.S71~q\ & !\current_state.S67~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S77~q\,
	datab => \current_state.S73~q\,
	datac => \current_state.S71~q\,
	datad => \current_state.S67~q\,
	combout => \Selector7~3_combout\);

-- Location: LCCOMB_X73_Y70_N0
\Selector7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~1_combout\ = (!\current_state.S53~q\ & (!\current_state.S43~q\ & (!\current_state.S47~q\ & !\current_state.S49~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S53~q\,
	datab => \current_state.S43~q\,
	datac => \current_state.S47~q\,
	datad => \current_state.S49~q\,
	combout => \Selector7~1_combout\);

-- Location: LCCOMB_X75_Y71_N26
\Selector7~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~2_combout\ = (!\current_state.S65~q\ & (!\current_state.S61~q\ & (!\current_state.S59~q\ & !\current_state.S55~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S65~q\,
	datab => \current_state.S61~q\,
	datac => \current_state.S59~q\,
	datad => \current_state.S55~q\,
	combout => \Selector7~2_combout\);

-- Location: LCCOMB_X74_Y72_N28
\Selector7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = (!\current_state.S41~q\ & (!\current_state.S35~q\ & (!\current_state.S37~q\ & !\current_state.S31~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S41~q\,
	datab => \current_state.S35~q\,
	datac => \current_state.S37~q\,
	datad => \current_state.S31~q\,
	combout => \Selector7~0_combout\);

-- Location: LCCOMB_X73_Y71_N22
\Selector7~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~4_combout\ = (\Selector7~3_combout\ & (\Selector7~1_combout\ & (\Selector7~2_combout\ & \Selector7~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector7~3_combout\,
	datab => \Selector7~1_combout\,
	datac => \Selector7~2_combout\,
	datad => \Selector7~0_combout\,
	combout => \Selector7~4_combout\);

-- Location: LCCOMB_X76_Y71_N20
\Selector7~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~8_combout\ = (!\current_state.S13~q\ & (!\current_state.S17~q\ & (!\current_state.S11~q\ & !\current_state.S19~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S13~q\,
	datab => \current_state.S17~q\,
	datac => \current_state.S11~q\,
	datad => \current_state.S19~q\,
	combout => \Selector7~8_combout\);

-- Location: LCCOMB_X73_Y71_N10
\Selector7~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~9_combout\ = (!\current_state.S29~q\ & (!\current_state.S23~q\ & (!\current_state.S25~q\ & \Selector7~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S29~q\,
	datab => \current_state.S23~q\,
	datac => \current_state.S25~q\,
	datad => \Selector7~8_combout\,
	combout => \Selector7~9_combout\);

-- Location: LCCOMB_X73_Y71_N12
\Selector7~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~10_combout\ = (\Selector7~6_combout\ & (\Selector8~5_combout\ & (\Selector7~4_combout\ & \Selector7~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector7~6_combout\,
	datab => \Selector8~5_combout\,
	datac => \Selector7~4_combout\,
	datad => \Selector7~9_combout\,
	combout => \Selector7~10_combout\);

-- Location: LCCOMB_X74_Y71_N20
\Selector0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~14_combout\ = (!\ps2_code[4]~reg0_q\ & (\Equal8~0_combout\ & ((\Selector0~13_combout\) # (!\Selector7~10_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \Selector0~13_combout\,
	datad => \Selector7~10_combout\,
	combout => \Selector0~14_combout\);

-- Location: LCCOMB_X74_Y71_N24
\Selector0~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector0~15_combout\ = (\current_state.IDLE~q\) # ((\current_state.S3~q\) # ((\Equal4~0_combout\ & \Selector0~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.IDLE~q\,
	datab => \current_state.S3~q\,
	datac => \Equal4~0_combout\,
	datad => \Selector0~14_combout\,
	combout => \Selector0~15_combout\);

-- Location: FF_X74_Y71_N25
\current_state.S4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector0~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S4~q\);

-- Location: FF_X70_Y71_N21
\current_state.S5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state.S4~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S5~q\);

-- Location: FF_X70_Y71_N3
\current_state.S6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state.S5~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S6~q\);

-- Location: FF_X70_Y71_N7
\current_state.S7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state.S6~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S7~q\);

-- Location: FF_X70_Y71_N23
\current_state.S8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state.S7~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S8~q\);

-- Location: FF_X73_Y71_N17
\current_state.S9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state.S8~q\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S9~q\);

-- Location: LCCOMB_X76_Y71_N30
\current_state~156\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~156_combout\ = (\current_state.S9~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S9~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~156_combout\);

-- Location: FF_X76_Y71_N31
\current_state.S10\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~156_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S10~q\);

-- Location: LCCOMB_X76_Y71_N4
\current_state~135\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~135_combout\ = (\current_state.S10~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \current_state.S10~q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~135_combout\);

-- Location: FF_X76_Y71_N5
\current_state.S11\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~135_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S11~q\);

-- Location: LCCOMB_X76_Y71_N8
\current_state~157\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~157_combout\ = (\current_state.S11~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S11~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~157_combout\);

-- Location: FF_X76_Y71_N9
\current_state.S12\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~157_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S12~q\);

-- Location: LCCOMB_X76_Y71_N26
\current_state~136\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~136_combout\ = (\current_state.S12~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S12~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~136_combout\);

-- Location: FF_X76_Y71_N27
\current_state.S13\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~136_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S13~q\);

-- Location: LCCOMB_X76_Y71_N10
\current_state~143\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~143_combout\ = (\current_state.S13~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S13~q\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~143_combout\);

-- Location: FF_X76_Y71_N11
\current_state.S14\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~143_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S14~q\);

-- Location: LCCOMB_X73_Y71_N6
\current_state~101\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~101_combout\ = (\current_state.S14~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal4~0_combout\,
	datac => \current_state.S14~q\,
	datad => \Equal8~0_combout\,
	combout => \current_state~101_combout\);

-- Location: FF_X73_Y71_N7
\current_state.S15\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~101_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S15~q\);

-- Location: LCCOMB_X76_Y71_N14
\current_state~158\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~158_combout\ = (\current_state.S15~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S15~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~158_combout\);

-- Location: FF_X76_Y71_N15
\current_state.S16\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~158_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S16~q\);

-- Location: LCCOMB_X76_Y71_N24
\current_state~137\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~137_combout\ = (\current_state.S16~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S16~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~137_combout\);

-- Location: FF_X76_Y71_N25
\current_state.S17\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~137_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S17~q\);

-- Location: LCCOMB_X76_Y71_N18
\current_state~159\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~159_combout\ = (\current_state.S17~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S17~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~159_combout\);

-- Location: FF_X76_Y71_N19
\current_state.S18\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~159_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S18~q\);

-- Location: LCCOMB_X76_Y71_N2
\current_state~138\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~138_combout\ = (\current_state.S18~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S18~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~138_combout\);

-- Location: FF_X76_Y71_N3
\current_state.S19\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~138_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S19~q\);

-- Location: LCCOMB_X76_Y71_N0
\current_state~144\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~144_combout\ = (\current_state.S19~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S19~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~144_combout\);

-- Location: FF_X76_Y71_N1
\current_state.S20\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~144_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S20~q\);

-- Location: LCCOMB_X73_Y71_N20
\current_state~102\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~102_combout\ = (\current_state.S20~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \current_state.S20~q\,
	combout => \current_state~102_combout\);

-- Location: FF_X73_Y71_N21
\current_state.S21\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~102_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S21~q\);

-- Location: LCCOMB_X76_Y71_N12
\current_state~160\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~160_combout\ = (\current_state.S21~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S21~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~160_combout\);

-- Location: FF_X76_Y71_N13
\current_state.S22\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~160_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S22~q\);

-- Location: LCCOMB_X73_Y71_N28
\current_state~139\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~139_combout\ = (\current_state.S22~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \current_state.S22~q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~139_combout\);

-- Location: FF_X73_Y71_N29
\current_state.S23\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~139_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S23~q\);

-- Location: LCCOMB_X76_Y71_N22
\current_state~161\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~161_combout\ = (\current_state.S23~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S23~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~161_combout\);

-- Location: FF_X76_Y71_N23
\current_state.S24\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~161_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S24~q\);

-- Location: LCCOMB_X73_Y71_N14
\current_state~140\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~140_combout\ = (\current_state.S24~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \current_state.S24~q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~140_combout\);

-- Location: FF_X73_Y71_N15
\current_state.S25\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~140_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S25~q\);

-- Location: LCCOMB_X74_Y71_N6
\current_state~145\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~145_combout\ = (\current_state.S25~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S25~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~145_combout\);

-- Location: FF_X74_Y71_N7
\current_state.S26\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~145_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S26~q\);

-- Location: LCCOMB_X73_Y71_N26
\current_state~103\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~103_combout\ = (\current_state.S26~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal4~0_combout\,
	datac => \current_state.S26~q\,
	datad => \Equal8~0_combout\,
	combout => \current_state~103_combout\);

-- Location: FF_X73_Y71_N27
\current_state.S27\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~103_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S27~q\);

-- Location: LCCOMB_X74_Y71_N14
\current_state~162\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~162_combout\ = (\current_state.S27~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal4~0_combout\,
	datac => \current_state.S27~q\,
	datad => \Equal8~0_combout\,
	combout => \current_state~162_combout\);

-- Location: FF_X74_Y71_N15
\current_state.S28\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~162_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S28~q\);

-- Location: LCCOMB_X74_Y71_N10
\current_state~141\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~141_combout\ = (\current_state.S28~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S28~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~141_combout\);

-- Location: FF_X73_Y71_N9
\current_state.S29\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state~141_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S29~q\);

-- Location: LCCOMB_X74_Y71_N12
\current_state~163\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~163_combout\ = (\current_state.S29~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S29~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~163_combout\);

-- Location: FF_X74_Y71_N13
\current_state.S30\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~163_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S30~q\);

-- Location: LCCOMB_X74_Y72_N12
\current_state~114\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~114_combout\ = (\current_state.S30~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \current_state.S30~q\,
	combout => \current_state~114_combout\);

-- Location: FF_X74_Y72_N13
\current_state.S31\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~114_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S31~q\);

-- Location: LCCOMB_X74_Y71_N0
\current_state~146\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~146_combout\ = (\current_state.S31~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal4~0_combout\,
	datac => \current_state.S31~q\,
	datad => \Equal8~0_combout\,
	combout => \current_state~146_combout\);

-- Location: FF_X74_Y71_N1
\current_state.S32\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~146_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S32~q\);

-- Location: LCCOMB_X73_Y72_N24
\current_state~104\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~104_combout\ = (\current_state.S32~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S32~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~104_combout\);

-- Location: FF_X73_Y72_N25
\current_state.S33\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~104_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S33~q\);

-- Location: LCCOMB_X74_Y72_N0
\current_state~164\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~164_combout\ = (\current_state.S33~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \current_state.S33~q\,
	combout => \current_state~164_combout\);

-- Location: FF_X74_Y72_N1
\current_state.S34\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~164_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S34~q\);

-- Location: LCCOMB_X74_Y72_N18
\current_state~115\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~115_combout\ = (\current_state.S34~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S34~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~115_combout\);

-- Location: FF_X74_Y72_N19
\current_state.S35\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~115_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S35~q\);

-- Location: LCCOMB_X74_Y72_N6
\current_state~165\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~165_combout\ = (\current_state.S35~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \current_state.S35~q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~165_combout\);

-- Location: FF_X74_Y72_N7
\current_state.S36\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~165_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S36~q\);

-- Location: LCCOMB_X74_Y72_N4
\current_state~116\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~116_combout\ = (\current_state.S36~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S36~q\,
	datab => \Equal8~0_combout\,
	datac => \ps2_code[4]~reg0_q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~116_combout\);

-- Location: FF_X74_Y72_N5
\current_state.S37\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~116_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S37~q\);

-- Location: LCCOMB_X74_Y72_N14
\current_state~147\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~147_combout\ = (\current_state.S37~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S37~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~147_combout\);

-- Location: FF_X74_Y72_N15
\current_state.S38\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~147_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S38~q\);

-- Location: LCCOMB_X73_Y72_N22
\current_state~105\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~105_combout\ = (\current_state.S38~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S38~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~105_combout\);

-- Location: FF_X73_Y72_N23
\current_state.S39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~105_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S39~q\);

-- Location: LCCOMB_X74_Y72_N20
\current_state~166\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~166_combout\ = (\current_state.S39~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S39~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~166_combout\);

-- Location: FF_X74_Y72_N21
\current_state.S40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~166_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S40~q\);

-- Location: LCCOMB_X74_Y72_N22
\current_state~117\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~117_combout\ = (\current_state.S40~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \current_state.S40~q\,
	combout => \current_state~117_combout\);

-- Location: FF_X74_Y72_N23
\current_state.S41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~117_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S41~q\);

-- Location: LCCOMB_X73_Y72_N8
\current_state~167\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~167_combout\ = (\current_state.S41~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S41~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~167_combout\);

-- Location: FF_X73_Y72_N9
\current_state.S42\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~167_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S42~q\);

-- Location: LCCOMB_X73_Y70_N8
\current_state~118\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~118_combout\ = (\current_state.S42~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal8~0_combout\,
	datab => \current_state.S42~q\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~118_combout\);

-- Location: FF_X73_Y70_N9
\current_state.S43\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~118_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S43~q\);

-- Location: LCCOMB_X73_Y72_N14
\current_state~148\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~148_combout\ = (\current_state.S43~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S43~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~148_combout\);

-- Location: FF_X73_Y72_N15
\current_state.S44\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~148_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S44~q\);

-- Location: LCCOMB_X73_Y72_N4
\current_state~106\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~106_combout\ = (\current_state.S44~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S44~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~106_combout\);

-- Location: FF_X73_Y72_N5
\current_state.S45\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~106_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S45~q\);

-- Location: LCCOMB_X73_Y72_N6
\current_state~168\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~168_combout\ = (\current_state.S45~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S45~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~168_combout\);

-- Location: FF_X73_Y72_N7
\current_state.S46\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~168_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S46~q\);

-- Location: LCCOMB_X73_Y70_N30
\current_state~119\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~119_combout\ = (\current_state.S46~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal8~0_combout\,
	datab => \current_state.S46~q\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~119_combout\);

-- Location: FF_X73_Y70_N31
\current_state.S47\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~119_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S47~q\);

-- Location: LCCOMB_X73_Y72_N16
\current_state~169\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~169_combout\ = (\current_state.S47~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S47~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~169_combout\);

-- Location: FF_X73_Y72_N17
\current_state.S48\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~169_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S48~q\);

-- Location: LCCOMB_X73_Y70_N28
\current_state~120\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~120_combout\ = (\current_state.S48~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S48~q\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~120_combout\);

-- Location: FF_X73_Y70_N29
\current_state.S49\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~120_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S49~q\);

-- Location: LCCOMB_X74_Y71_N2
\current_state~149\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~149_combout\ = (\current_state.S49~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~0_combout\,
	datab => \current_state.S49~q\,
	datac => \Equal8~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~149_combout\);

-- Location: FF_X74_Y71_N3
\current_state.S50\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~149_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S50~q\);

-- Location: LCCOMB_X73_Y72_N18
\current_state~107\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~107_combout\ = (\current_state.S50~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S50~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~107_combout\);

-- Location: FF_X73_Y72_N19
\current_state.S51\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~107_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S51~q\);

-- Location: LCCOMB_X74_Y71_N30
\current_state~170\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~170_combout\ = (\current_state.S51~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S51~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~170_combout\);

-- Location: FF_X74_Y71_N31
\current_state.S52\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~170_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S52~q\);

-- Location: LCCOMB_X73_Y70_N6
\current_state~121\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~121_combout\ = (\current_state.S52~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal8~0_combout\,
	datab => \current_state.S52~q\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~121_combout\);

-- Location: FF_X73_Y70_N7
\current_state.S53\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~121_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S53~q\);

-- Location: LCCOMB_X74_Y71_N4
\current_state~171\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~171_combout\ = (\current_state.S53~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S53~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~171_combout\);

-- Location: FF_X74_Y71_N5
\current_state.S54\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~171_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S54~q\);

-- Location: LCCOMB_X75_Y71_N18
\current_state~122\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~122_combout\ = (\current_state.S54~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S54~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~122_combout\);

-- Location: FF_X75_Y71_N19
\current_state.S55\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~122_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S55~q\);

-- Location: LCCOMB_X74_Y71_N28
\current_state~150\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~150_combout\ = (\current_state.S55~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~0_combout\,
	datab => \current_state.S55~q\,
	datac => \Equal8~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~150_combout\);

-- Location: FF_X74_Y71_N29
\current_state.S56\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~150_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S56~q\);

-- Location: LCCOMB_X75_Y71_N24
\current_state~108\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~108_combout\ = (\current_state.S56~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S56~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~108_combout\);

-- Location: FF_X75_Y71_N25
\current_state.S57\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~108_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S57~q\);

-- Location: LCCOMB_X75_Y71_N30
\current_state~172\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~172_combout\ = (\current_state.S57~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S57~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~172_combout\);

-- Location: FF_X75_Y71_N31
\current_state.S58\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~172_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S58~q\);

-- Location: LCCOMB_X75_Y71_N4
\current_state~123\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~123_combout\ = (\current_state.S58~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S58~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~123_combout\);

-- Location: FF_X75_Y71_N5
\current_state.S59\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~123_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S59~q\);

-- Location: LCCOMB_X75_Y71_N16
\current_state~173\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~173_combout\ = (\current_state.S59~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal8~0_combout\,
	datab => \current_state.S59~q\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~173_combout\);

-- Location: FF_X75_Y71_N17
\current_state.S60\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~173_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S60~q\);

-- Location: LCCOMB_X75_Y71_N14
\current_state~124\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~124_combout\ = (\current_state.S60~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S60~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~124_combout\);

-- Location: FF_X75_Y71_N15
\current_state.S61\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~124_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S61~q\);

-- Location: LCCOMB_X75_Y71_N28
\current_state~151\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~151_combout\ = (\current_state.S61~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S61~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~151_combout\);

-- Location: FF_X75_Y71_N29
\current_state.S62\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~151_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S62~q\);

-- Location: LCCOMB_X75_Y71_N22
\current_state~109\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~109_combout\ = (\current_state.S62~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S62~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~109_combout\);

-- Location: FF_X75_Y71_N23
\current_state.S63\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~109_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S63~q\);

-- Location: LCCOMB_X75_Y71_N6
\current_state~174\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~174_combout\ = (\current_state.S63~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S63~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~174_combout\);

-- Location: FF_X75_Y71_N7
\current_state.S64\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~174_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S64~q\);

-- Location: LCCOMB_X75_Y71_N0
\current_state~125\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~125_combout\ = (\current_state.S64~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal4~0_combout\,
	datac => \current_state.S64~q\,
	datad => \Equal8~0_combout\,
	combout => \current_state~125_combout\);

-- Location: FF_X75_Y71_N1
\current_state.S65\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~125_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S65~q\);

-- Location: LCCOMB_X74_Y70_N20
\current_state~175\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~175_combout\ = (\current_state.S65~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S65~q\,
	datab => \Equal4~0_combout\,
	datac => \Equal8~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~175_combout\);

-- Location: FF_X74_Y70_N21
\current_state.S66\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~175_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S66~q\);

-- Location: LCCOMB_X74_Y70_N16
\current_state~126\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~126_combout\ = (\current_state.S66~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~0_combout\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \Equal8~0_combout\,
	datad => \current_state.S66~q\,
	combout => \current_state~126_combout\);

-- Location: FF_X74_Y70_N17
\current_state.S67\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~126_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S67~q\);

-- Location: LCCOMB_X74_Y70_N30
\current_state~152\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~152_combout\ = (\current_state.S67~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~0_combout\,
	datab => \current_state.S67~q\,
	datac => \Equal8~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~152_combout\);

-- Location: FF_X74_Y70_N31
\current_state.S68\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~152_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S68~q\);

-- Location: LCCOMB_X75_Y71_N8
\current_state~110\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~110_combout\ = (\current_state.S68~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S68~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~110_combout\);

-- Location: FF_X75_Y71_N9
\current_state.S69\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~110_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S69~q\);

-- Location: LCCOMB_X74_Y70_N26
\current_state~176\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~176_combout\ = (\current_state.S69~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S69~q\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~176_combout\);

-- Location: FF_X74_Y70_N27
\current_state.S70\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~176_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S70~q\);

-- Location: LCCOMB_X74_Y70_N14
\current_state~127\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~127_combout\ = (\current_state.S70~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S70~q\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~127_combout\);

-- Location: FF_X74_Y70_N15
\current_state.S71\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~127_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S71~q\);

-- Location: LCCOMB_X74_Y70_N24
\current_state~177\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~177_combout\ = (\current_state.S71~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S71~q\,
	datab => \Equal4~0_combout\,
	datac => \Equal8~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~177_combout\);

-- Location: FF_X74_Y70_N25
\current_state.S72\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~177_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S72~q\);

-- Location: LCCOMB_X74_Y70_N28
\current_state~128\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~128_combout\ = (\current_state.S72~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~0_combout\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \Equal8~0_combout\,
	datad => \current_state.S72~q\,
	combout => \current_state~128_combout\);

-- Location: FF_X74_Y70_N29
\current_state.S73\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~128_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S73~q\);

-- Location: LCCOMB_X74_Y72_N24
\current_state~153\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~153_combout\ = (\current_state.S73~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S73~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~153_combout\);

-- Location: FF_X74_Y72_N25
\current_state.S74\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~153_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S74~q\);

-- Location: LCCOMB_X75_Y71_N10
\current_state~111\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~111_combout\ = (\current_state.S74~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S74~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~111_combout\);

-- Location: FF_X75_Y71_N11
\current_state.S75\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~111_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S75~q\);

-- Location: LCCOMB_X74_Y72_N8
\current_state~178\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~178_combout\ = (\current_state.S75~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \current_state.S75~q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~178_combout\);

-- Location: FF_X74_Y72_N9
\current_state.S76\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~178_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S76~q\);

-- Location: LCCOMB_X74_Y70_N22
\current_state~129\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~129_combout\ = (\current_state.S76~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~0_combout\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \Equal8~0_combout\,
	datad => \current_state.S76~q\,
	combout => \current_state~129_combout\);

-- Location: FF_X74_Y70_N23
\current_state.S77\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~129_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S77~q\);

-- Location: LCCOMB_X74_Y72_N10
\current_state~179\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~179_combout\ = (\current_state.S77~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S77~q\,
	datac => \Equal8~0_combout\,
	datad => \Equal4~0_combout\,
	combout => \current_state~179_combout\);

-- Location: FF_X74_Y72_N11
\current_state.S78\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~179_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S78~q\);

-- Location: LCCOMB_X72_Y71_N8
\current_state~130\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~130_combout\ = (\current_state.S78~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S78~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~130_combout\);

-- Location: FF_X72_Y71_N9
\current_state.S79\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S79~q\);

-- Location: LCCOMB_X74_Y72_N26
\current_state~154\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~154_combout\ = (\current_state.S79~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal8~0_combout\)) # (!\Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~0_combout\,
	datab => \current_state.S79~q\,
	datac => \Equal8~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~154_combout\);

-- Location: FF_X74_Y72_N27
\current_state.S80\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~154_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S80~q\);

-- Location: LCCOMB_X72_Y71_N0
\current_state~112\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~112_combout\ = (\current_state.S80~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S80~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~112_combout\);

-- Location: FF_X72_Y71_N1
\current_state.S81\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~112_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S81~q\);

-- Location: LCCOMB_X69_Y71_N6
\current_state~180\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~180_combout\ = (\current_state.S81~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal4~0_combout\) # (!\Equal8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \Equal8~0_combout\,
	datac => \current_state.S81~q\,
	datad => \Equal4~0_combout\,
	combout => \current_state~180_combout\);

-- Location: FF_X72_Y71_N11
\current_state.S82\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	asdata => \current_state~180_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S82~q\);

-- Location: LCCOMB_X72_Y71_N26
\current_state~131\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~131_combout\ = (\current_state.S82~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S82~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~131_combout\);

-- Location: FF_X72_Y71_N27
\current_state.S83\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S83~q\);

-- Location: LCCOMB_X72_Y71_N16
\current_state~181\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~181_combout\ = (\current_state.S83~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S83~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~181_combout\);

-- Location: FF_X72_Y71_N17
\current_state.S84\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~181_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S84~q\);

-- Location: LCCOMB_X72_Y71_N28
\current_state~132\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~132_combout\ = (\current_state.S84~q\ & ((\ps2_code[4]~reg0_q\) # ((!\Equal8~0_combout\) # (!\Equal4~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \current_state.S84~q\,
	datac => \Equal4~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \current_state~132_combout\);

-- Location: FF_X72_Y71_N29
\current_state.S85\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S85~q\);

-- Location: LCCOMB_X72_Y71_N12
\current_state~155\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~155_combout\ = (\current_state.S85~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S85~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~155_combout\);

-- Location: FF_X72_Y71_N13
\current_state.S86\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~155_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S86~q\);

-- Location: LCCOMB_X72_Y71_N18
\current_state~113\ : cycloneive_lcell_comb
-- Equation(s):
-- \current_state~113_combout\ = (\current_state.S86~q\ & (((\ps2_code[4]~reg0_q\) # (!\Equal4~0_combout\)) # (!\Equal8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S86~q\,
	datab => \Equal8~0_combout\,
	datac => \Equal4~0_combout\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \current_state~113_combout\);

-- Location: FF_X72_Y71_N19
\current_state.S87\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \current_state~113_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_state.S87~q\);

-- Location: LCCOMB_X72_Y71_N14
\Selector8~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector8~4_combout\ = (!\current_state.S87~q\ & !\current_state.S81~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \current_state.S87~q\,
	datad => \current_state.S81~q\,
	combout => \Selector8~4_combout\);

-- Location: LCCOMB_X73_Y71_N16
\Selector8~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector8~1_combout\ = (!\current_state.S27~q\ & (!\current_state.S21~q\ & (!\current_state.S9~q\ & !\current_state.S15~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S27~q\,
	datab => \current_state.S21~q\,
	datac => \current_state.S9~q\,
	datad => \current_state.S15~q\,
	combout => \Selector8~1_combout\);

-- Location: LCCOMB_X75_Y71_N20
\Selector8~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector8~3_combout\ = (!\current_state.S75~q\ & (!\current_state.S69~q\ & (!\current_state.S63~q\ & !\current_state.S57~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S75~q\,
	datab => \current_state.S69~q\,
	datac => \current_state.S63~q\,
	datad => \current_state.S57~q\,
	combout => \Selector8~3_combout\);

-- Location: LCCOMB_X73_Y72_N28
\Selector8~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector8~2_combout\ = (!\current_state.S39~q\ & (!\current_state.S51~q\ & (!\current_state.S45~q\ & !\current_state.S33~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S39~q\,
	datab => \current_state.S51~q\,
	datac => \current_state.S45~q\,
	datad => \current_state.S33~q\,
	combout => \Selector8~2_combout\);

-- Location: LCCOMB_X73_Y71_N4
\Selector8~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector8~5_combout\ = (\Selector8~4_combout\ & (\Selector8~1_combout\ & (\Selector8~3_combout\ & \Selector8~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector8~4_combout\,
	datab => \Selector8~1_combout\,
	datac => \Selector8~3_combout\,
	datad => \Selector8~2_combout\,
	combout => \Selector8~5_combout\);

-- Location: LCCOMB_X70_Y71_N22
\WideOr11~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \WideOr11~0_combout\ = (!\current_state.S6~q\ & (!\current_state.S7~q\ & !\current_state.S4~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S6~q\,
	datab => \current_state.S7~q\,
	datad => \current_state.S4~q\,
	combout => \WideOr11~0_combout\);

-- Location: LCCOMB_X70_Y71_N18
\Selector8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector8~0_combout\ = (\current_state.S1~q\) # ((\LCD_ENABLE~reg0_q\ & ((\current_state.IDLE~q\) # (\current_state.S93~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LCD_ENABLE~reg0_q\,
	datab => \current_state.S1~q\,
	datac => \current_state.IDLE~q\,
	datad => \current_state.S93~q\,
	combout => \Selector8~0_combout\);

-- Location: LCCOMB_X70_Y71_N26
\Selector8~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector8~6_combout\ = ((\Selector8~0_combout\) # (!\WideOr11~0_combout\)) # (!\Selector8~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Selector8~5_combout\,
	datac => \WideOr11~0_combout\,
	datad => \Selector8~0_combout\,
	combout => \Selector8~6_combout\);

-- Location: FF_X70_Y71_N27
\LCD_ENABLE~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector8~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_ENABLE~reg0_q\);

-- Location: LCCOMB_X70_Y71_N6
\WideOr11~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \WideOr11~2_combout\ = (!\current_state.S2~q\ & (!\current_state.S1~q\ & \current_state.S0~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S2~q\,
	datab => \current_state.S1~q\,
	datad => \current_state.S0~q\,
	combout => \WideOr11~2_combout\);

-- Location: LCCOMB_X72_Y71_N22
\WideOr11~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \WideOr11~1_combout\ = (!\current_state.S93~q\ & !\current_state.IDLE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \current_state.S93~q\,
	datad => \current_state.IDLE~q\,
	combout => \WideOr11~1_combout\);

-- Location: LCCOMB_X70_Y71_N20
\WideOr11~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \WideOr11~3_combout\ = (\WideOr11~2_combout\ & (!\current_state.S3~q\ & (!\current_state.S5~q\ & \WideOr11~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr11~2_combout\,
	datab => \current_state.S3~q\,
	datac => \current_state.S5~q\,
	datad => \WideOr11~1_combout\,
	combout => \WideOr11~3_combout\);

-- Location: LCCOMB_X70_Y71_N28
\WideOr11~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \WideOr11~4_combout\ = (\WideOr11~0_combout\ & (\WideOr11~3_combout\ & (\Selector7~6_combout\ & \Selector7~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr11~0_combout\,
	datab => \WideOr11~3_combout\,
	datac => \Selector7~6_combout\,
	datad => \Selector7~4_combout\,
	combout => \WideOr11~4_combout\);

-- Location: LCCOMB_X70_Y71_N0
\Selector9~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector9~2_combout\ = (\WideOr11~4_combout\) # ((\LCD_RS~reg0_q\ & ((\current_state.S93~q\) # (\current_state.IDLE~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S93~q\,
	datab => \current_state.IDLE~q\,
	datac => \LCD_RS~reg0_q\,
	datad => \WideOr11~4_combout\,
	combout => \Selector9~2_combout\);

-- Location: FF_X70_Y71_N1
\LCD_RS~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector9~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_RS~reg0_q\);

-- Location: LCCOMB_X70_Y71_N2
\WideOr11~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \WideOr11~5_combout\ = (!\current_state.S3~q\ & !\current_state.S5~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S3~q\,
	datac => \current_state.S5~q\,
	combout => \WideOr11~5_combout\);

-- Location: LCCOMB_X68_Y71_N2
\Selector7~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~7_combout\ = (\current_state.S4~q\) # ((\LCD_DATA[0]~reg0_q\ & ((\current_state.IDLE~q\) # (\current_state.S93~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.IDLE~q\,
	datab => \LCD_DATA[0]~reg0_q\,
	datac => \current_state.S93~q\,
	datad => \current_state.S4~q\,
	combout => \Selector7~7_combout\);

-- Location: LCCOMB_X68_Y71_N28
\Equal2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal2~0_combout\ = (!\ps2_code[7]~reg0_q\ & (\ps2_code[6]~reg0_q\ & \ps2_code[5]~reg0_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ps2_code[7]~reg0_q\,
	datac => \ps2_code[6]~reg0_q\,
	datad => \ps2_code[5]~reg0_q\,
	combout => \Equal2~0_combout\);

-- Location: LCCOMB_X68_Y71_N0
\Equal4~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal4~1_combout\ = (\ps2_code[4]~reg0_q\ & !\ps2_code[2]~reg0_q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ps2_code[4]~reg0_q\,
	datad => \ps2_code[2]~reg0_q\,
	combout => \Equal4~1_combout\);

-- Location: LCCOMB_X68_Y71_N30
\Equal13~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal13~0_combout\ = (\ps2_code[0]~reg0_q\ & (\ps2_code[3]~reg0_q\ & (\Equal4~0_combout\ & \Equal4~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[0]~reg0_q\,
	datab => \ps2_code[3]~reg0_q\,
	datac => \Equal4~0_combout\,
	datad => \Equal4~1_combout\,
	combout => \Equal13~0_combout\);

-- Location: LCCOMB_X68_Y71_N26
\Equal17~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal17~0_combout\ = (((\ps2_code[1]~reg0_q\) # (\ps2_code[7]~reg0_q\)) # (!\ps2_code[4]~reg0_q\)) # (!\ps2_code[5]~reg0_q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[5]~reg0_q\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \ps2_code[7]~reg0_q\,
	combout => \Equal17~0_combout\);

-- Location: LCCOMB_X68_Y71_N18
\Equal17~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal17~1_combout\ = (\ps2_code[6]~reg0_q\) # ((\Equal17~0_combout\) # (!\Equal8~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[6]~reg0_q\,
	datac => \Equal17~0_combout\,
	datad => \Equal8~0_combout\,
	combout => \Equal17~1_combout\);

-- Location: LCCOMB_X68_Y71_N22
\Equal15~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal15~1_combout\ = (\ps2_code[3]~reg0_q\ & (!\ps2_code[7]~reg0_q\ & (\ps2_code[6]~reg0_q\ & !\ps2_code[2]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[3]~reg0_q\,
	datab => \ps2_code[7]~reg0_q\,
	datac => \ps2_code[6]~reg0_q\,
	datad => \ps2_code[2]~reg0_q\,
	combout => \Equal15~1_combout\);

-- Location: LCCOMB_X68_Y71_N16
\Equal15~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal15~0_combout\ = (!\ps2_code[0]~reg0_q\ & (!\ps2_code[4]~reg0_q\ & (\ps2_code[1]~reg0_q\ & !\ps2_code[5]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[0]~reg0_q\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \ps2_code[5]~reg0_q\,
	combout => \Equal15~0_combout\);

-- Location: LCCOMB_X68_Y71_N8
\Equal15~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal15~2_combout\ = (\Equal15~1_combout\ & \Equal15~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \Equal15~1_combout\,
	datad => \Equal15~0_combout\,
	combout => \Equal15~2_combout\);

-- Location: LCCOMB_X67_Y71_N22
\Equal16~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal16~0_combout\ = (\ps2_code[4]~reg0_q\ & (!\ps2_code[1]~reg0_q\ & \ps2_code[2]~reg0_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ps2_code[4]~reg0_q\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \ps2_code[2]~reg0_q\,
	combout => \Equal16~0_combout\);

-- Location: LCCOMB_X67_Y71_N20
\Equal16~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal16~1_combout\ = (\ps2_code[0]~reg0_q\ & (!\ps2_code[7]~reg0_q\ & (!\ps2_code[3]~reg0_q\ & \ps2_code[6]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[0]~reg0_q\,
	datab => \ps2_code[7]~reg0_q\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \ps2_code[6]~reg0_q\,
	combout => \Equal16~1_combout\);

-- Location: LCCOMB_X67_Y71_N18
\Equal16~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal16~2_combout\ = (!\ps2_code[5]~reg0_q\ & (\Equal16~0_combout\ & \Equal16~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ps2_code[5]~reg0_q\,
	datac => \Equal16~0_combout\,
	datad => \Equal16~1_combout\,
	combout => \Equal16~2_combout\);

-- Location: LCCOMB_X68_Y71_N24
\LCD_DATA~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~0_combout\ = (\Equal13~0_combout\) # (((\Equal15~2_combout\) # (\Equal16~2_combout\)) # (!\Equal17~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal13~0_combout\,
	datab => \Equal17~1_combout\,
	datac => \Equal15~2_combout\,
	datad => \Equal16~2_combout\,
	combout => \LCD_DATA~0_combout\);

-- Location: LCCOMB_X69_Y71_N8
\LCD_DATA~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~3_combout\ = (\ps2_code[3]~reg0_q\ & ((\ps2_code[4]~reg0_q\) # (!\ps2_code[0]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[3]~reg0_q\,
	datab => \ps2_code[4]~reg0_q\,
	datad => \ps2_code[0]~reg0_q\,
	combout => \LCD_DATA~3_combout\);

-- Location: LCCOMB_X69_Y71_N22
\LCD_DATA~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~1_combout\ = (\ps2_code[1]~reg0_q\ & (!\ps2_code[2]~reg0_q\ & (\ps2_code[4]~reg0_q\ & !\ps2_code[0]~reg0_q\))) # (!\ps2_code[1]~reg0_q\ & (\ps2_code[0]~reg0_q\ $ (((\ps2_code[2]~reg0_q\ & !\ps2_code[4]~reg0_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000101000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[2]~reg0_q\,
	datab => \ps2_code[1]~reg0_q\,
	datac => \ps2_code[4]~reg0_q\,
	datad => \ps2_code[0]~reg0_q\,
	combout => \LCD_DATA~1_combout\);

-- Location: LCCOMB_X68_Y71_N6
\LCD_DATA~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~15_combout\ = (\ps2_code[2]~reg0_q\ & (\ps2_code[1]~reg0_q\ & ((\LCD_DATA~0_combout\)))) # (!\ps2_code[2]~reg0_q\ & ((\LCD_DATA~0_combout\) # ((\ps2_code[1]~reg0_q\ & \ps2_code[4]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[2]~reg0_q\,
	datab => \ps2_code[1]~reg0_q\,
	datac => \ps2_code[4]~reg0_q\,
	datad => \LCD_DATA~0_combout\,
	combout => \LCD_DATA~15_combout\);

-- Location: LCCOMB_X68_Y71_N10
\LCD_DATA~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~2_combout\ = (\ps2_code[3]~reg0_q\ & (((\LCD_DATA~1_combout\)))) # (!\ps2_code[3]~reg0_q\ & (\ps2_code[0]~reg0_q\ & ((\LCD_DATA~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[0]~reg0_q\,
	datab => \LCD_DATA~1_combout\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \LCD_DATA~15_combout\,
	combout => \LCD_DATA~2_combout\);

-- Location: LCCOMB_X68_Y71_N14
\LCD_DATA~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~4_combout\ = (\Equal2~0_combout\ & ((\LCD_DATA~2_combout\) # ((\LCD_DATA~0_combout\ & \LCD_DATA~3_combout\)))) # (!\Equal2~0_combout\ & (\LCD_DATA~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal2~0_combout\,
	datab => \LCD_DATA~0_combout\,
	datac => \LCD_DATA~3_combout\,
	datad => \LCD_DATA~2_combout\,
	combout => \LCD_DATA~4_combout\);

-- Location: LCCOMB_X68_Y71_N4
\Selector7~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector7~11_combout\ = ((\Selector7~7_combout\) # ((\LCD_DATA~4_combout\ & !\Selector7~10_combout\))) # (!\WideOr11~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr11~5_combout\,
	datab => \Selector7~7_combout\,
	datac => \LCD_DATA~4_combout\,
	datad => \Selector7~10_combout\,
	combout => \Selector7~11_combout\);

-- Location: FF_X68_Y71_N5
\LCD_DATA[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector7~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_DATA[0]~reg0_q\);

-- Location: LCCOMB_X69_Y71_N30
\LCD_DATA~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~6_combout\ = (\ps2_code[4]~reg0_q\ & ((\ps2_code[2]~reg0_q\ & ((!\ps2_code[0]~reg0_q\))) # (!\ps2_code[2]~reg0_q\ & (\ps2_code[3]~reg0_q\ & \ps2_code[0]~reg0_q\)))) # (!\ps2_code[4]~reg0_q\ & (((\ps2_code[3]~reg0_q\ & !\ps2_code[0]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \ps2_code[2]~reg0_q\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \ps2_code[0]~reg0_q\,
	combout => \LCD_DATA~6_combout\);

-- Location: LCCOMB_X69_Y71_N4
\LCD_DATA~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~5_combout\ = (!\ps2_code[2]~reg0_q\ & (!\ps2_code[0]~reg0_q\ & ((\ps2_code[4]~reg0_q\) # (\ps2_code[3]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \ps2_code[2]~reg0_q\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \ps2_code[0]~reg0_q\,
	combout => \LCD_DATA~5_combout\);

-- Location: LCCOMB_X69_Y71_N0
\LCD_DATA~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~7_combout\ = (\ps2_code[1]~reg0_q\ & (\LCD_DATA~5_combout\ & (\LCD_DATA~6_combout\ $ (\ps2_code[5]~reg0_q\)))) # (!\ps2_code[1]~reg0_q\ & (\LCD_DATA~6_combout\ & (\ps2_code[5]~reg0_q\ & !\LCD_DATA~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100100000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LCD_DATA~6_combout\,
	datab => \ps2_code[1]~reg0_q\,
	datac => \ps2_code[5]~reg0_q\,
	datad => \LCD_DATA~5_combout\,
	combout => \LCD_DATA~7_combout\);

-- Location: LCCOMB_X69_Y71_N18
\LCD_DATA~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~8_combout\ = (\ps2_code[6]~reg0_q\ & (\LCD_DATA~7_combout\ & (!\ps2_code[7]~reg0_q\))) # (!\ps2_code[6]~reg0_q\ & (((!\Equal17~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100001011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[6]~reg0_q\,
	datab => \LCD_DATA~7_combout\,
	datac => \ps2_code[7]~reg0_q\,
	datad => \Equal17~1_combout\,
	combout => \LCD_DATA~8_combout\);

-- Location: LCCOMB_X69_Y71_N20
\Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = (\WideOr11~1_combout\ & (\LCD_DATA~8_combout\ & ((!\Selector7~10_combout\)))) # (!\WideOr11~1_combout\ & ((\LCD_DATA[1]~reg0_q\) # ((\LCD_DATA~8_combout\ & !\Selector7~10_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr11~1_combout\,
	datab => \LCD_DATA~8_combout\,
	datac => \LCD_DATA[1]~reg0_q\,
	datad => \Selector7~10_combout\,
	combout => \Selector6~0_combout\);

-- Location: FF_X69_Y71_N21
\LCD_DATA[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_DATA[1]~reg0_q\);

-- Location: LCCOMB_X70_Y71_N30
\Selector5~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~15_combout\ = (!\current_state.S6~q\ & (!\current_state.S7~q\ & !\current_state.S8~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_state.S6~q\,
	datab => \current_state.S7~q\,
	datad => \current_state.S8~q\,
	combout => \Selector5~15_combout\);

-- Location: LCCOMB_X67_Y71_N8
\Selector5~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~18_combout\ = (\ps2_code[1]~reg0_q\ & ((\ps2_code[2]~reg0_q\ & ((\ps2_code[3]~reg0_q\))) # (!\ps2_code[2]~reg0_q\ & (\ps2_code[0]~reg0_q\)))) # (!\ps2_code[1]~reg0_q\ & (!\ps2_code[0]~reg0_q\ & ((\ps2_code[2]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[0]~reg0_q\,
	datab => \ps2_code[3]~reg0_q\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \ps2_code[2]~reg0_q\,
	combout => \Selector5~18_combout\);

-- Location: LCCOMB_X67_Y71_N10
\Selector5~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~19_combout\ = (\Selector5~18_combout\ & ((\ps2_code[4]~reg0_q\) # (\ps2_code[3]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \Selector5~18_combout\,
	combout => \Selector5~19_combout\);

-- Location: LCCOMB_X67_Y71_N14
\Selector5~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~17_combout\ = (((\ps2_code[7]~reg0_q\) # (\Selector5~19_combout\)) # (!\ps2_code[5]~reg0_q\)) # (!\ps2_code[6]~reg0_q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[6]~reg0_q\,
	datab => \ps2_code[5]~reg0_q\,
	datac => \ps2_code[7]~reg0_q\,
	datad => \Selector5~19_combout\,
	combout => \Selector5~17_combout\);

-- Location: LCCOMB_X73_Y71_N8
\Selector5~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~13_combout\ = ((!\Selector7~9_combout\) # (!\Selector8~5_combout\)) # (!\Selector7~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector7~4_combout\,
	datab => \Selector8~5_combout\,
	datad => \Selector7~9_combout\,
	combout => \Selector5~13_combout\);

-- Location: LCCOMB_X67_Y71_N0
\Selector5~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~11_combout\ = ((!\ps2_code[4]~reg0_q\ & ((!\ps2_code[1]~reg0_q\) # (!\ps2_code[2]~reg0_q\)))) # (!\ps2_code[3]~reg0_q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[2]~reg0_q\,
	datab => \ps2_code[3]~reg0_q\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \ps2_code[4]~reg0_q\,
	combout => \Selector5~11_combout\);

-- Location: LCCOMB_X68_Y71_N12
\Selector5~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~12_combout\ = (\LCD_DATA~0_combout\) # ((\Equal2~0_combout\ & \Selector5~11_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Equal2~0_combout\,
	datac => \Selector5~11_combout\,
	datad => \LCD_DATA~0_combout\,
	combout => \Selector5~12_combout\);

-- Location: LCCOMB_X73_Y71_N2
\Selector5~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~14_combout\ = (\Selector5~17_combout\ & (\Selector5~12_combout\ & ((\Selector5~13_combout\) # (!\Selector7~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector7~6_combout\,
	datab => \Selector5~17_combout\,
	datac => \Selector5~13_combout\,
	datad => \Selector5~12_combout\,
	combout => \Selector5~14_combout\);

-- Location: LCCOMB_X73_Y71_N24
\Selector5~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector5~16_combout\ = ((\Selector5~14_combout\) # ((!\WideOr11~1_combout\ & \LCD_DATA[2]~reg0_q\))) # (!\Selector5~15_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector5~15_combout\,
	datab => \WideOr11~1_combout\,
	datac => \LCD_DATA[2]~reg0_q\,
	datad => \Selector5~14_combout\,
	combout => \Selector5~16_combout\);

-- Location: FF_X73_Y71_N25
\LCD_DATA[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector5~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_DATA[2]~reg0_q\);

-- Location: LCCOMB_X67_Y71_N30
\Selector4~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~9_combout\ = (\ps2_code[3]~reg0_q\ & ((\ps2_code[4]~reg0_q\) # (\ps2_code[0]~reg0_q\ $ (!\ps2_code[2]~reg0_q\)))) # (!\ps2_code[3]~reg0_q\ & (((\ps2_code[0]~reg0_q\)) # (!\ps2_code[4]~reg0_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100111011011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[3]~reg0_q\,
	datab => \ps2_code[4]~reg0_q\,
	datac => \ps2_code[0]~reg0_q\,
	datad => \ps2_code[2]~reg0_q\,
	combout => \Selector4~9_combout\);

-- Location: LCCOMB_X67_Y71_N12
\Selector4~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~10_combout\ = (\ps2_code[2]~reg0_q\) # (\ps2_code[4]~reg0_q\ $ (((!\ps2_code[3]~reg0_q\) # (!\ps2_code[0]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \ps2_code[0]~reg0_q\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \ps2_code[2]~reg0_q\,
	combout => \Selector4~10_combout\);

-- Location: LCCOMB_X67_Y71_N2
\Selector4~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~8_combout\ = (\ps2_code[1]~reg0_q\ & ((\Selector4~10_combout\))) # (!\ps2_code[1]~reg0_q\ & (\Selector4~9_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ps2_code[1]~reg0_q\,
	datac => \Selector4~9_combout\,
	datad => \Selector4~10_combout\,
	combout => \Selector4~8_combout\);

-- Location: LCCOMB_X67_Y71_N28
\Selector4~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~17_combout\ = (((\ps2_code[7]~reg0_q\) # (\Selector4~8_combout\)) # (!\ps2_code[6]~reg0_q\)) # (!\ps2_code[5]~reg0_q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[5]~reg0_q\,
	datab => \ps2_code[6]~reg0_q\,
	datac => \ps2_code[7]~reg0_q\,
	datad => \Selector4~8_combout\,
	combout => \Selector4~17_combout\);

-- Location: LCCOMB_X70_Y71_N8
\Selector4~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~16_combout\ = ((\LCD_DATA[3]~reg0_q\ & ((\current_state.IDLE~q\) # (\current_state.S93~q\)))) # (!\Selector5~15_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LCD_DATA[3]~reg0_q\,
	datab => \current_state.IDLE~q\,
	datac => \current_state.S93~q\,
	datad => \Selector5~15_combout\,
	combout => \Selector4~16_combout\);

-- Location: LCCOMB_X69_Y71_N28
\Equal2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal2~1_combout\ = (!\ps2_code[1]~reg0_q\ & (\ps2_code[4]~reg0_q\ & \Equal2~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ps2_code[1]~reg0_q\,
	datac => \ps2_code[4]~reg0_q\,
	datad => \Equal2~0_combout\,
	combout => \Equal2~1_combout\);

-- Location: LCCOMB_X69_Y71_N10
\LCD_DATA~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~9_combout\ = (\Equal2~1_combout\ & ((\ps2_code[2]~reg0_q\ & ((\ps2_code[0]~reg0_q\) # (\ps2_code[3]~reg0_q\))) # (!\ps2_code[2]~reg0_q\ & (\ps2_code[0]~reg0_q\ & \ps2_code[3]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[2]~reg0_q\,
	datab => \ps2_code[0]~reg0_q\,
	datac => \ps2_code[3]~reg0_q\,
	datad => \Equal2~1_combout\,
	combout => \LCD_DATA~9_combout\);

-- Location: LCCOMB_X70_Y71_N16
\LCD_DATA~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~10_combout\ = (\Equal15~2_combout\) # ((\Equal16~2_combout\) # ((\Equal13~0_combout\) # (\LCD_DATA~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal15~2_combout\,
	datab => \Equal16~2_combout\,
	datac => \Equal13~0_combout\,
	datad => \LCD_DATA~9_combout\,
	combout => \LCD_DATA~10_combout\);

-- Location: LCCOMB_X70_Y71_N12
\Selector4~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector4~15_combout\ = (\Selector4~16_combout\) # ((\Selector4~17_combout\ & (!\Selector7~10_combout\ & \LCD_DATA~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector4~17_combout\,
	datab => \Selector4~16_combout\,
	datac => \Selector7~10_combout\,
	datad => \LCD_DATA~10_combout\,
	combout => \Selector4~15_combout\);

-- Location: FF_X70_Y71_N13
\LCD_DATA[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector4~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_DATA[3]~reg0_q\);

-- Location: LCCOMB_X69_Y71_N12
\Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (((\LCD_DATA[4]~reg0_q\ & !\WideOr11~1_combout\)) # (!\WideOr11~2_combout\)) # (!\Selector5~15_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111110111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LCD_DATA[4]~reg0_q\,
	datab => \Selector5~15_combout\,
	datac => \WideOr11~2_combout\,
	datad => \WideOr11~1_combout\,
	combout => \Selector3~0_combout\);

-- Location: LCCOMB_X68_Y72_N4
\LCD_DATA~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~13_combout\ = (\ps2_code[7]~reg0_q\) # (!\ps2_code[3]~reg0_q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ps2_code[3]~reg0_q\,
	datac => \ps2_code[7]~reg0_q\,
	combout => \LCD_DATA~13_combout\);

-- Location: LCCOMB_X69_Y71_N2
\LCD_DATA~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~11_combout\ = (\ps2_code[5]~reg0_q\ & ((\ps2_code[2]~reg0_q\ & (!\ps2_code[0]~reg0_q\ & !\ps2_code[1]~reg0_q\)) # (!\ps2_code[2]~reg0_q\ & (\ps2_code[0]~reg0_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100011000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[2]~reg0_q\,
	datab => \ps2_code[0]~reg0_q\,
	datac => \ps2_code[1]~reg0_q\,
	datad => \ps2_code[5]~reg0_q\,
	combout => \LCD_DATA~11_combout\);

-- Location: LCCOMB_X69_Y71_N16
\LCD_DATA~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~12_combout\ = (\ps2_code[4]~reg0_q\ & (!\LCD_DATA~11_combout\ & ((\ps2_code[2]~reg0_q\) # (!\Equal15~0_combout\)))) # (!\ps2_code[4]~reg0_q\ & ((\ps2_code[2]~reg0_q\) # ((!\Equal15~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010111001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[4]~reg0_q\,
	datab => \ps2_code[2]~reg0_q\,
	datac => \Equal15~0_combout\,
	datad => \LCD_DATA~11_combout\,
	combout => \LCD_DATA~12_combout\);

-- Location: LCCOMB_X69_Y71_N26
\LCD_DATA~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \LCD_DATA~14_combout\ = (\ps2_code[6]~reg0_q\ & (((\LCD_DATA~13_combout\) # (\LCD_DATA~12_combout\)))) # (!\ps2_code[6]~reg0_q\ & (\Equal17~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ps2_code[6]~reg0_q\,
	datab => \Equal17~1_combout\,
	datac => \LCD_DATA~13_combout\,
	datad => \LCD_DATA~12_combout\,
	combout => \LCD_DATA~14_combout\);

-- Location: LCCOMB_X69_Y71_N14
\Selector3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector3~1_combout\ = (\Selector3~0_combout\) # ((\LCD_DATA~14_combout\ & !\Selector7~10_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector3~0_combout\,
	datac => \LCD_DATA~14_combout\,
	datad => \Selector7~10_combout\,
	combout => \Selector3~1_combout\);

-- Location: FF_X69_Y71_N15
\LCD_DATA[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector3~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_DATA[4]~reg0_q\);

-- Location: LCCOMB_X70_Y71_N14
\Selector2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (((\LCD_DATA[5]~reg0_q\ & !\WideOr11~1_combout\)) # (!\Selector5~15_combout\)) # (!\WideOr11~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr11~2_combout\,
	datab => \Selector5~15_combout\,
	datac => \LCD_DATA[5]~reg0_q\,
	datad => \WideOr11~1_combout\,
	combout => \Selector2~0_combout\);

-- Location: LCCOMB_X70_Y71_N4
\Selector2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector2~1_combout\ = (\Selector2~0_combout\) # ((!\Selector7~10_combout\ & ((\LCD_DATA~10_combout\) # (!\Selector4~17_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector4~17_combout\,
	datab => \Selector2~0_combout\,
	datac => \Selector7~10_combout\,
	datad => \LCD_DATA~10_combout\,
	combout => \Selector2~1_combout\);

-- Location: FF_X70_Y71_N5
\LCD_DATA[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector2~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_DATA[5]~reg0_q\);

-- Location: LCCOMB_X73_Y71_N18
\Selector1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\Equal17~1_combout\ & (!\WideOr11~1_combout\ & (\LCD_DATA[6]~reg0_q\))) # (!\Equal17~1_combout\ & (((!\WideOr11~1_combout\ & \LCD_DATA[6]~reg0_q\)) # (!\Selector7~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000001110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal17~1_combout\,
	datab => \WideOr11~1_combout\,
	datac => \LCD_DATA[6]~reg0_q\,
	datad => \Selector7~10_combout\,
	combout => \Selector1~0_combout\);

-- Location: FF_X73_Y71_N19
\LCD_DATA[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ps2_code_new~reg0clkctrl_outclk\,
	d => \Selector1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \LCD_DATA[6]~reg0_q\);

-- Location: IOIBUF_X58_Y73_N15
\ps2_code_new~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code_new,
	o => \ps2_code_new~input_o\);

-- Location: IOIBUF_X107_Y73_N8
\ps2_code[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(0),
	o => \ps2_code[0]~input_o\);

-- Location: IOIBUF_X111_Y73_N8
\ps2_code[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(1),
	o => \ps2_code[1]~input_o\);

-- Location: IOIBUF_X83_Y73_N1
\ps2_code[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(2),
	o => \ps2_code[2]~input_o\);

-- Location: IOIBUF_X85_Y73_N22
\ps2_code[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(3),
	o => \ps2_code[3]~input_o\);

-- Location: IOIBUF_X72_Y73_N15
\ps2_code[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(4),
	o => \ps2_code[4]~input_o\);

-- Location: IOIBUF_X74_Y73_N15
\ps2_code[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(5),
	o => \ps2_code[5]~input_o\);

-- Location: IOIBUF_X72_Y73_N22
\ps2_code[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(6),
	o => \ps2_code[6]~input_o\);

-- Location: IOIBUF_X74_Y73_N22
\ps2_code[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ps2_code(7),
	o => \ps2_code[7]~input_o\);

ww_LCD_ENABLE <= \LCD_ENABLE~output_o\;

ww_LCD_RW <= \LCD_RW~output_o\;

ww_LCD_RS <= \LCD_RS~output_o\;

ww_LCD_DATA(0) <= \LCD_DATA[0]~output_o\;

ww_LCD_DATA(1) <= \LCD_DATA[1]~output_o\;

ww_LCD_DATA(2) <= \LCD_DATA[2]~output_o\;

ww_LCD_DATA(3) <= \LCD_DATA[3]~output_o\;

ww_LCD_DATA(4) <= \LCD_DATA[4]~output_o\;

ww_LCD_DATA(5) <= \LCD_DATA[5]~output_o\;

ww_LCD_DATA(6) <= \LCD_DATA[6]~output_o\;

ww_LCD_DATA(7) <= \LCD_DATA[7]~output_o\;

ps2_code_new <= \ps2_code_new~output_o\;

ps2_code(0) <= \ps2_code[0]~output_o\;

ps2_code(1) <= \ps2_code[1]~output_o\;

ps2_code(2) <= \ps2_code[2]~output_o\;

ps2_code(3) <= \ps2_code[3]~output_o\;

ps2_code(4) <= \ps2_code[4]~output_o\;

ps2_code(5) <= \ps2_code[5]~output_o\;

ps2_code(6) <= \ps2_code[6]~output_o\;

ps2_code(7) <= \ps2_code[7]~output_o\;
END structure;


