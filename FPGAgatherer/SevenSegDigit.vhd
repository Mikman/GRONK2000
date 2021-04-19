library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;

entity SevenSegDigit is
	port (
	
		Digit 	: in integer range 0 to 15 := 0;
		EN 		: in STD_LOGIC;
		
		Segments : out STD_LOGIC_VECTOR(6 downto 0));
		
end SevenSegDigit;


architecture Behavioral of SevenSegDigit is
	
	
	
begin

	process (Digit, EN)
	
	begin
		
		if (EN = '1') then
			
			case Digit is
				
				when 0  => Segments <= "1000000"; -- 0
				when 1  => Segments <= "1111001"; -- 1
				when 2  => Segments <= "0100100"; -- 2
				when 3  => Segments <= "0110000"; -- 3
				when 4  => Segments <= "0011001"; -- 4
				when 5  => Segments <= "0010010"; -- 5
				when 6  => Segments <= "0000010"; -- 6
				when 7  => Segments <= "1111000"; -- 7
				when 8  => Segments <= "0000000"; -- 8
				when 9  => Segments <= "0010000"; -- 9
				when 10 => Segments <= "0001000"; -- A
				when 11 => Segments <= "0000011"; -- B
				when 12 => Segments <= "1000110"; -- C
				when 13 => Segments <= "0100001"; -- D
				when 14 => Segments <= "0000110"; -- E
				when 15 => Segments <= "0001110"; -- F
				when others => Segments <= (others => '1'); -- Disable LEDs (shouldn't happen)
				
			end case;
			
		else
			
			Segments <= (others => '1'); -- Disable LEDs
			
		end if;
	
	end process;
	
end Behavioral;
	