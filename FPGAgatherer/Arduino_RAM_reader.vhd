-- Incrementing acording to ARDUINO

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.SevenSegDisplayTypes.ALL; -- Needed for Seven Segment Display

entity Arduino_RAM_reader is
	port (
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: in STD_LOGIC_VECTOR(7 downto 0); -- Evt. ret til kun input, da vi alligevel ikke driver den
		CS, WE, OE: out STD_LOGIC;
		WE_SW: in STD_LOGIC;
		LEDs: out STD_LOGIC_VECTOR(7 downto 0);
		addrInc: in STD_LOGIC;
		reset : in STD_LOGIC; -- Key1
		
		HEX0 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX1 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX2 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX3 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX4 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX5 : out STD_LOGIC_VECTOR(6 downto 0));		
		
end Arduino_RAM_reader;

architecture Behavioral of Arduino_RAM_reader is
	signal i: integer := 0;
	begin
		address <= conv_std_logic_vector(i, address'length);
		LEDs(7 downto 0) <= RAMdata(7 downto 0);
		--RAMdata <= "00000000";
		CS <= '0';
		WE <= '1';
		OE <= '0';
		
		
		process(addrInc, reset)
		begin
			if (addrInc'event and addrInc = '1') then
				
				i <= i + 1;
				
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