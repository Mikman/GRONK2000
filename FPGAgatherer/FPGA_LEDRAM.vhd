-- Writing to LEDs from FPGA

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity FPGA_LEDRAM is
	port (
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: inout STD_LOGIC_VECTOR(7 downto 0);
		CS, WE, OE: out STD_LOGIC;
		CS_SW, WE_SW, OE_SW, addr_SW, display_SW: in STD_LOGIC; -- display_SW: SW3
		LEDs: out STD_LOGIC_VECTOR(7 downto 0)
		
	);
		
		
end FPGA_LEDRAM;

architecture Behavioral of FPGA_LEDRAM is
	signal i: integer := 0;
	begin
		address <= conv_std_logic_vector(i, address'length);
		LEDs(7 downto 0) <= RAMdata(7 downto 0) when display_SW = '0' else conv_std_logic_vector(i, 8);
		--RAMdata <= "00000000";
		CS <= CS_SW; -- SW2
		WE <= WE_SW; -- SW1
		OE <= OE_SW; -- SW0
		
		
		process(addr_SW) -- KEY0
		begin
			if (addr_SW'event and addr_SW = '0') then
				i <= i + 1;
			end if;
		end process;
		
		
		
	end Behavioral;