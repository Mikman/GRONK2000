-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "03/19/2021 11:36:29"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	CamToRAM IS
    PORT (
	XCLK : OUT std_logic;
	RESET : OUT std_logic;
	PWDN : OUT std_logic;
	HREF : IN std_logic;
	VSYNC : IN std_logic;
	PCLK : IN std_logic;
	getImagePin : IN std_logic;
	CAMdata : IN std_logic_vector(7 DOWNTO 0);
	address : OUT std_logic_vector(18 DOWNTO 0);
	RAMdata : OUT std_logic_vector(7 DOWNTO 0);
	WE : BUFFER std_logic;
	OE : BUFFER std_logic;
	CS : BUFFER std_logic;
	LEDs : OUT std_logic_vector(9 DOWNTO 0);
	clk : IN std_logic
	);
END CamToRAM;

-- Design Ports Information
-- XCLK	=>  Location: PIN_B15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RESET	=>  Location: PIN_H18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PWDN	=>  Location: PIN_J18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[0]	=>  Location: PIN_G11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[1]	=>  Location: PIN_J19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[2]	=>  Location: PIN_J11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[3]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[0]	=>  Location: PIN_P17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[1]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[2]	=>  Location: PIN_P16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[3]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[4]	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[5]	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[6]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[7]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[8]	=>  Location: PIN_T22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[9]	=>  Location: PIN_R21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[10]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[11]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[12]	=>  Location: PIN_M21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[13]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[14]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[15]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[16]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[17]	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[18]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[0]	=>  Location: PIN_T19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[1]	=>  Location: PIN_T20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[2]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[3]	=>  Location: PIN_R17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[4]	=>  Location: PIN_R15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[5]	=>  Location: PIN_P18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[6]	=>  Location: PIN_K19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RAMdata[7]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- WE	=>  Location: PIN_T17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OE	=>  Location: PIN_T18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CS	=>  Location: PIN_T15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[0]	=>  Location: PIN_AA2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[1]	=>  Location: PIN_AA1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[2]	=>  Location: PIN_W2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[3]	=>  Location: PIN_Y3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[4]	=>  Location: PIN_N2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[5]	=>  Location: PIN_N1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[6]	=>  Location: PIN_U2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[7]	=>  Location: PIN_U1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[8]	=>  Location: PIN_L2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- LEDs[9]	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- VSYNC	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- getImagePin	=>  Location: PIN_AB12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PCLK	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[6]	=>  Location: PIN_L8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- HREF	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[7]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[4]	=>  Location: PIN_A15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CAMdata[5]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF CamToRAM IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_XCLK : std_logic;
SIGNAL ww_RESET : std_logic;
SIGNAL ww_PWDN : std_logic;
SIGNAL ww_HREF : std_logic;
SIGNAL ww_VSYNC : std_logic;
SIGNAL ww_PCLK : std_logic;
SIGNAL ww_getImagePin : std_logic;
SIGNAL ww_CAMdata : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_address : std_logic_vector(18 DOWNTO 0);
SIGNAL ww_RAMdata : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_WE : std_logic;
SIGNAL ww_OE : std_logic;
SIGNAL ww_CS : std_logic;
SIGNAL ww_LEDs : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_clk : std_logic;
SIGNAL \CAMdata[0]~input_o\ : std_logic;
SIGNAL \CAMdata[1]~input_o\ : std_logic;
SIGNAL \CAMdata[2]~input_o\ : std_logic;
SIGNAL \CAMdata[3]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add2~9_sumout\ : std_logic;
SIGNAL \PCLK~input_o\ : std_logic;
SIGNAL \PCLK~inputCLKENA0_outclk\ : std_logic;
SIGNAL \getImagePin~input_o\ : std_logic;
SIGNAL \VSYNC~input_o\ : std_logic;
SIGNAL \process_0~0_combout\ : std_logic;
SIGNAL \counting~q\ : std_logic;
SIGNAL \Add2~10\ : std_logic;
SIGNAL \Add2~1_sumout\ : std_logic;
SIGNAL \Add1~1_sumout\ : std_logic;
SIGNAL \Add2~2\ : std_logic;
SIGNAL \Add2~5_sumout\ : std_logic;
SIGNAL \addr[0]~0_combout\ : std_logic;
SIGNAL \Add1~2\ : std_logic;
SIGNAL \Add1~5_sumout\ : std_logic;
SIGNAL \Add1~6\ : std_logic;
SIGNAL \Add1~9_sumout\ : std_logic;
SIGNAL \Add1~10\ : std_logic;
SIGNAL \Add1~13_sumout\ : std_logic;
SIGNAL \Add1~14\ : std_logic;
SIGNAL \Add1~17_sumout\ : std_logic;
SIGNAL \Add1~18\ : std_logic;
SIGNAL \Add1~21_sumout\ : std_logic;
SIGNAL \Add1~22\ : std_logic;
SIGNAL \Add1~25_sumout\ : std_logic;
SIGNAL \Add1~26\ : std_logic;
SIGNAL \Add1~29_sumout\ : std_logic;
SIGNAL \Add1~30\ : std_logic;
SIGNAL \Add1~33_sumout\ : std_logic;
SIGNAL \Add1~34\ : std_logic;
SIGNAL \Add1~37_sumout\ : std_logic;
SIGNAL \Add1~38\ : std_logic;
SIGNAL \Add1~41_sumout\ : std_logic;
SIGNAL \Add1~42\ : std_logic;
SIGNAL \Add1~45_sumout\ : std_logic;
SIGNAL \Add1~46\ : std_logic;
SIGNAL \Add1~49_sumout\ : std_logic;
SIGNAL \Add1~50\ : std_logic;
SIGNAL \Add1~53_sumout\ : std_logic;
SIGNAL \Add1~54\ : std_logic;
SIGNAL \Add1~57_sumout\ : std_logic;
SIGNAL \Add1~58\ : std_logic;
SIGNAL \Add1~61_sumout\ : std_logic;
SIGNAL \Add1~62\ : std_logic;
SIGNAL \Add1~65_sumout\ : std_logic;
SIGNAL \Add1~66\ : std_logic;
SIGNAL \Add1~69_sumout\ : std_logic;
SIGNAL \Add1~70\ : std_logic;
SIGNAL \Add1~73_sumout\ : std_logic;
SIGNAL \Add0~125_sumout\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \HREF~input_o\ : std_logic;
SIGNAL \process_0~1_combout\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \Add0~62\ : std_logic;
SIGNAL \Add0~65_sumout\ : std_logic;
SIGNAL \Add0~66\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \i[19]~feeder_combout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~69_sumout\ : std_logic;
SIGNAL \Add0~70\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~117_sumout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Equal0~7_combout\ : std_logic;
SIGNAL \LessThan2~0_combout\ : std_logic;
SIGNAL \Add0~126\ : std_logic;
SIGNAL \Add0~121_sumout\ : std_logic;
SIGNAL \Add0~122\ : std_logic;
SIGNAL \Add0~73_sumout\ : std_logic;
SIGNAL \Add0~74\ : std_logic;
SIGNAL \Add0~77_sumout\ : std_logic;
SIGNAL \Add0~78\ : std_logic;
SIGNAL \Add0~81_sumout\ : std_logic;
SIGNAL \Add0~82\ : std_logic;
SIGNAL \Add0~85_sumout\ : std_logic;
SIGNAL \Add0~86\ : std_logic;
SIGNAL \Add0~89_sumout\ : std_logic;
SIGNAL \Add0~90\ : std_logic;
SIGNAL \Add0~93_sumout\ : std_logic;
SIGNAL \Add0~94\ : std_logic;
SIGNAL \Add0~97_sumout\ : std_logic;
SIGNAL \Add0~98\ : std_logic;
SIGNAL \Add0~101_sumout\ : std_logic;
SIGNAL \Add0~102\ : std_logic;
SIGNAL \Add0~105_sumout\ : std_logic;
SIGNAL \Add0~106\ : std_logic;
SIGNAL \Add0~109_sumout\ : std_logic;
SIGNAL \Add0~110\ : std_logic;
SIGNAL \Add0~113_sumout\ : std_logic;
SIGNAL \Add0~114\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~5_combout\ : std_logic;
SIGNAL \Equal0~6_combout\ : std_logic;
SIGNAL \CAMdata[6]~input_o\ : std_logic;
SIGNAL \Decoder0~0_combout\ : std_logic;
SIGNAL \preArray[0][6]~q\ : std_logic;
SIGNAL \postArray[1][0]~combout\ : std_logic;
SIGNAL \RAMdata[0]~reg0_q\ : std_logic;
SIGNAL \CAMdata[7]~input_o\ : std_logic;
SIGNAL \preArray[0][7]~q\ : std_logic;
SIGNAL \postArray[1][1]~combout\ : std_logic;
SIGNAL \RAMdata[1]~reg0feeder_combout\ : std_logic;
SIGNAL \RAMdata[1]~reg0_q\ : std_logic;
SIGNAL \preArray[2][6]~feeder_combout\ : std_logic;
SIGNAL \Decoder0~1_combout\ : std_logic;
SIGNAL \preArray[2][6]~q\ : std_logic;
SIGNAL \postArray[1][2]~combout\ : std_logic;
SIGNAL \RAMdata[2]~reg0feeder_combout\ : std_logic;
SIGNAL \RAMdata[2]~reg0_q\ : std_logic;
SIGNAL \preArray[2][7]~q\ : std_logic;
SIGNAL \postArray[1][3]~combout\ : std_logic;
SIGNAL \RAMdata[3]~reg0_q\ : std_logic;
SIGNAL \CAMdata[4]~input_o\ : std_logic;
SIGNAL \Decoder0~3_combout\ : std_logic;
SIGNAL \preArray[3][4]~q\ : std_logic;
SIGNAL \postArray[1][4]~combout\ : std_logic;
SIGNAL \Add2~6\ : std_logic;
SIGNAL \Add2~65_sumout\ : std_logic;
SIGNAL \Add2~66\ : std_logic;
SIGNAL \Add2~69_sumout\ : std_logic;
SIGNAL \Add2~70\ : std_logic;
SIGNAL \Add2~73_sumout\ : std_logic;
SIGNAL \Add2~74\ : std_logic;
SIGNAL \Add2~77_sumout\ : std_logic;
SIGNAL \Add2~78\ : std_logic;
SIGNAL \Add2~33_sumout\ : std_logic;
SIGNAL \Add2~34\ : std_logic;
SIGNAL \Add2~21_sumout\ : std_logic;
SIGNAL \Add2~22\ : std_logic;
SIGNAL \Add2~57_sumout\ : std_logic;
SIGNAL \Add2~58\ : std_logic;
SIGNAL \Add2~25_sumout\ : std_logic;
SIGNAL \Add2~26\ : std_logic;
SIGNAL \Add2~17_sumout\ : std_logic;
SIGNAL \Add2~18\ : std_logic;
SIGNAL \Add2~53_sumout\ : std_logic;
SIGNAL \Add2~54\ : std_logic;
SIGNAL \Add2~49_sumout\ : std_logic;
SIGNAL \Add2~50\ : std_logic;
SIGNAL \Add2~45_sumout\ : std_logic;
SIGNAL \Add2~46\ : std_logic;
SIGNAL \Add2~41_sumout\ : std_logic;
SIGNAL \Add2~42\ : std_logic;
SIGNAL \Add2~37_sumout\ : std_logic;
SIGNAL \LessThan3~1_combout\ : std_logic;
SIGNAL \Add2~38\ : std_logic;
SIGNAL \Add2~61_sumout\ : std_logic;
SIGNAL \Add2~62\ : std_logic;
SIGNAL \Add2~125_sumout\ : std_logic;
SIGNAL \Add2~126\ : std_logic;
SIGNAL \Add2~121_sumout\ : std_logic;
SIGNAL \Add2~122\ : std_logic;
SIGNAL \Add2~117_sumout\ : std_logic;
SIGNAL \Add2~118\ : std_logic;
SIGNAL \Add2~113_sumout\ : std_logic;
SIGNAL \Add2~114\ : std_logic;
SIGNAL \Add2~109_sumout\ : std_logic;
SIGNAL \Add2~110\ : std_logic;
SIGNAL \Add2~105_sumout\ : std_logic;
SIGNAL \Add2~106\ : std_logic;
SIGNAL \Add2~101_sumout\ : std_logic;
SIGNAL \Add2~102\ : std_logic;
SIGNAL \Add2~97_sumout\ : std_logic;
SIGNAL \Add2~98\ : std_logic;
SIGNAL \Add2~93_sumout\ : std_logic;
SIGNAL \Add2~94\ : std_logic;
SIGNAL \Add2~89_sumout\ : std_logic;
SIGNAL \Add2~90\ : std_logic;
SIGNAL \Add2~85_sumout\ : std_logic;
SIGNAL \Add2~86\ : std_logic;
SIGNAL \Add2~81_sumout\ : std_logic;
SIGNAL \Add2~82\ : std_logic;
SIGNAL \Add2~29_sumout\ : std_logic;
SIGNAL \Add2~30\ : std_logic;
SIGNAL \Add2~13_sumout\ : std_logic;
SIGNAL \LessThan3~2_combout\ : std_logic;
SIGNAL \LessThan3~4_combout\ : std_logic;
SIGNAL \LessThan3~3_combout\ : std_logic;
SIGNAL \LessThan3~0_combout\ : std_logic;
SIGNAL \LessThan3~5_combout\ : std_logic;
SIGNAL \Decoder0~2_combout\ : std_logic;
SIGNAL \preArray[1][4]~q\ : std_logic;
SIGNAL \postArray[0][4]~combout\ : std_logic;
SIGNAL \RAMdata~0_combout\ : std_logic;
SIGNAL \RAMdata[4]~reg0_q\ : std_logic;
SIGNAL \CAMdata[5]~input_o\ : std_logic;
SIGNAL \preArray[1][5]~q\ : std_logic;
SIGNAL \postArray[0][5]~combout\ : std_logic;
SIGNAL \preArray[3][5]~q\ : std_logic;
SIGNAL \postArray[1][5]~combout\ : std_logic;
SIGNAL \RAMdata~1_combout\ : std_logic;
SIGNAL \RAMdata[5]~reg0_q\ : std_logic;
SIGNAL \preArray[3][6]~q\ : std_logic;
SIGNAL \postArray[1][6]~combout\ : std_logic;
SIGNAL \preArray[1][6]~q\ : std_logic;
SIGNAL \postArray[0][6]~combout\ : std_logic;
SIGNAL \RAMdata~2_combout\ : std_logic;
SIGNAL \RAMdata[6]~reg0_q\ : std_logic;
SIGNAL \preArray[3][7]~q\ : std_logic;
SIGNAL \postArray[1][7]~combout\ : std_logic;
SIGNAL \preArray[1][7]~q\ : std_logic;
SIGNAL \postArray[0][7]~combout\ : std_logic;
SIGNAL \RAMdata~3_combout\ : std_logic;
SIGNAL \RAMdata[7]~reg0_q\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL ticks : std_logic_vector(31 DOWNTO 0);
SIGNAL addr : std_logic_vector(31 DOWNTO 0);
SIGNAL i : std_logic_vector(31 DOWNTO 0);
SIGNAL \ALT_INV_HREF~input_o\ : std_logic;
SIGNAL \ALT_INV_CAMdata[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_getImagePin~input_o\ : std_logic;
SIGNAL \ALT_INV_VSYNC~input_o\ : std_logic;
SIGNAL \ALT_INV_postArray[1][7]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[0][7]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[1][6]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[0][6]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[1][5]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[0][5]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[1][4]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[0][4]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[1][3]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[1][2]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[1][1]~combout\ : std_logic;
SIGNAL \ALT_INV_postArray[1][0]~combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~7_combout\ : std_logic;
SIGNAL \ALT_INV_preArray[3][7]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[1][7]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[3][6]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[1][6]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[3][5]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[1][5]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[3][4]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[1][4]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[2][7]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[2][6]~q\ : std_logic;
SIGNAL \ALT_INV_preArray[0][7]~q\ : std_logic;
SIGNAL \ALT_INV_Equal0~6_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~5_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~4_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~3_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~2_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \ALT_INV_preArray[0][6]~q\ : std_logic;
SIGNAL \ALT_INV_LessThan3~5_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan3~4_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan3~3_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan3~2_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan3~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan3~0_combout\ : std_logic;
SIGNAL \ALT_INV_counting~q\ : std_logic;
SIGNAL \ALT_INV_LessThan0~0_combout\ : std_logic;
SIGNAL \ALT_INV_Add0~21_sumout\ : std_logic;
SIGNAL ALT_INV_i : std_logic_vector(31 DOWNTO 0);
SIGNAL ALT_INV_ticks : std_logic_vector(31 DOWNTO 0);
SIGNAL ALT_INV_addr : std_logic_vector(18 DOWNTO 0);

BEGIN

XCLK <= ww_XCLK;
RESET <= ww_RESET;
PWDN <= ww_PWDN;
ww_HREF <= HREF;
ww_VSYNC <= VSYNC;
ww_PCLK <= PCLK;
ww_getImagePin <= getImagePin;
ww_CAMdata <= CAMdata;
address <= ww_address;
RAMdata <= ww_RAMdata;
WE <= ww_WE;
OE <= ww_OE;
CS <= ww_CS;
LEDs <= ww_LEDs;
ww_clk <= clk;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_HREF~input_o\ <= NOT \HREF~input_o\;
\ALT_INV_CAMdata[6]~input_o\ <= NOT \CAMdata[6]~input_o\;
\ALT_INV_getImagePin~input_o\ <= NOT \getImagePin~input_o\;
\ALT_INV_VSYNC~input_o\ <= NOT \VSYNC~input_o\;
\ALT_INV_postArray[1][7]~combout\ <= NOT \postArray[1][7]~combout\;
\ALT_INV_postArray[0][7]~combout\ <= NOT \postArray[0][7]~combout\;
\ALT_INV_postArray[1][6]~combout\ <= NOT \postArray[1][6]~combout\;
\ALT_INV_postArray[0][6]~combout\ <= NOT \postArray[0][6]~combout\;
\ALT_INV_postArray[1][5]~combout\ <= NOT \postArray[1][5]~combout\;
\ALT_INV_postArray[0][5]~combout\ <= NOT \postArray[0][5]~combout\;
\ALT_INV_postArray[1][4]~combout\ <= NOT \postArray[1][4]~combout\;
\ALT_INV_postArray[0][4]~combout\ <= NOT \postArray[0][4]~combout\;
\ALT_INV_postArray[1][3]~combout\ <= NOT \postArray[1][3]~combout\;
\ALT_INV_postArray[1][2]~combout\ <= NOT \postArray[1][2]~combout\;
\ALT_INV_postArray[1][1]~combout\ <= NOT \postArray[1][1]~combout\;
\ALT_INV_postArray[1][0]~combout\ <= NOT \postArray[1][0]~combout\;
\ALT_INV_Equal0~7_combout\ <= NOT \Equal0~7_combout\;
\ALT_INV_preArray[3][7]~q\ <= NOT \preArray[3][7]~q\;
\ALT_INV_preArray[1][7]~q\ <= NOT \preArray[1][7]~q\;
\ALT_INV_preArray[3][6]~q\ <= NOT \preArray[3][6]~q\;
\ALT_INV_preArray[1][6]~q\ <= NOT \preArray[1][6]~q\;
\ALT_INV_preArray[3][5]~q\ <= NOT \preArray[3][5]~q\;
\ALT_INV_preArray[1][5]~q\ <= NOT \preArray[1][5]~q\;
\ALT_INV_preArray[3][4]~q\ <= NOT \preArray[3][4]~q\;
\ALT_INV_preArray[1][4]~q\ <= NOT \preArray[1][4]~q\;
\ALT_INV_preArray[2][7]~q\ <= NOT \preArray[2][7]~q\;
\ALT_INV_preArray[2][6]~q\ <= NOT \preArray[2][6]~q\;
\ALT_INV_preArray[0][7]~q\ <= NOT \preArray[0][7]~q\;
\ALT_INV_Equal0~6_combout\ <= NOT \Equal0~6_combout\;
\ALT_INV_Equal0~5_combout\ <= NOT \Equal0~5_combout\;
\ALT_INV_Equal0~4_combout\ <= NOT \Equal0~4_combout\;
\ALT_INV_Equal0~3_combout\ <= NOT \Equal0~3_combout\;
\ALT_INV_Equal0~2_combout\ <= NOT \Equal0~2_combout\;
\ALT_INV_Equal0~1_combout\ <= NOT \Equal0~1_combout\;
\ALT_INV_Equal0~0_combout\ <= NOT \Equal0~0_combout\;
\ALT_INV_preArray[0][6]~q\ <= NOT \preArray[0][6]~q\;
\ALT_INV_LessThan3~5_combout\ <= NOT \LessThan3~5_combout\;
\ALT_INV_LessThan3~4_combout\ <= NOT \LessThan3~4_combout\;
\ALT_INV_LessThan3~3_combout\ <= NOT \LessThan3~3_combout\;
\ALT_INV_LessThan3~2_combout\ <= NOT \LessThan3~2_combout\;
\ALT_INV_LessThan3~1_combout\ <= NOT \LessThan3~1_combout\;
\ALT_INV_LessThan3~0_combout\ <= NOT \LessThan3~0_combout\;
\ALT_INV_counting~q\ <= NOT \counting~q\;
\ALT_INV_LessThan0~0_combout\ <= NOT \LessThan0~0_combout\;
\ALT_INV_Add0~21_sumout\ <= NOT \Add0~21_sumout\;
ALT_INV_i(0) <= NOT i(0);
ALT_INV_i(1) <= NOT i(1);
ALT_INV_i(31) <= NOT i(31);
ALT_INV_i(12) <= NOT i(12);
ALT_INV_i(11) <= NOT i(11);
ALT_INV_i(10) <= NOT i(10);
ALT_INV_i(9) <= NOT i(9);
ALT_INV_i(8) <= NOT i(8);
ALT_INV_i(7) <= NOT i(7);
ALT_INV_i(6) <= NOT i(6);
ALT_INV_i(5) <= NOT i(5);
ALT_INV_i(4) <= NOT i(4);
ALT_INV_i(3) <= NOT i(3);
ALT_INV_i(2) <= NOT i(2);
ALT_INV_i(23) <= NOT i(23);
ALT_INV_i(18) <= NOT i(18);
ALT_INV_i(17) <= NOT i(17);
ALT_INV_i(16) <= NOT i(16);
ALT_INV_i(15) <= NOT i(15);
ALT_INV_i(14) <= NOT i(14);
ALT_INV_i(13) <= NOT i(13);
ALT_INV_i(25) <= NOT i(25);
ALT_INV_i(24) <= NOT i(24);
ALT_INV_i(22) <= NOT i(22);
ALT_INV_i(21) <= NOT i(21);
ALT_INV_i(20) <= NOT i(20);
ALT_INV_i(19) <= NOT i(19);
ALT_INV_i(30) <= NOT i(30);
ALT_INV_i(29) <= NOT i(29);
ALT_INV_i(28) <= NOT i(28);
ALT_INV_i(27) <= NOT i(27);
ALT_INV_i(26) <= NOT i(26);
ALT_INV_ticks(18) <= NOT ticks(18);
ALT_INV_ticks(19) <= NOT ticks(19);
ALT_INV_ticks(20) <= NOT ticks(20);
ALT_INV_ticks(21) <= NOT ticks(21);
ALT_INV_ticks(22) <= NOT ticks(22);
ALT_INV_ticks(23) <= NOT ticks(23);
ALT_INV_ticks(24) <= NOT ticks(24);
ALT_INV_ticks(25) <= NOT ticks(25);
ALT_INV_ticks(26) <= NOT ticks(26);
ALT_INV_ticks(27) <= NOT ticks(27);
ALT_INV_ticks(28) <= NOT ticks(28);
ALT_INV_ticks(29) <= NOT ticks(29);
ALT_INV_ticks(6) <= NOT ticks(6);
ALT_INV_ticks(5) <= NOT ticks(5);
ALT_INV_ticks(4) <= NOT ticks(4);
ALT_INV_ticks(3) <= NOT ticks(3);
ALT_INV_ticks(17) <= NOT ticks(17);
ALT_INV_ticks(9) <= NOT ticks(9);
ALT_INV_ticks(12) <= NOT ticks(12);
ALT_INV_ticks(13) <= NOT ticks(13);
ALT_INV_ticks(14) <= NOT ticks(14);
ALT_INV_ticks(15) <= NOT ticks(15);
ALT_INV_ticks(16) <= NOT ticks(16);
ALT_INV_ticks(7) <= NOT ticks(7);
ALT_INV_ticks(30) <= NOT ticks(30);
ALT_INV_ticks(10) <= NOT ticks(10);
ALT_INV_ticks(8) <= NOT ticks(8);
ALT_INV_ticks(11) <= NOT ticks(11);
ALT_INV_ticks(31) <= NOT ticks(31);
ALT_INV_ticks(0) <= NOT ticks(0);
ALT_INV_ticks(2) <= NOT ticks(2);
ALT_INV_addr(18) <= NOT addr(18);
ALT_INV_addr(17) <= NOT addr(17);
ALT_INV_addr(16) <= NOT addr(16);
ALT_INV_addr(15) <= NOT addr(15);
ALT_INV_addr(14) <= NOT addr(14);
ALT_INV_addr(13) <= NOT addr(13);
ALT_INV_addr(12) <= NOT addr(12);
ALT_INV_addr(11) <= NOT addr(11);
ALT_INV_addr(10) <= NOT addr(10);
ALT_INV_addr(9) <= NOT addr(9);
ALT_INV_addr(8) <= NOT addr(8);
ALT_INV_addr(7) <= NOT addr(7);
ALT_INV_addr(6) <= NOT addr(6);
ALT_INV_addr(5) <= NOT addr(5);
ALT_INV_addr(4) <= NOT addr(4);
ALT_INV_addr(3) <= NOT addr(3);
ALT_INV_addr(2) <= NOT addr(2);
ALT_INV_addr(1) <= NOT addr(1);
ALT_INV_addr(0) <= NOT addr(0);
ALT_INV_ticks(1) <= NOT ticks(1);

-- Location: IOOBUF_X43_Y45_N19
\XCLK~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => ALT_INV_ticks(1),
	devoe => ww_devoe,
	o => ww_XCLK);

-- Location: IOOBUF_X48_Y45_N19
\RESET~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_RESET);

-- Location: IOOBUF_X48_Y45_N53
\PWDN~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_PWDN);

-- Location: IOOBUF_X54_Y17_N22
\address[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(0),
	devoe => ww_devoe,
	o => ww_address(0));

-- Location: IOOBUF_X54_Y21_N22
\address[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(1),
	devoe => ww_devoe,
	o => ww_address(1));

-- Location: IOOBUF_X54_Y17_N5
\address[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(2),
	devoe => ww_devoe,
	o => ww_address(2));

-- Location: IOOBUF_X54_Y19_N56
\address[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(3),
	devoe => ww_devoe,
	o => ww_address(3));

-- Location: IOOBUF_X54_Y17_N39
\address[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(4),
	devoe => ww_devoe,
	o => ww_address(4));

-- Location: IOOBUF_X54_Y19_N39
\address[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(5),
	devoe => ww_devoe,
	o => ww_address(5));

-- Location: IOOBUF_X54_Y18_N79
\address[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(6),
	devoe => ww_devoe,
	o => ww_address(6));

-- Location: IOOBUF_X54_Y19_N5
\address[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(7),
	devoe => ww_devoe,
	o => ww_address(7));

-- Location: IOOBUF_X54_Y15_N39
\address[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(8),
	devoe => ww_devoe,
	o => ww_address(8));

-- Location: IOOBUF_X54_Y16_N39
\address[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(9),
	devoe => ww_devoe,
	o => ww_address(9));

-- Location: IOOBUF_X54_Y15_N56
\address[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(10),
	devoe => ww_devoe,
	o => ww_address(10));

-- Location: IOOBUF_X54_Y18_N96
\address[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(11),
	devoe => ww_devoe,
	o => ww_address(11));

-- Location: IOOBUF_X54_Y20_N56
\address[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(12),
	devoe => ww_devoe,
	o => ww_address(12));

-- Location: IOOBUF_X54_Y20_N39
\address[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(13),
	devoe => ww_devoe,
	o => ww_address(13));

-- Location: IOOBUF_X54_Y21_N56
\address[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(14),
	devoe => ww_devoe,
	o => ww_address(14));

-- Location: IOOBUF_X52_Y45_N53
\address[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(15),
	devoe => ww_devoe,
	o => ww_address(15));

-- Location: IOOBUF_X52_Y45_N2
\address[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(16),
	devoe => ww_devoe,
	o => ww_address(16));

-- Location: IOOBUF_X54_Y21_N39
\address[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(17),
	devoe => ww_devoe,
	o => ww_address(17));

-- Location: IOOBUF_X50_Y45_N2
\address[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => addr(18),
	devoe => ww_devoe,
	o => ww_address(18));

-- Location: IOOBUF_X54_Y14_N79
\RAMdata[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(0));

-- Location: IOOBUF_X54_Y14_N96
\RAMdata[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(1));

-- Location: IOOBUF_X54_Y16_N5
\RAMdata[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(2));

-- Location: IOOBUF_X54_Y16_N22
\RAMdata[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(3));

-- Location: IOOBUF_X54_Y15_N22
\RAMdata[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[4]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(4));

-- Location: IOOBUF_X54_Y17_N56
\RAMdata[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[5]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(5));

-- Location: IOOBUF_X52_Y45_N19
\RAMdata[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[6]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(6));

-- Location: IOOBUF_X54_Y20_N5
\RAMdata[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \RAMdata[7]~reg0_q\,
	devoe => ww_devoe,
	o => ww_RAMdata(7));

-- Location: IOOBUF_X54_Y14_N62
\WE~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_LessThan0~0_combout\,
	devoe => ww_devoe,
	o => ww_WE);

-- Location: IOOBUF_X54_Y14_N45
\OE~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_OE);

-- Location: IOOBUF_X54_Y15_N5
\CS~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_CS);

-- Location: IOOBUF_X0_Y18_N79
\LEDs[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(0));

-- Location: IOOBUF_X0_Y18_N96
\LEDs[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(1));

-- Location: IOOBUF_X0_Y18_N62
\LEDs[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(2));

-- Location: IOOBUF_X0_Y18_N45
\LEDs[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(3));

-- Location: IOOBUF_X0_Y19_N39
\LEDs[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(4));

-- Location: IOOBUF_X0_Y19_N56
\LEDs[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(5));

-- Location: IOOBUF_X0_Y19_N5
\LEDs[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(6));

-- Location: IOOBUF_X0_Y19_N22
\LEDs[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(7));

-- Location: IOOBUF_X0_Y20_N39
\LEDs[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(8));

-- Location: IOOBUF_X0_Y20_N56
\LEDs[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_LEDs(9));

-- Location: IOIBUF_X22_Y0_N1
\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G6
\clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk~input_o\,
	outclk => \clk~inputCLKENA0_outclk\);

-- Location: LABCELL_X50_Y22_N0
\Add2~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~9_sumout\ = SUM(( ticks(0) ) + ( VCC ) + ( !VCC ))
-- \Add2~10\ = CARRY(( ticks(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(0),
	cin => GND,
	sumout => \Add2~9_sumout\,
	cout => \Add2~10\);

-- Location: IOIBUF_X46_Y45_N92
\PCLK~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PCLK,
	o => \PCLK~input_o\);

-- Location: CLKCTRL_G12
\PCLK~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \PCLK~input_o\,
	outclk => \PCLK~inputCLKENA0_outclk\);

-- Location: IOIBUF_X33_Y0_N75
\getImagePin~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_getImagePin,
	o => \getImagePin~input_o\);

-- Location: IOIBUF_X43_Y45_N1
\VSYNC~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_VSYNC,
	o => \VSYNC~input_o\);

-- Location: LABCELL_X50_Y21_N51
\process_0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \process_0~0_combout\ = ( !\VSYNC~input_o\ & ( \getImagePin~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_getImagePin~input_o\,
	dataf => \ALT_INV_VSYNC~input_o\,
	combout => \process_0~0_combout\);

-- Location: FF_X50_Y21_N53
counting : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \process_0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \counting~q\);

-- Location: FF_X50_Y22_N2
\ticks[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~9_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(0));

-- Location: LABCELL_X50_Y22_N3
\Add2~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~1_sumout\ = SUM(( ticks(1) ) + ( GND ) + ( \Add2~10\ ))
-- \Add2~2\ = CARRY(( ticks(1) ) + ( GND ) + ( \Add2~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(1),
	cin => \Add2~10\,
	sumout => \Add2~1_sumout\,
	cout => \Add2~2\);

-- Location: FF_X50_Y22_N5
\ticks[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~1_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(1));

-- Location: MLABCELL_X49_Y21_N0
\Add1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~1_sumout\ = SUM(( addr(0) ) + ( VCC ) + ( !VCC ))
-- \Add1~2\ = CARRY(( addr(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_addr(0),
	cin => GND,
	sumout => \Add1~1_sumout\,
	cout => \Add1~2\);

-- Location: LABCELL_X50_Y22_N6
\Add2~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~5_sumout\ = SUM(( ticks(2) ) + ( GND ) + ( \Add2~2\ ))
-- \Add2~6\ = CARRY(( ticks(2) ) + ( GND ) + ( \Add2~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(2),
	cin => \Add2~2\,
	sumout => \Add2~5_sumout\,
	cout => \Add2~6\);

-- Location: FF_X50_Y22_N8
\ticks[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~5_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(2));

-- Location: LABCELL_X50_Y21_N54
\addr[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \addr[0]~0_combout\ = ( !ticks(2) & ( \counting~q\ & ( (!ticks(1) & !ticks(0)) ) ) ) # ( ticks(2) & ( !\counting~q\ ) ) # ( !ticks(2) & ( !\counting~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111110001000100010000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(1),
	datab => ALT_INV_ticks(0),
	datae => ALT_INV_ticks(2),
	dataf => \ALT_INV_counting~q\,
	combout => \addr[0]~0_combout\);

-- Location: FF_X49_Y21_N2
\addr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~1_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(0));

-- Location: MLABCELL_X49_Y21_N3
\Add1~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~5_sumout\ = SUM(( addr(1) ) + ( GND ) + ( \Add1~2\ ))
-- \Add1~6\ = CARRY(( addr(1) ) + ( GND ) + ( \Add1~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_addr(1),
	cin => \Add1~2\,
	sumout => \Add1~5_sumout\,
	cout => \Add1~6\);

-- Location: FF_X49_Y21_N5
\addr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~5_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(1));

-- Location: MLABCELL_X49_Y21_N6
\Add1~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~9_sumout\ = SUM(( addr(2) ) + ( GND ) + ( \Add1~6\ ))
-- \Add1~10\ = CARRY(( addr(2) ) + ( GND ) + ( \Add1~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_addr(2),
	cin => \Add1~6\,
	sumout => \Add1~9_sumout\,
	cout => \Add1~10\);

-- Location: FF_X49_Y21_N8
\addr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~9_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(2));

-- Location: MLABCELL_X49_Y21_N9
\Add1~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~13_sumout\ = SUM(( addr(3) ) + ( GND ) + ( \Add1~10\ ))
-- \Add1~14\ = CARRY(( addr(3) ) + ( GND ) + ( \Add1~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(3),
	cin => \Add1~10\,
	sumout => \Add1~13_sumout\,
	cout => \Add1~14\);

-- Location: FF_X49_Y21_N11
\addr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~13_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(3));

-- Location: MLABCELL_X49_Y21_N12
\Add1~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~17_sumout\ = SUM(( addr(4) ) + ( GND ) + ( \Add1~14\ ))
-- \Add1~18\ = CARRY(( addr(4) ) + ( GND ) + ( \Add1~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_addr(4),
	cin => \Add1~14\,
	sumout => \Add1~17_sumout\,
	cout => \Add1~18\);

-- Location: FF_X49_Y21_N14
\addr[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~17_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(4));

-- Location: MLABCELL_X49_Y21_N15
\Add1~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~21_sumout\ = SUM(( addr(5) ) + ( GND ) + ( \Add1~18\ ))
-- \Add1~22\ = CARRY(( addr(5) ) + ( GND ) + ( \Add1~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(5),
	cin => \Add1~18\,
	sumout => \Add1~21_sumout\,
	cout => \Add1~22\);

-- Location: FF_X49_Y21_N17
\addr[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~21_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(5));

-- Location: MLABCELL_X49_Y21_N18
\Add1~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~25_sumout\ = SUM(( addr(6) ) + ( GND ) + ( \Add1~22\ ))
-- \Add1~26\ = CARRY(( addr(6) ) + ( GND ) + ( \Add1~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(6),
	cin => \Add1~22\,
	sumout => \Add1~25_sumout\,
	cout => \Add1~26\);

-- Location: FF_X49_Y21_N20
\addr[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~25_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(6));

-- Location: MLABCELL_X49_Y21_N21
\Add1~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~29_sumout\ = SUM(( addr(7) ) + ( GND ) + ( \Add1~26\ ))
-- \Add1~30\ = CARRY(( addr(7) ) + ( GND ) + ( \Add1~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_addr(7),
	cin => \Add1~26\,
	sumout => \Add1~29_sumout\,
	cout => \Add1~30\);

-- Location: FF_X49_Y21_N23
\addr[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~29_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(7));

-- Location: MLABCELL_X49_Y21_N24
\Add1~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~33_sumout\ = SUM(( addr(8) ) + ( GND ) + ( \Add1~30\ ))
-- \Add1~34\ = CARRY(( addr(8) ) + ( GND ) + ( \Add1~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(8),
	cin => \Add1~30\,
	sumout => \Add1~33_sumout\,
	cout => \Add1~34\);

-- Location: FF_X49_Y21_N26
\addr[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~33_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(8));

-- Location: MLABCELL_X49_Y21_N27
\Add1~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~37_sumout\ = SUM(( addr(9) ) + ( GND ) + ( \Add1~34\ ))
-- \Add1~38\ = CARRY(( addr(9) ) + ( GND ) + ( \Add1~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_addr(9),
	cin => \Add1~34\,
	sumout => \Add1~37_sumout\,
	cout => \Add1~38\);

-- Location: FF_X49_Y21_N29
\addr[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~37_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(9));

-- Location: MLABCELL_X49_Y21_N30
\Add1~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~41_sumout\ = SUM(( addr(10) ) + ( GND ) + ( \Add1~38\ ))
-- \Add1~42\ = CARRY(( addr(10) ) + ( GND ) + ( \Add1~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_addr(10),
	cin => \Add1~38\,
	sumout => \Add1~41_sumout\,
	cout => \Add1~42\);

-- Location: FF_X49_Y21_N32
\addr[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~41_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(10));

-- Location: MLABCELL_X49_Y21_N33
\Add1~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~45_sumout\ = SUM(( addr(11) ) + ( GND ) + ( \Add1~42\ ))
-- \Add1~46\ = CARRY(( addr(11) ) + ( GND ) + ( \Add1~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_addr(11),
	cin => \Add1~42\,
	sumout => \Add1~45_sumout\,
	cout => \Add1~46\);

-- Location: FF_X49_Y21_N35
\addr[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~45_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(11));

-- Location: MLABCELL_X49_Y21_N36
\Add1~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~49_sumout\ = SUM(( addr(12) ) + ( GND ) + ( \Add1~46\ ))
-- \Add1~50\ = CARRY(( addr(12) ) + ( GND ) + ( \Add1~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(12),
	cin => \Add1~46\,
	sumout => \Add1~49_sumout\,
	cout => \Add1~50\);

-- Location: FF_X49_Y21_N38
\addr[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~49_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(12));

-- Location: MLABCELL_X49_Y21_N39
\Add1~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~53_sumout\ = SUM(( addr(13) ) + ( GND ) + ( \Add1~50\ ))
-- \Add1~54\ = CARRY(( addr(13) ) + ( GND ) + ( \Add1~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(13),
	cin => \Add1~50\,
	sumout => \Add1~53_sumout\,
	cout => \Add1~54\);

-- Location: FF_X49_Y21_N41
\addr[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~53_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(13));

-- Location: MLABCELL_X49_Y21_N42
\Add1~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~57_sumout\ = SUM(( addr(14) ) + ( GND ) + ( \Add1~54\ ))
-- \Add1~58\ = CARRY(( addr(14) ) + ( GND ) + ( \Add1~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_addr(14),
	cin => \Add1~54\,
	sumout => \Add1~57_sumout\,
	cout => \Add1~58\);

-- Location: FF_X49_Y21_N44
\addr[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~57_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(14));

-- Location: MLABCELL_X49_Y21_N45
\Add1~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~61_sumout\ = SUM(( addr(15) ) + ( GND ) + ( \Add1~58\ ))
-- \Add1~62\ = CARRY(( addr(15) ) + ( GND ) + ( \Add1~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(15),
	cin => \Add1~58\,
	sumout => \Add1~61_sumout\,
	cout => \Add1~62\);

-- Location: FF_X49_Y21_N47
\addr[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~61_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(15));

-- Location: MLABCELL_X49_Y21_N48
\Add1~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~65_sumout\ = SUM(( addr(16) ) + ( GND ) + ( \Add1~62\ ))
-- \Add1~66\ = CARRY(( addr(16) ) + ( GND ) + ( \Add1~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(16),
	cin => \Add1~62\,
	sumout => \Add1~65_sumout\,
	cout => \Add1~66\);

-- Location: FF_X49_Y21_N50
\addr[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~65_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(16));

-- Location: MLABCELL_X49_Y21_N51
\Add1~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~69_sumout\ = SUM(( addr(17) ) + ( GND ) + ( \Add1~66\ ))
-- \Add1~70\ = CARRY(( addr(17) ) + ( GND ) + ( \Add1~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_addr(17),
	cin => \Add1~66\,
	sumout => \Add1~69_sumout\,
	cout => \Add1~70\);

-- Location: FF_X49_Y21_N53
\addr[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~69_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(17));

-- Location: MLABCELL_X49_Y21_N54
\Add1~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add1~73_sumout\ = SUM(( addr(18) ) + ( GND ) + ( \Add1~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_addr(18),
	cin => \Add1~70\,
	sumout => \Add1~73_sumout\);

-- Location: FF_X49_Y21_N56
\addr[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add1~73_sumout\,
	sclr => \ALT_INV_counting~q\,
	ena => \addr[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => addr(18));

-- Location: LABCELL_X48_Y20_N0
\Add0~125\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~125_sumout\ = SUM(( i(0) ) + ( VCC ) + ( !VCC ))
-- \Add0~126\ = CARRY(( i(0) ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(0),
	cin => GND,
	sumout => \Add0~125_sumout\,
	cout => \Add0~126\);

-- Location: LABCELL_X48_Y20_N39
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( i(13) ) + ( GND ) + ( \Add0~114\ ))
-- \Add0~46\ = CARRY(( i(13) ) + ( GND ) + ( \Add0~114\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(13),
	cin => \Add0~114\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: LABCELL_X48_Y20_N42
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( i(14) ) + ( GND ) + ( \Add0~46\ ))
-- \Add0~50\ = CARRY(( i(14) ) + ( GND ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_i(14),
	cin => \Add0~46\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

-- Location: IOIBUF_X40_Y45_N41
\HREF~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_HREF,
	o => \HREF~input_o\);

-- Location: MLABCELL_X49_Y19_N9
\process_0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \process_0~1_combout\ = ( \getImagePin~input_o\ & ( (!\VSYNC~input_o\ & \HREF~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001010000010100000101000001010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_VSYNC~input_o\,
	datac => \ALT_INV_HREF~input_o\,
	dataf => \ALT_INV_getImagePin~input_o\,
	combout => \process_0~1_combout\);

-- Location: FF_X48_Y20_N44
\i[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~49_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(14));

-- Location: LABCELL_X48_Y20_N45
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( i(15) ) + ( GND ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( i(15) ) + ( GND ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(15),
	cin => \Add0~50\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X48_Y20_N47
\i[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(15));

-- Location: LABCELL_X48_Y20_N48
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( i(16) ) + ( GND ) + ( \Add0~54\ ))
-- \Add0~58\ = CARRY(( i(16) ) + ( GND ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(16),
	cin => \Add0~54\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X48_Y20_N50
\i[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(16));

-- Location: LABCELL_X48_Y20_N51
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( i(17) ) + ( GND ) + ( \Add0~58\ ))
-- \Add0~62\ = CARRY(( i(17) ) + ( GND ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(17),
	cin => \Add0~58\,
	sumout => \Add0~61_sumout\,
	cout => \Add0~62\);

-- Location: FF_X48_Y20_N53
\i[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(17));

-- Location: LABCELL_X48_Y20_N54
\Add0~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~65_sumout\ = SUM(( i(18) ) + ( GND ) + ( \Add0~62\ ))
-- \Add0~66\ = CARRY(( i(18) ) + ( GND ) + ( \Add0~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(18),
	cin => \Add0~62\,
	sumout => \Add0~65_sumout\,
	cout => \Add0~66\);

-- Location: FF_X48_Y20_N56
\i[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~65_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(18));

-- Location: LABCELL_X48_Y20_N57
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( i(19) ) + ( GND ) + ( \Add0~66\ ))
-- \Add0~22\ = CARRY(( i(19) ) + ( GND ) + ( \Add0~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(19),
	cin => \Add0~66\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: LABCELL_X47_Y19_N6
\i[19]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \i[19]~feeder_combout\ = ( \Add0~21_sumout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_Add0~21_sumout\,
	combout => \i[19]~feeder_combout\);

-- Location: FF_X47_Y19_N8
\i[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \i[19]~feeder_combout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(19));

-- Location: LABCELL_X48_Y19_N0
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( i(20) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( i(20) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(20),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X48_Y19_N2
\i[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(20));

-- Location: LABCELL_X48_Y19_N3
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( i(21) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( i(21) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(21),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X48_Y19_N5
\i[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(21));

-- Location: LABCELL_X48_Y19_N6
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( i(22) ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~34\ = CARRY(( i(22) ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_i(22),
	cin => \Add0~30\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X48_Y19_N8
\i[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(22));

-- Location: LABCELL_X48_Y19_N9
\Add0~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~69_sumout\ = SUM(( i(23) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~70\ = CARRY(( i(23) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(23),
	cin => \Add0~34\,
	sumout => \Add0~69_sumout\,
	cout => \Add0~70\);

-- Location: FF_X48_Y19_N11
\i[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~69_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(23));

-- Location: LABCELL_X48_Y19_N12
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( i(24) ) + ( GND ) + ( \Add0~70\ ))
-- \Add0~38\ = CARRY(( i(24) ) + ( GND ) + ( \Add0~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_i(24),
	cin => \Add0~70\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X48_Y19_N14
\i[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(24));

-- Location: LABCELL_X48_Y19_N15
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( i(25) ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~42\ = CARRY(( i(25) ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(25),
	cin => \Add0~38\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: FF_X48_Y19_N17
\i[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(25));

-- Location: LABCELL_X48_Y19_N18
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( i(26) ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~2\ = CARRY(( i(26) ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(26),
	cin => \Add0~42\,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: FF_X48_Y19_N20
\i[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(26));

-- Location: LABCELL_X48_Y19_N21
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( i(27) ) + ( GND ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( i(27) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(27),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X48_Y19_N23
\i[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(27));

-- Location: LABCELL_X48_Y19_N24
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( i(28) ) + ( GND ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( i(28) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(28),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X48_Y19_N26
\i[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(28));

-- Location: LABCELL_X48_Y19_N27
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( i(29) ) + ( GND ) + ( \Add0~10\ ))
-- \Add0~14\ = CARRY(( i(29) ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(29),
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X48_Y19_N29
\i[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(29));

-- Location: LABCELL_X48_Y19_N30
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( i(30) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~18\ = CARRY(( i(30) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_i(30),
	cin => \Add0~14\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X48_Y19_N32
\i[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(30));

-- Location: LABCELL_X48_Y19_N33
\Add0~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~117_sumout\ = SUM(( i(31) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(31),
	cin => \Add0~18\,
	sumout => \Add0~117_sumout\);

-- Location: FF_X48_Y19_N35
\i[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~117_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(31));

-- Location: MLABCELL_X49_Y19_N3
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( !i(27) & ( (!i(26) & (!i(28) & (!i(29) & !i(30)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000100000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(26),
	datab => ALT_INV_i(28),
	datac => ALT_INV_i(29),
	datad => ALT_INV_i(30),
	dataf => ALT_INV_i(27),
	combout => \Equal0~0_combout\);

-- Location: LABCELL_X47_Y19_N48
\Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = ( !i(20) & ( !i(24) & ( (!i(21) & (!i(22) & (!i(25) & !i(19)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(21),
	datab => ALT_INV_i(22),
	datac => ALT_INV_i(25),
	datad => ALT_INV_i(19),
	datae => ALT_INV_i(20),
	dataf => ALT_INV_i(24),
	combout => \Equal0~1_combout\);

-- Location: LABCELL_X48_Y19_N48
\Equal0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = ( !i(10) & ( !i(8) & ( (!i(11) & (!i(9) & (!i(7) & !i(12)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(11),
	datab => ALT_INV_i(9),
	datac => ALT_INV_i(7),
	datad => ALT_INV_i(12),
	datae => ALT_INV_i(10),
	dataf => ALT_INV_i(8),
	combout => \Equal0~4_combout\);

-- Location: LABCELL_X47_Y19_N24
\Equal0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = ( !i(6) & ( !i(4) & ( (!i(23) & (!i(2) & (!i(3) & !i(5)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(23),
	datab => ALT_INV_i(2),
	datac => ALT_INV_i(3),
	datad => ALT_INV_i(5),
	datae => ALT_INV_i(6),
	dataf => ALT_INV_i(4),
	combout => \Equal0~3_combout\);

-- Location: LABCELL_X48_Y19_N42
\Equal0~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~7_combout\ = ( \Equal0~3_combout\ & ( (\Equal0~1_combout\ & (\Equal0~4_combout\ & \Equal0~2_combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000110000000000000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_Equal0~4_combout\,
	datad => \ALT_INV_Equal0~2_combout\,
	dataf => \ALT_INV_Equal0~3_combout\,
	combout => \Equal0~7_combout\);

-- Location: LABCELL_X48_Y19_N54
\LessThan2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~0_combout\ = ( \Equal0~7_combout\ & ( (!i(31) & ((!\Equal0~0_combout\) # ((i(1) & i(0))))) ) ) # ( !\Equal0~7_combout\ & ( !i(31) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101010100000101000101010000010100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(31),
	datab => ALT_INV_i(1),
	datac => \ALT_INV_Equal0~0_combout\,
	datad => ALT_INV_i(0),
	dataf => \ALT_INV_Equal0~7_combout\,
	combout => \LessThan2~0_combout\);

-- Location: FF_X48_Y20_N2
\i[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~125_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(0));

-- Location: LABCELL_X48_Y20_N3
\Add0~121\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~121_sumout\ = SUM(( i(1) ) + ( GND ) + ( \Add0~126\ ))
-- \Add0~122\ = CARRY(( i(1) ) + ( GND ) + ( \Add0~126\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(1),
	cin => \Add0~126\,
	sumout => \Add0~121_sumout\,
	cout => \Add0~122\);

-- Location: FF_X48_Y20_N5
\i[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~121_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(1));

-- Location: LABCELL_X48_Y20_N6
\Add0~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~73_sumout\ = SUM(( i(2) ) + ( GND ) + ( \Add0~122\ ))
-- \Add0~74\ = CARRY(( i(2) ) + ( GND ) + ( \Add0~122\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_i(2),
	cin => \Add0~122\,
	sumout => \Add0~73_sumout\,
	cout => \Add0~74\);

-- Location: FF_X48_Y20_N8
\i[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~73_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(2));

-- Location: LABCELL_X48_Y20_N9
\Add0~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~77_sumout\ = SUM(( i(3) ) + ( GND ) + ( \Add0~74\ ))
-- \Add0~78\ = CARRY(( i(3) ) + ( GND ) + ( \Add0~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(3),
	cin => \Add0~74\,
	sumout => \Add0~77_sumout\,
	cout => \Add0~78\);

-- Location: FF_X48_Y20_N11
\i[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~77_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(3));

-- Location: LABCELL_X48_Y20_N12
\Add0~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~81_sumout\ = SUM(( i(4) ) + ( GND ) + ( \Add0~78\ ))
-- \Add0~82\ = CARRY(( i(4) ) + ( GND ) + ( \Add0~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_i(4),
	cin => \Add0~78\,
	sumout => \Add0~81_sumout\,
	cout => \Add0~82\);

-- Location: FF_X48_Y20_N14
\i[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~81_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(4));

-- Location: LABCELL_X48_Y20_N15
\Add0~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~85_sumout\ = SUM(( i(5) ) + ( GND ) + ( \Add0~82\ ))
-- \Add0~86\ = CARRY(( i(5) ) + ( GND ) + ( \Add0~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(5),
	cin => \Add0~82\,
	sumout => \Add0~85_sumout\,
	cout => \Add0~86\);

-- Location: FF_X48_Y20_N17
\i[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~85_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(5));

-- Location: LABCELL_X48_Y20_N18
\Add0~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~89_sumout\ = SUM(( i(6) ) + ( GND ) + ( \Add0~86\ ))
-- \Add0~90\ = CARRY(( i(6) ) + ( GND ) + ( \Add0~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(6),
	cin => \Add0~86\,
	sumout => \Add0~89_sumout\,
	cout => \Add0~90\);

-- Location: FF_X48_Y20_N20
\i[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~89_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(6));

-- Location: LABCELL_X48_Y20_N21
\Add0~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~93_sumout\ = SUM(( i(7) ) + ( GND ) + ( \Add0~90\ ))
-- \Add0~94\ = CARRY(( i(7) ) + ( GND ) + ( \Add0~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(7),
	cin => \Add0~90\,
	sumout => \Add0~93_sumout\,
	cout => \Add0~94\);

-- Location: FF_X48_Y20_N23
\i[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~93_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(7));

-- Location: LABCELL_X48_Y20_N24
\Add0~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~97_sumout\ = SUM(( i(8) ) + ( GND ) + ( \Add0~94\ ))
-- \Add0~98\ = CARRY(( i(8) ) + ( GND ) + ( \Add0~94\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_i(8),
	cin => \Add0~94\,
	sumout => \Add0~97_sumout\,
	cout => \Add0~98\);

-- Location: FF_X48_Y20_N26
\i[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~97_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(8));

-- Location: LABCELL_X48_Y20_N27
\Add0~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~101_sumout\ = SUM(( i(9) ) + ( GND ) + ( \Add0~98\ ))
-- \Add0~102\ = CARRY(( i(9) ) + ( GND ) + ( \Add0~98\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(9),
	cin => \Add0~98\,
	sumout => \Add0~101_sumout\,
	cout => \Add0~102\);

-- Location: FF_X48_Y20_N29
\i[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~101_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(9));

-- Location: LABCELL_X48_Y20_N30
\Add0~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~105_sumout\ = SUM(( i(10) ) + ( GND ) + ( \Add0~102\ ))
-- \Add0~106\ = CARRY(( i(10) ) + ( GND ) + ( \Add0~102\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_i(10),
	cin => \Add0~102\,
	sumout => \Add0~105_sumout\,
	cout => \Add0~106\);

-- Location: FF_X48_Y20_N32
\i[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~105_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(10));

-- Location: LABCELL_X48_Y20_N33
\Add0~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~109_sumout\ = SUM(( i(11) ) + ( GND ) + ( \Add0~106\ ))
-- \Add0~110\ = CARRY(( i(11) ) + ( GND ) + ( \Add0~106\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(11),
	cin => \Add0~106\,
	sumout => \Add0~109_sumout\,
	cout => \Add0~110\);

-- Location: FF_X48_Y19_N53
\i[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \Add0~109_sumout\,
	sclr => \LessThan2~0_combout\,
	sload => VCC,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(11));

-- Location: LABCELL_X48_Y20_N36
\Add0~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~113_sumout\ = SUM(( i(12) ) + ( GND ) + ( \Add0~110\ ))
-- \Add0~114\ = CARRY(( i(12) ) + ( GND ) + ( \Add0~110\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_i(12),
	cin => \Add0~110\,
	sumout => \Add0~113_sumout\,
	cout => \Add0~114\);

-- Location: FF_X48_Y20_N38
\i[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~113_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(12));

-- Location: FF_X48_Y20_N41
\i[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	sclr => \LessThan2~0_combout\,
	ena => \process_0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(13));

-- Location: LABCELL_X48_Y19_N36
\Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = ( !i(15) & ( !i(17) & ( (!i(13) & (!i(18) & (!i(16) & !i(14)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(13),
	datab => ALT_INV_i(18),
	datac => ALT_INV_i(16),
	datad => ALT_INV_i(14),
	datae => ALT_INV_i(15),
	dataf => ALT_INV_i(17),
	combout => \Equal0~2_combout\);

-- Location: LABCELL_X48_Y19_N45
\Equal0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~5_combout\ = ( !i(0) & ( (!i(31) & !i(1)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010000010100000101000001010000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_i(31),
	datac => ALT_INV_i(1),
	dataf => ALT_INV_i(0),
	combout => \Equal0~5_combout\);

-- Location: MLABCELL_X49_Y19_N30
\Equal0~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~6_combout\ = ( \Equal0~0_combout\ & ( \Equal0~5_combout\ & ( (\Equal0~2_combout\ & (\Equal0~1_combout\ & (\Equal0~3_combout\ & \Equal0~4_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~2_combout\,
	datab => \ALT_INV_Equal0~1_combout\,
	datac => \ALT_INV_Equal0~3_combout\,
	datad => \ALT_INV_Equal0~4_combout\,
	datae => \ALT_INV_Equal0~0_combout\,
	dataf => \ALT_INV_Equal0~5_combout\,
	combout => \Equal0~6_combout\);

-- Location: IOIBUF_X34_Y45_N35
\CAMdata[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(6),
	o => \CAMdata[6]~input_o\);

-- Location: MLABCELL_X49_Y22_N42
\Decoder0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~0_combout\ = ( !i(0) & ( (!\VSYNC~input_o\ & (\getImagePin~input_o\ & (\HREF~input_o\ & !i(1)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001000000000000000100000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_VSYNC~input_o\,
	datab => \ALT_INV_getImagePin~input_o\,
	datac => \ALT_INV_HREF~input_o\,
	datad => ALT_INV_i(1),
	dataf => ALT_INV_i(0),
	combout => \Decoder0~0_combout\);

-- Location: FF_X50_Y21_N41
\preArray[0][6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[6]~input_o\,
	sload => VCC,
	ena => \Decoder0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[0][6]~q\);

-- Location: LABCELL_X50_Y21_N45
\postArray[1][0]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][0]~combout\ = ( \Equal0~6_combout\ & ( \preArray[0][6]~q\ ) ) # ( !\Equal0~6_combout\ & ( \preArray[0][6]~q\ & ( \postArray[1][0]~combout\ ) ) ) # ( !\Equal0~6_combout\ & ( !\preArray[0][6]~q\ & ( \postArray[1][0]~combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000000001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_postArray[1][0]~combout\,
	datae => \ALT_INV_Equal0~6_combout\,
	dataf => \ALT_INV_preArray[0][6]~q\,
	combout => \postArray[1][0]~combout\);

-- Location: FF_X50_Y21_N43
\RAMdata[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \postArray[1][0]~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[0]~reg0_q\);

-- Location: IOIBUF_X42_Y45_N18
\CAMdata[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(7),
	o => \CAMdata[7]~input_o\);

-- Location: FF_X49_Y22_N41
\preArray[0][7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[7]~input_o\,
	sload => VCC,
	ena => \Decoder0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[0][7]~q\);

-- Location: MLABCELL_X49_Y22_N48
\postArray[1][1]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][1]~combout\ = ( \Equal0~6_combout\ & ( \preArray[0][7]~q\ ) ) # ( !\Equal0~6_combout\ & ( \preArray[0][7]~q\ & ( \postArray[1][1]~combout\ ) ) ) # ( !\Equal0~6_combout\ & ( !\preArray[0][7]~q\ & ( \postArray[1][1]~combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000000001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_postArray[1][1]~combout\,
	datae => \ALT_INV_Equal0~6_combout\,
	dataf => \ALT_INV_preArray[0][7]~q\,
	combout => \postArray[1][1]~combout\);

-- Location: MLABCELL_X49_Y22_N57
\RAMdata[1]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAMdata[1]~reg0feeder_combout\ = ( \postArray[1][1]~combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_postArray[1][1]~combout\,
	combout => \RAMdata[1]~reg0feeder_combout\);

-- Location: FF_X49_Y22_N58
\RAMdata[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \RAMdata[1]~reg0feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[1]~reg0_q\);

-- Location: LABCELL_X50_Y20_N51
\preArray[2][6]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \preArray[2][6]~feeder_combout\ = ( \CAMdata[6]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_CAMdata[6]~input_o\,
	combout => \preArray[2][6]~feeder_combout\);

-- Location: MLABCELL_X49_Y22_N36
\Decoder0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~1_combout\ = ( !i(0) & ( (!\VSYNC~input_o\ & (\getImagePin~input_o\ & (\HREF~input_o\ & i(1)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000010000000000000001000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_VSYNC~input_o\,
	datab => \ALT_INV_getImagePin~input_o\,
	datac => \ALT_INV_HREF~input_o\,
	datad => ALT_INV_i(1),
	dataf => ALT_INV_i(0),
	combout => \Decoder0~1_combout\);

-- Location: FF_X50_Y20_N53
\preArray[2][6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	d => \preArray[2][6]~feeder_combout\,
	ena => \Decoder0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[2][6]~q\);

-- Location: LABCELL_X50_Y20_N57
\postArray[1][2]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][2]~combout\ = ( \postArray[1][2]~combout\ & ( \preArray[2][6]~q\ ) ) # ( !\postArray[1][2]~combout\ & ( \preArray[2][6]~q\ & ( \Equal0~6_combout\ ) ) ) # ( \postArray[1][2]~combout\ & ( !\preArray[2][6]~q\ & ( !\Equal0~6_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000110011001100111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~6_combout\,
	datae => \ALT_INV_postArray[1][2]~combout\,
	dataf => \ALT_INV_preArray[2][6]~q\,
	combout => \postArray[1][2]~combout\);

-- Location: LABCELL_X53_Y20_N0
\RAMdata[2]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAMdata[2]~reg0feeder_combout\ = \postArray[1][2]~combout\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_postArray[1][2]~combout\,
	combout => \RAMdata[2]~reg0feeder_combout\);

-- Location: FF_X53_Y20_N1
\RAMdata[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \RAMdata[2]~reg0feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[2]~reg0_q\);

-- Location: FF_X48_Y21_N53
\preArray[2][7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[7]~input_o\,
	sload => VCC,
	ena => \Decoder0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[2][7]~q\);

-- Location: LABCELL_X48_Y21_N36
\postArray[1][3]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][3]~combout\ = ( \Equal0~6_combout\ & ( \preArray[2][7]~q\ ) ) # ( !\Equal0~6_combout\ & ( \preArray[2][7]~q\ & ( \postArray[1][3]~combout\ ) ) ) # ( !\Equal0~6_combout\ & ( !\preArray[2][7]~q\ & ( \postArray[1][3]~combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000000001111000011111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_postArray[1][3]~combout\,
	datae => \ALT_INV_Equal0~6_combout\,
	dataf => \ALT_INV_preArray[2][7]~q\,
	combout => \postArray[1][3]~combout\);

-- Location: FF_X49_Y20_N25
\RAMdata[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \postArray[1][3]~combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[3]~reg0_q\);

-- Location: IOIBUF_X46_Y45_N75
\CAMdata[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(4),
	o => \CAMdata[4]~input_o\);

-- Location: MLABCELL_X49_Y19_N18
\Decoder0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~3_combout\ = ( i(0) & ( (!\VSYNC~input_o\ & (\HREF~input_o\ & (\getImagePin~input_o\ & i(1)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000100000000000000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_VSYNC~input_o\,
	datab => \ALT_INV_HREF~input_o\,
	datac => \ALT_INV_getImagePin~input_o\,
	datad => ALT_INV_i(1),
	dataf => ALT_INV_i(0),
	combout => \Decoder0~3_combout\);

-- Location: FF_X48_Y19_N41
\preArray[3][4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[4]~input_o\,
	sload => VCC,
	ena => \Decoder0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[3][4]~q\);

-- Location: LABCELL_X48_Y19_N57
\postArray[1][4]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][4]~combout\ = ( \preArray[3][4]~q\ & ( (\Equal0~6_combout\) # (\postArray[1][4]~combout\) ) ) # ( !\preArray[3][4]~q\ & ( (\postArray[1][4]~combout\ & !\Equal0~6_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011110000000000001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_postArray[1][4]~combout\,
	datad => \ALT_INV_Equal0~6_combout\,
	dataf => \ALT_INV_preArray[3][4]~q\,
	combout => \postArray[1][4]~combout\);

-- Location: LABCELL_X50_Y22_N9
\Add2~65\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~65_sumout\ = SUM(( ticks(3) ) + ( GND ) + ( \Add2~6\ ))
-- \Add2~66\ = CARRY(( ticks(3) ) + ( GND ) + ( \Add2~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(3),
	cin => \Add2~6\,
	sumout => \Add2~65_sumout\,
	cout => \Add2~66\);

-- Location: FF_X50_Y22_N11
\ticks[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~65_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(3));

-- Location: LABCELL_X50_Y22_N12
\Add2~69\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~69_sumout\ = SUM(( ticks(4) ) + ( GND ) + ( \Add2~66\ ))
-- \Add2~70\ = CARRY(( ticks(4) ) + ( GND ) + ( \Add2~66\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(4),
	cin => \Add2~66\,
	sumout => \Add2~69_sumout\,
	cout => \Add2~70\);

-- Location: FF_X50_Y22_N14
\ticks[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~69_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(4));

-- Location: LABCELL_X50_Y22_N15
\Add2~73\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~73_sumout\ = SUM(( ticks(5) ) + ( GND ) + ( \Add2~70\ ))
-- \Add2~74\ = CARRY(( ticks(5) ) + ( GND ) + ( \Add2~70\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(5),
	cin => \Add2~70\,
	sumout => \Add2~73_sumout\,
	cout => \Add2~74\);

-- Location: FF_X50_Y22_N17
\ticks[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~73_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(5));

-- Location: LABCELL_X50_Y22_N18
\Add2~77\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~77_sumout\ = SUM(( ticks(6) ) + ( GND ) + ( \Add2~74\ ))
-- \Add2~78\ = CARRY(( ticks(6) ) + ( GND ) + ( \Add2~74\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(6),
	cin => \Add2~74\,
	sumout => \Add2~77_sumout\,
	cout => \Add2~78\);

-- Location: FF_X50_Y22_N20
\ticks[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~77_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(6));

-- Location: LABCELL_X50_Y22_N21
\Add2~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~33_sumout\ = SUM(( ticks(7) ) + ( GND ) + ( \Add2~78\ ))
-- \Add2~34\ = CARRY(( ticks(7) ) + ( GND ) + ( \Add2~78\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(7),
	cin => \Add2~78\,
	sumout => \Add2~33_sumout\,
	cout => \Add2~34\);

-- Location: FF_X50_Y22_N23
\ticks[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~33_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(7));

-- Location: LABCELL_X50_Y22_N24
\Add2~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~21_sumout\ = SUM(( ticks(8) ) + ( GND ) + ( \Add2~34\ ))
-- \Add2~22\ = CARRY(( ticks(8) ) + ( GND ) + ( \Add2~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(8),
	cin => \Add2~34\,
	sumout => \Add2~21_sumout\,
	cout => \Add2~22\);

-- Location: FF_X50_Y22_N26
\ticks[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~21_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(8));

-- Location: LABCELL_X50_Y22_N27
\Add2~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~57_sumout\ = SUM(( ticks(9) ) + ( GND ) + ( \Add2~22\ ))
-- \Add2~58\ = CARRY(( ticks(9) ) + ( GND ) + ( \Add2~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(9),
	cin => \Add2~22\,
	sumout => \Add2~57_sumout\,
	cout => \Add2~58\);

-- Location: FF_X50_Y22_N29
\ticks[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~57_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(9));

-- Location: LABCELL_X50_Y22_N30
\Add2~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~25_sumout\ = SUM(( ticks(10) ) + ( GND ) + ( \Add2~58\ ))
-- \Add2~26\ = CARRY(( ticks(10) ) + ( GND ) + ( \Add2~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(10),
	cin => \Add2~58\,
	sumout => \Add2~25_sumout\,
	cout => \Add2~26\);

-- Location: FF_X50_Y22_N32
\ticks[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~25_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(10));

-- Location: LABCELL_X50_Y22_N33
\Add2~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~17_sumout\ = SUM(( ticks(11) ) + ( GND ) + ( \Add2~26\ ))
-- \Add2~18\ = CARRY(( ticks(11) ) + ( GND ) + ( \Add2~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(11),
	cin => \Add2~26\,
	sumout => \Add2~17_sumout\,
	cout => \Add2~18\);

-- Location: FF_X50_Y22_N35
\ticks[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~17_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(11));

-- Location: LABCELL_X50_Y22_N36
\Add2~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~53_sumout\ = SUM(( ticks(12) ) + ( GND ) + ( \Add2~18\ ))
-- \Add2~54\ = CARRY(( ticks(12) ) + ( GND ) + ( \Add2~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(12),
	cin => \Add2~18\,
	sumout => \Add2~53_sumout\,
	cout => \Add2~54\);

-- Location: FF_X50_Y22_N38
\ticks[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~53_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(12));

-- Location: LABCELL_X50_Y22_N39
\Add2~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~49_sumout\ = SUM(( ticks(13) ) + ( GND ) + ( \Add2~54\ ))
-- \Add2~50\ = CARRY(( ticks(13) ) + ( GND ) + ( \Add2~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(13),
	cin => \Add2~54\,
	sumout => \Add2~49_sumout\,
	cout => \Add2~50\);

-- Location: FF_X50_Y22_N41
\ticks[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~49_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(13));

-- Location: LABCELL_X50_Y22_N42
\Add2~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~45_sumout\ = SUM(( ticks(14) ) + ( GND ) + ( \Add2~50\ ))
-- \Add2~46\ = CARRY(( ticks(14) ) + ( GND ) + ( \Add2~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(14),
	cin => \Add2~50\,
	sumout => \Add2~45_sumout\,
	cout => \Add2~46\);

-- Location: FF_X50_Y22_N44
\ticks[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~45_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(14));

-- Location: LABCELL_X50_Y22_N45
\Add2~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~41_sumout\ = SUM(( ticks(15) ) + ( GND ) + ( \Add2~46\ ))
-- \Add2~42\ = CARRY(( ticks(15) ) + ( GND ) + ( \Add2~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(15),
	cin => \Add2~46\,
	sumout => \Add2~41_sumout\,
	cout => \Add2~42\);

-- Location: FF_X50_Y22_N47
\ticks[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~41_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(15));

-- Location: LABCELL_X50_Y22_N48
\Add2~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~37_sumout\ = SUM(( ticks(16) ) + ( GND ) + ( \Add2~42\ ))
-- \Add2~38\ = CARRY(( ticks(16) ) + ( GND ) + ( \Add2~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(16),
	cin => \Add2~42\,
	sumout => \Add2~37_sumout\,
	cout => \Add2~38\);

-- Location: FF_X50_Y22_N50
\ticks[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~37_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(16));

-- Location: MLABCELL_X49_Y22_N27
\LessThan3~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan3~1_combout\ = ( !ticks(14) & ( !ticks(13) & ( (!ticks(7) & (!ticks(12) & (!ticks(16) & !ticks(15)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(7),
	datab => ALT_INV_ticks(12),
	datac => ALT_INV_ticks(16),
	datad => ALT_INV_ticks(15),
	datae => ALT_INV_ticks(14),
	dataf => ALT_INV_ticks(13),
	combout => \LessThan3~1_combout\);

-- Location: LABCELL_X50_Y22_N51
\Add2~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~61_sumout\ = SUM(( ticks(17) ) + ( GND ) + ( \Add2~38\ ))
-- \Add2~62\ = CARRY(( ticks(17) ) + ( GND ) + ( \Add2~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(17),
	cin => \Add2~38\,
	sumout => \Add2~61_sumout\,
	cout => \Add2~62\);

-- Location: FF_X50_Y22_N53
\ticks[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~61_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(17));

-- Location: LABCELL_X50_Y22_N54
\Add2~125\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~125_sumout\ = SUM(( ticks(18) ) + ( GND ) + ( \Add2~62\ ))
-- \Add2~126\ = CARRY(( ticks(18) ) + ( GND ) + ( \Add2~62\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(18),
	cin => \Add2~62\,
	sumout => \Add2~125_sumout\,
	cout => \Add2~126\);

-- Location: FF_X50_Y22_N56
\ticks[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~125_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(18));

-- Location: LABCELL_X50_Y22_N57
\Add2~121\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~121_sumout\ = SUM(( ticks(19) ) + ( GND ) + ( \Add2~126\ ))
-- \Add2~122\ = CARRY(( ticks(19) ) + ( GND ) + ( \Add2~126\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(19),
	cin => \Add2~126\,
	sumout => \Add2~121_sumout\,
	cout => \Add2~122\);

-- Location: FF_X50_Y22_N59
\ticks[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~121_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(19));

-- Location: LABCELL_X50_Y21_N0
\Add2~117\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~117_sumout\ = SUM(( ticks(20) ) + ( GND ) + ( \Add2~122\ ))
-- \Add2~118\ = CARRY(( ticks(20) ) + ( GND ) + ( \Add2~122\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(20),
	cin => \Add2~122\,
	sumout => \Add2~117_sumout\,
	cout => \Add2~118\);

-- Location: FF_X50_Y21_N2
\ticks[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~117_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(20));

-- Location: LABCELL_X50_Y21_N3
\Add2~113\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~113_sumout\ = SUM(( ticks(21) ) + ( GND ) + ( \Add2~118\ ))
-- \Add2~114\ = CARRY(( ticks(21) ) + ( GND ) + ( \Add2~118\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(21),
	cin => \Add2~118\,
	sumout => \Add2~113_sumout\,
	cout => \Add2~114\);

-- Location: FF_X50_Y21_N5
\ticks[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~113_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(21));

-- Location: LABCELL_X50_Y21_N6
\Add2~109\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~109_sumout\ = SUM(( ticks(22) ) + ( GND ) + ( \Add2~114\ ))
-- \Add2~110\ = CARRY(( ticks(22) ) + ( GND ) + ( \Add2~114\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(22),
	cin => \Add2~114\,
	sumout => \Add2~109_sumout\,
	cout => \Add2~110\);

-- Location: FF_X50_Y21_N8
\ticks[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~109_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(22));

-- Location: LABCELL_X50_Y21_N9
\Add2~105\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~105_sumout\ = SUM(( ticks(23) ) + ( GND ) + ( \Add2~110\ ))
-- \Add2~106\ = CARRY(( ticks(23) ) + ( GND ) + ( \Add2~110\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(23),
	cin => \Add2~110\,
	sumout => \Add2~105_sumout\,
	cout => \Add2~106\);

-- Location: FF_X50_Y21_N11
\ticks[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~105_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(23));

-- Location: LABCELL_X50_Y21_N12
\Add2~101\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~101_sumout\ = SUM(( ticks(24) ) + ( GND ) + ( \Add2~106\ ))
-- \Add2~102\ = CARRY(( ticks(24) ) + ( GND ) + ( \Add2~106\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(24),
	cin => \Add2~106\,
	sumout => \Add2~101_sumout\,
	cout => \Add2~102\);

-- Location: FF_X50_Y21_N14
\ticks[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~101_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(24));

-- Location: LABCELL_X50_Y21_N15
\Add2~97\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~97_sumout\ = SUM(( ticks(25) ) + ( GND ) + ( \Add2~102\ ))
-- \Add2~98\ = CARRY(( ticks(25) ) + ( GND ) + ( \Add2~102\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(25),
	cin => \Add2~102\,
	sumout => \Add2~97_sumout\,
	cout => \Add2~98\);

-- Location: FF_X50_Y21_N17
\ticks[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~97_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(25));

-- Location: LABCELL_X50_Y21_N18
\Add2~93\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~93_sumout\ = SUM(( ticks(26) ) + ( GND ) + ( \Add2~98\ ))
-- \Add2~94\ = CARRY(( ticks(26) ) + ( GND ) + ( \Add2~98\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(26),
	cin => \Add2~98\,
	sumout => \Add2~93_sumout\,
	cout => \Add2~94\);

-- Location: FF_X50_Y21_N20
\ticks[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~93_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(26));

-- Location: LABCELL_X50_Y21_N21
\Add2~89\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~89_sumout\ = SUM(( ticks(27) ) + ( GND ) + ( \Add2~94\ ))
-- \Add2~90\ = CARRY(( ticks(27) ) + ( GND ) + ( \Add2~94\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(27),
	cin => \Add2~94\,
	sumout => \Add2~89_sumout\,
	cout => \Add2~90\);

-- Location: FF_X50_Y21_N23
\ticks[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~89_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(27));

-- Location: LABCELL_X50_Y21_N24
\Add2~85\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~85_sumout\ = SUM(( ticks(28) ) + ( GND ) + ( \Add2~90\ ))
-- \Add2~86\ = CARRY(( ticks(28) ) + ( GND ) + ( \Add2~90\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_ticks(28),
	cin => \Add2~90\,
	sumout => \Add2~85_sumout\,
	cout => \Add2~86\);

-- Location: FF_X50_Y21_N26
\ticks[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~85_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(28));

-- Location: LABCELL_X50_Y21_N27
\Add2~81\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~81_sumout\ = SUM(( ticks(29) ) + ( GND ) + ( \Add2~86\ ))
-- \Add2~82\ = CARRY(( ticks(29) ) + ( GND ) + ( \Add2~86\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_ticks(29),
	cin => \Add2~86\,
	sumout => \Add2~81_sumout\,
	cout => \Add2~82\);

-- Location: FF_X50_Y21_N29
\ticks[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~81_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(29));

-- Location: LABCELL_X50_Y21_N30
\Add2~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~29_sumout\ = SUM(( ticks(30) ) + ( GND ) + ( \Add2~82\ ))
-- \Add2~30\ = CARRY(( ticks(30) ) + ( GND ) + ( \Add2~82\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(30),
	cin => \Add2~82\,
	sumout => \Add2~29_sumout\,
	cout => \Add2~30\);

-- Location: FF_X50_Y21_N32
\ticks[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~29_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(30));

-- Location: LABCELL_X50_Y21_N33
\Add2~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add2~13_sumout\ = SUM(( ticks(31) ) + ( GND ) + ( \Add2~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(31),
	cin => \Add2~30\,
	sumout => \Add2~13_sumout\);

-- Location: FF_X50_Y21_N35
\ticks[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Add2~13_sumout\,
	sclr => \ALT_INV_counting~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => ticks(31));

-- Location: MLABCELL_X49_Y22_N21
\LessThan3~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan3~2_combout\ = ( !ticks(6) & ( !ticks(17) & ( (!ticks(3) & (!ticks(9) & (!ticks(4) & !ticks(5)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(3),
	datab => ALT_INV_ticks(9),
	datac => ALT_INV_ticks(4),
	datad => ALT_INV_ticks(5),
	datae => ALT_INV_ticks(6),
	dataf => ALT_INV_ticks(17),
	combout => \LessThan3~2_combout\);

-- Location: MLABCELL_X49_Y22_N12
\LessThan3~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan3~4_combout\ = ( !ticks(18) & ( !ticks(22) & ( (!ticks(20) & (!ticks(19) & (!ticks(21) & !ticks(23)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(20),
	datab => ALT_INV_ticks(19),
	datac => ALT_INV_ticks(21),
	datad => ALT_INV_ticks(23),
	datae => ALT_INV_ticks(18),
	dataf => ALT_INV_ticks(22),
	combout => \LessThan3~4_combout\);

-- Location: LABCELL_X50_Y21_N36
\LessThan3~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan3~3_combout\ = ( !ticks(29) & ( !ticks(26) & ( (!ticks(28) & (!ticks(24) & (!ticks(27) & !ticks(25)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(28),
	datab => ALT_INV_ticks(24),
	datac => ALT_INV_ticks(27),
	datad => ALT_INV_ticks(25),
	datae => ALT_INV_ticks(29),
	dataf => ALT_INV_ticks(26),
	combout => \LessThan3~3_combout\);

-- Location: MLABCELL_X49_Y22_N30
\LessThan3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan3~0_combout\ = ( !ticks(8) & ( (!ticks(11) & (!ticks(30) & !ticks(10))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010000000000000101000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_ticks(11),
	datac => ALT_INV_ticks(30),
	datad => ALT_INV_ticks(10),
	dataf => ALT_INV_ticks(8),
	combout => \LessThan3~0_combout\);

-- Location: MLABCELL_X49_Y22_N6
\LessThan3~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan3~5_combout\ = ( \LessThan3~3_combout\ & ( \LessThan3~0_combout\ & ( (!ticks(31) & ((!\LessThan3~1_combout\) # ((!\LessThan3~2_combout\) # (!\LessThan3~4_combout\)))) ) ) ) # ( !\LessThan3~3_combout\ & ( \LessThan3~0_combout\ & ( !ticks(31) ) ) ) 
-- # ( \LessThan3~3_combout\ & ( !\LessThan3~0_combout\ & ( !ticks(31) ) ) ) # ( !\LessThan3~3_combout\ & ( !\LessThan3~0_combout\ & ( !ticks(31) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100110011001100110011001100110011001100110011001100110011001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_LessThan3~1_combout\,
	datab => ALT_INV_ticks(31),
	datac => \ALT_INV_LessThan3~2_combout\,
	datad => \ALT_INV_LessThan3~4_combout\,
	datae => \ALT_INV_LessThan3~3_combout\,
	dataf => \ALT_INV_LessThan3~0_combout\,
	combout => \LessThan3~5_combout\);

-- Location: MLABCELL_X49_Y19_N48
\Decoder0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Decoder0~2_combout\ = ( !i(1) & ( i(0) & ( (!\VSYNC~input_o\ & (\HREF~input_o\ & \getImagePin~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010000000100000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_VSYNC~input_o\,
	datab => \ALT_INV_HREF~input_o\,
	datac => \ALT_INV_getImagePin~input_o\,
	datae => ALT_INV_i(1),
	dataf => ALT_INV_i(0),
	combout => \Decoder0~2_combout\);

-- Location: FF_X49_Y19_N53
\preArray[1][4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[4]~input_o\,
	sload => VCC,
	ena => \Decoder0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[1][4]~q\);

-- Location: MLABCELL_X49_Y19_N54
\postArray[0][4]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[0][4]~combout\ = ( \postArray[0][4]~combout\ & ( \preArray[1][4]~q\ ) ) # ( !\postArray[0][4]~combout\ & ( \preArray[1][4]~q\ & ( \Equal0~6_combout\ ) ) ) # ( \postArray[0][4]~combout\ & ( !\preArray[1][4]~q\ & ( !\Equal0~6_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000110011001100111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~6_combout\,
	datae => \ALT_INV_postArray[0][4]~combout\,
	dataf => \ALT_INV_preArray[1][4]~q\,
	combout => \postArray[0][4]~combout\);

-- Location: MLABCELL_X49_Y22_N33
\RAMdata~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAMdata~0_combout\ = ( \postArray[0][4]~combout\ & ( (!\LessThan3~5_combout\) # (\postArray[1][4]~combout\) ) ) # ( !\postArray[0][4]~combout\ & ( (\postArray[1][4]~combout\ & \LessThan3~5_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001100000011000000110000001111110011111100111111001111110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_postArray[1][4]~combout\,
	datac => \ALT_INV_LessThan3~5_combout\,
	dataf => \ALT_INV_postArray[0][4]~combout\,
	combout => \RAMdata~0_combout\);

-- Location: FF_X49_Y22_N35
\RAMdata[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \RAMdata~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[4]~reg0_q\);

-- Location: IOIBUF_X42_Y45_N1
\CAMdata[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(5),
	o => \CAMdata[5]~input_o\);

-- Location: FF_X49_Y19_N26
\preArray[1][5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[5]~input_o\,
	sload => VCC,
	ena => \Decoder0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[1][5]~q\);

-- Location: MLABCELL_X49_Y19_N27
\postArray[0][5]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[0][5]~combout\ = ( \postArray[0][5]~combout\ & ( \preArray[1][5]~q\ ) ) # ( !\postArray[0][5]~combout\ & ( \preArray[1][5]~q\ & ( \Equal0~6_combout\ ) ) ) # ( \postArray[0][5]~combout\ & ( !\preArray[1][5]~q\ & ( !\Equal0~6_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000110011001100111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~6_combout\,
	datae => \ALT_INV_postArray[0][5]~combout\,
	dataf => \ALT_INV_preArray[1][5]~q\,
	combout => \postArray[0][5]~combout\);

-- Location: FF_X49_Y19_N14
\preArray[3][5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[5]~input_o\,
	sload => VCC,
	ena => \Decoder0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[3][5]~q\);

-- Location: MLABCELL_X49_Y19_N0
\postArray[1][5]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][5]~combout\ = ( \preArray[3][5]~q\ & ( (\postArray[1][5]~combout\) # (\Equal0~6_combout\) ) ) # ( !\preArray[3][5]~q\ & ( (!\Equal0~6_combout\ & \postArray[1][5]~combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011110000000000001111000000001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Equal0~6_combout\,
	datad => \ALT_INV_postArray[1][5]~combout\,
	dataf => \ALT_INV_preArray[3][5]~q\,
	combout => \postArray[1][5]~combout\);

-- Location: MLABCELL_X49_Y22_N3
\RAMdata~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAMdata~1_combout\ = ( \LessThan3~5_combout\ & ( \postArray[1][5]~combout\ ) ) # ( !\LessThan3~5_combout\ & ( \postArray[0][5]~combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_postArray[0][5]~combout\,
	datab => \ALT_INV_postArray[1][5]~combout\,
	dataf => \ALT_INV_LessThan3~5_combout\,
	combout => \RAMdata~1_combout\);

-- Location: FF_X49_Y22_N4
\RAMdata[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \RAMdata~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[5]~reg0_q\);

-- Location: FF_X49_Y19_N41
\preArray[3][6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[6]~input_o\,
	sload => VCC,
	ena => \Decoder0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[3][6]~q\);

-- Location: MLABCELL_X49_Y19_N36
\postArray[1][6]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][6]~combout\ = ( \postArray[1][6]~combout\ & ( \preArray[3][6]~q\ ) ) # ( !\postArray[1][6]~combout\ & ( \preArray[3][6]~q\ & ( \Equal0~6_combout\ ) ) ) # ( \postArray[1][6]~combout\ & ( !\preArray[3][6]~q\ & ( !\Equal0~6_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000110011001100111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~6_combout\,
	datae => \ALT_INV_postArray[1][6]~combout\,
	dataf => \ALT_INV_preArray[3][6]~q\,
	combout => \postArray[1][6]~combout\);

-- Location: FF_X49_Y19_N11
\preArray[1][6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[6]~input_o\,
	sload => VCC,
	ena => \Decoder0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[1][6]~q\);

-- Location: MLABCELL_X49_Y19_N21
\postArray[0][6]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[0][6]~combout\ = ( \preArray[1][6]~q\ & ( (\postArray[0][6]~combout\) # (\Equal0~6_combout\) ) ) # ( !\preArray[1][6]~q\ & ( (!\Equal0~6_combout\ & \postArray[0][6]~combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011110000000000001111000000001111111111110000111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_Equal0~6_combout\,
	datad => \ALT_INV_postArray[0][6]~combout\,
	dataf => \ALT_INV_preArray[1][6]~q\,
	combout => \postArray[0][6]~combout\);

-- Location: LABCELL_X48_Y21_N57
\RAMdata~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAMdata~2_combout\ = ( \postArray[0][6]~combout\ & ( (!\LessThan3~5_combout\) # (\postArray[1][6]~combout\) ) ) # ( !\postArray[0][6]~combout\ & ( (\postArray[1][6]~combout\ & \LessThan3~5_combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001010101000000000101010111111111010101011111111101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_postArray[1][6]~combout\,
	datad => \ALT_INV_LessThan3~5_combout\,
	dataf => \ALT_INV_postArray[0][6]~combout\,
	combout => \RAMdata~2_combout\);

-- Location: FF_X48_Y21_N58
\RAMdata[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \RAMdata~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[6]~reg0_q\);

-- Location: FF_X49_Y19_N44
\preArray[3][7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[7]~input_o\,
	sload => VCC,
	ena => \Decoder0~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[3][7]~q\);

-- Location: MLABCELL_X49_Y19_N45
\postArray[1][7]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[1][7]~combout\ = ( \postArray[1][7]~combout\ & ( \preArray[3][7]~q\ ) ) # ( !\postArray[1][7]~combout\ & ( \preArray[3][7]~q\ & ( \Equal0~6_combout\ ) ) ) # ( \postArray[1][7]~combout\ & ( !\preArray[3][7]~q\ & ( !\Equal0~6_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110000110011001100111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_Equal0~6_combout\,
	datae => \ALT_INV_postArray[1][7]~combout\,
	dataf => \ALT_INV_preArray[3][7]~q\,
	combout => \postArray[1][7]~combout\);

-- Location: FF_X49_Y19_N35
\preArray[1][7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \PCLK~inputCLKENA0_outclk\,
	asdata => \CAMdata[7]~input_o\,
	sload => VCC,
	ena => \Decoder0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \preArray[1][7]~q\);

-- Location: MLABCELL_X49_Y19_N15
\postArray[0][7]\ : cyclonev_lcell_comb
-- Equation(s):
-- \postArray[0][7]~combout\ = ( \preArray[1][7]~q\ & ( (\postArray[0][7]~combout\) # (\Equal0~6_combout\) ) ) # ( !\preArray[1][7]~q\ & ( (!\Equal0~6_combout\ & \postArray[0][7]~combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000101000001010000010100000101001011111010111110101111101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal0~6_combout\,
	datac => \ALT_INV_postArray[0][7]~combout\,
	dataf => \ALT_INV_preArray[1][7]~q\,
	combout => \postArray[0][7]~combout\);

-- Location: MLABCELL_X49_Y20_N6
\RAMdata~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \RAMdata~3_combout\ = ( \LessThan3~5_combout\ & ( \postArray[0][7]~combout\ & ( \postArray[1][7]~combout\ ) ) ) # ( !\LessThan3~5_combout\ & ( \postArray[0][7]~combout\ ) ) # ( \LessThan3~5_combout\ & ( !\postArray[0][7]~combout\ & ( 
-- \postArray[1][7]~combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100110011001111111111111111110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_postArray[1][7]~combout\,
	datae => \ALT_INV_LessThan3~5_combout\,
	dataf => \ALT_INV_postArray[0][7]~combout\,
	combout => \RAMdata~3_combout\);

-- Location: FF_X49_Y20_N7
\RAMdata[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \RAMdata~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAMdata[7]~reg0_q\);

-- Location: LABCELL_X50_Y21_N48
\LessThan0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~0_combout\ = ( ticks(1) ) # ( !ticks(1) & ( (ticks(2)) # (ticks(0)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011111100111111001111110011111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_ticks(0),
	datac => ALT_INV_ticks(2),
	dataf => ALT_INV_ticks(1),
	combout => \LessThan0~0_combout\);

-- Location: IOIBUF_X38_Y45_N35
\CAMdata[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(0),
	o => \CAMdata[0]~input_o\);

-- Location: IOIBUF_X48_Y45_N35
\CAMdata[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(1),
	o => \CAMdata[1]~input_o\);

-- Location: IOIBUF_X40_Y45_N75
\CAMdata[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(2),
	o => \CAMdata[2]~input_o\);

-- Location: IOIBUF_X40_Y45_N92
\CAMdata[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CAMdata(3),
	o => \CAMdata[3]~input_o\);

-- Location: MLABCELL_X18_Y1_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


