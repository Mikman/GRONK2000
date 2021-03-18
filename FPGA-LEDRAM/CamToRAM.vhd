library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CamToRAM is
	port (
		-- Camera I/O
		XCLK: out STD_LOGIC;
		HREF, VSYNC, PCLK: in STD_LOGIC;
		CAMdata: in STD_LOGIC_VECTOR(7 downto 0);
		
		-- RAM I/O
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: out STD_LOGIC_VECTOR(7 downto 0);
		WE, OE: buffer STD_LOGIC;
		CS: buffer STD_LOGIC;
		LEDs: out STD_LOGIC_VECTOR(9 downto 0);
		writebtn, clk, switchyboi: in STD_LOGIC
	);
end CamToRAM;

architecture Behavioral of CamToRAM is

signal ticks, addr, i: integer := 0;
signal counting, imageRec: boolean;

type preEditBuffer is array(3 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
type postEditBuffer is array(1 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
signal preArray: preEditBuffer;
signal postArray: postEditBuffer;

begin
	
	CS <= '0';
	WE <= '0' when ((ticks mod 10) >= 1) else '1';
	--LEDs(9 downto 5) <= std_logic_vector(to_unsigned(ticks, 5));
	
	process(PCLK)
	begin
		if (PCLK'event and PCLK='1' and HREF='1' and imageRec) then
			preArray[i] <= CAMdata(7 downto 0);
			if (i >= 3) then
				i <= 0;
			else
				i <= i + 1;
			end if;
		end if;
	end process;
	
	process(i)
	begin
		if (i = 0) then
			-- First pixel
			postArray[0](1 downto 0) <= preArray[0](7 downto 6);
			postArray[0](3 downto 2) <= preArray[2](7 downto 6);
			postArray[0](7 downto 4) <= preArray[1](7 downto 4);
			
			--Second pixel
			postArray[1](1 downto 0) <= preArray[0](7 downto 6);
			postArray[1](3 downto 2) <= preArray[2](7 downto 6);
			postArray[1](7 downto 4) <= preArray[3](7 downto 4);
		end if;
	end process;
	
	process(clk)
	begin
		if (clk'event and clk='1') then
		
			-- Assigning counting
			if (amount >= 0) then
				counting <= true;
			else
				counting <= false;
			end if;
			
			-- Increment ticks
			if (counting) then
				ticks <= ticks + 1;
			end if;
			
			-- Reset ticks or assign addr and data
			if (ticks >= 19) then
				ticks <= 0;
			elsif (ticks mod 5 = 0) then
				XCLK <= not XCLK;
			end if;
			
			if (ticks mod 10 = 0) then
				addr <= addr + 1;
			end if;
			
			if (not imageRec) then
				addr = 0;
			end if;
			
			if (ticks < 10) then
				RAMdata = postArray[0];
			else
				RAMdata = postArray[1];
			end if;
		end if;
	end process;
	
	
	

end Behavioral;