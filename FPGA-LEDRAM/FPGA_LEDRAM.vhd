-- Writing to LEDs from FPGA

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;

entity FPGA_LEDRAM is
	port (
		address: out STD_LOGIC_VECTOR(18 downto 0);
		data: in STD_LOGIC_VECTOR(7 downto 0);
		CS, WE, OE: out STD_LOGIC;
		CS_SW, WE_SW, OE_SW: in STD_LOGIC;
		LEDs: out STD_LOGIC_VECTOR(7 downto 0)
		);
end FPGA_LEDRAM;

architecture Behavioral of FPGA_LEDRAM is
	
	begin
		address <= "1011001110001111000";
		--data <= "10100111";
		--LEDs(7 downto 0) <= data(7 downto 0);
		
		CS <= CS_SW;
		WE <= WE_SW;
		OE <= OE_SW;
		
	end Behavioral;