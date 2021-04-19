-- Writing to LEDs from FPGA

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.SevenSegDisplayTypes.ALL; -- Needed for Seven Segment Display

entity FPGA_LEDRAM is
	port (
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: inout STD_LOGIC_VECTOR(7 downto 0);
		CS, WE, OE: out STD_LOGIC;
		CS_SW, WE_SW, OE_SW, addr_SW: in STD_LOGIC; -- display_SW: SW3
		LEDs: out STD_LOGIC_VECTOR(7 downto 0);
		HEX0 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX1 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX2 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX3 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX4 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX5 : out STD_LOGIC_VECTOR(6 downto 0));
		
end FPGA_LEDRAM;

architecture Behavioral of FPGA_LEDRAM is
	signal i: integer := 0;
	begin
		address <= conv_std_logic_vector(i, address'length);
		LEDs(7 downto 0) <= RAMdata(7 downto 0);
		
		--RAMdata <= "00000000";
		
		-- To read CS, OE should be low and WE high
		CS <= CS_SW; -- SW2
		WE <= WE_SW; -- SW1
		OE <= OE_SW; -- SW0
		
		
		process(addr_SW) -- KEY0
		begin
			if (addr_SW'event and addr_SW = '0') then
				i <= i+1;
			end if;
		end process;
		
		
		-- Initialize 6 digit 7 segment display, showing i as a decimal number
		Display : entity work.SevenSegDisplay
		
		generic map (
			MODE => DEC_MODE)
		
		port map (
			NUM => i,
			EN => '1',
			HEX(0) => HEX0,
			HEX(1) => HEX1,
			HEX(2) => HEX2,
			HEX(3) => HEX3,
			HEX(4) => HEX4,
			HEX(5) => HEX5);
			
		
	end Behavioral;