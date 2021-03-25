-- Incrementing acording to ARDUINO

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Arduino_RAM_reader is
	port (
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: inout STD_LOGIC_VECTOR(7 downto 0);
		CS, WE, OE: out STD_LOGIC;
		WE_SW: in STD_LOGIC;
		LEDs: out STD_LOGIC_VECTOR(7 downto 0);
		addrInc: in STD_LOGIC
		
	);
		
		
end Arduino_RAM_reader;

architecture Behavioral of Arduino_RAM_reader is
	signal i: integer := 0;
	begin
		address <= conv_std_logic_vector(i, address'length);
		LEDs(7 downto 0) <= RAMdata(7 downto 0);
		--RAMdata <= "00000000";
		CS <= '0';
		WE <= WE_SW;
		OE <= '0';
		
		
		process(addrInc)
		begin
			if (addrInc'event and addrInc = '1') then
				i <= i + 1;
			end if;
		end process;
		
		
		
	end Behavioral;