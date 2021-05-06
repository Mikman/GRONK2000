library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.SevenSegDisplayTypes.ALL; -- Needed for Seven Segment Display

entity ImageCapture is
	port (
		-- Camera I/O
		XCLK, RESET, PWDN, SIOC, SIOD: out STD_LOGIC;
		HREF, VSYNC, PCLK, getImagePin, transferPin, addrInc: in STD_LOGIC;
		CAMdata: in STD_LOGIC_VECTOR(7 downto 0);
		
		-- RAM I/O
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: inout STD_LOGIC_VECTOR(7 downto 0);
		WE, OE: buffer STD_LOGIC;
		CS: buffer STD_LOGIC;
		clk: in STD_LOGIC;
		
		-- Test I/O
		LEDs: out STD_LOGIC_VECTOR(9 downto 0);
		HEX0 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX1 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX2 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX3 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX4 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX5 : out STD_LOGIC_VECTOR(6 downto 0)
	);
end ImageCapture;

architecture Behavioral of ImageCapture is

signal j: integer := 0;

begin
	
	
	process(addrInc)
	begin
		if (transferPin = '1') then
			if (addrInc'event and addrInc = '0') then -- Reagerer på falling edge af addrInc, da STM32 genererer en falling edge ved CCR = 120
				j <= j + 1;
			end if;
		else
			j <= 0;
		end if;
	end process;
	
	LEDs <= CONV_STD_LOGIC_VECTOR(j, 10);
	
	-- Initialize 6 digit 7 segment display, showing i as a decimal number
	Display : entity work.SevenSegDisplay
		
	generic map (
		MODE => DEC_MODE)
		
	port map (
		NUM => j,
		EN => '1',
		HEX(0) => HEX0,
		HEX(1) => HEX1,
		HEX(2) => HEX2,
		HEX(3) => HEX3,
		HEX(4) => HEX4,
		HEX(5) => HEX5);
	
end Behavioral;