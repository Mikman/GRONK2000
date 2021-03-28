-- Package to give the entity port the possibility to use the user defined type SevenSegMatrix

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package SevenSegDisplayTypes is
	
	type SevenSegMatrix is array(5 downto 0) of STD_LOGIC_VECTOR(6 downto 0);
	type SevenSegDispMode is (HEX_MODE, DEC_MODE);
	constant DigitCount : integer := 6;
	constant NumWidth : integer := 4*DigitCount;
	
end SevenSegDisplayTypes;

use work.SevenSegDisplayTypes.ALL;



-- Libraries apparently have to be reinitialized after the package definition

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity SevenSegDisplay is
	
	generic(
		--DigitCount : integer,
		MODE : SevenSegDispMode
		);
		
	port (
		NUM : in integer range 0 to 2**(NumWidth)-1; -- 6 hex digits
		
		EN : in STD_LOGIC;
		
		HEX : out SevenSegMatrix);
		
end SevenSegDisplay;



architecture HexDisp of SevenSegDisplay is

	type BCD_type is array(DigitCount-1 downto 0) of integer range 0 to 15;
	
	signal BCD : BCD_type;

begin
	
	-- Generate and connect all six digit components
	
	genDigits: for i in 0 to DigitCount-1 generate SevenSegDisplay : work.SevenSegDigit
		port map (
			
			Digit => BCD(i),
			
			EN => EN,
			
			Segments => HEX(i)
			
		);
	end generate genDigits;
	
	
	
	process (NUM)
	
	begin
		
		if (MODE = HEX_MODE) then
		
			-- Do the following for all hex digits
			for i in 0 to DigitCount-1 loop
				
				BCD(i) <= conv_integer(conv_unsigned(NUM, NumWidth)(((i+1)*4)-1 downto (i*4))); -- (((i+1)*4)-1 downto (i*4))
				
			end loop;
		
		elsif (MODE = DEC_MODE) then
			
			-- Do the following for all hex digits
			for i in 0 to DigitCount-1 loop
				
				-- Pattern so that:
				-- BCD(0) == (NUM mod 10) / 1;
				-- BCD(1) == (NUM mod 100) / 10;
				-- ...
				
				BCD(i) <= ((NUM mod (10**(i+1))) / 10**i); 
				
			end loop;
			
		end if;
		
	end process;

end HexDisp;