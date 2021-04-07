library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CamToRAM is
	port (
		-- Camera I/O
		XCLK, RESET, PWDN: out STD_LOGIC;
		HREF, VSYNC, PCLK, getImagePin: in STD_LOGIC;
		CAMdata: in STD_LOGIC_VECTOR(7 downto 0);
		
		-- RAM I/O
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: out STD_LOGIC_VECTOR(7 downto 0);
		WE, OE: buffer STD_LOGIC;
		CS: buffer STD_LOGIC;
		LEDs: out STD_LOGIC_VECTOR(9 downto 0);
		clk: in STD_LOGIC
	);
end CamToRAM;

architecture Behavioral of CamToRAM is

signal ticks, XCLKticks, i : integer := 0;
signal addr: integer range 0 to 512000 :=0;
signal currentImage: boolean;
signal currentLine: boolean := true;
signal counting, wantAnImage: boolean := false;

type preEditBuffer is array(3 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
type postEditBuffer is array(1 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
signal preArray: preEditBuffer;
signal postArray: postEditBuffer;

begin
	
	-- Constant assignments for RAM
	CS <= '0';
	WE <= '0' when ((ticks mod 8) >= 1) else '1';
	address <= std_logic_vector(to_unsigned(addr, address'length));

	-- Constant assignments for camera
	XCLK <= '1' when (XCLKticks < 2) else '0';
	
	currentLine <= false when (VSYNC = '0') else true;

	RESET <= '1';
	PWDN <= '0';


	process(PCLK)
	begin
		if (PCLK'event and PCLK = '1') then
			if (counting) then
				preArray(i) <= CAMdata;
				if (i = 3) then
					i <= 0;
							-- First pixel
					--postArray(0)(1 downto 0) <= preArray(0)(7 downto 6);
					--postArray(0)(3 downto 2) <= preArray(2)(7 downto 6);
					--postArray(0)(7 downto 4) <= preArray(1)(7 downto 4);
					postArray(0)(7 downto 0) <= "11111111";
					
					--Second pixel
					--postArray(1)(1 downto 0) <= preArray(0)(7 downto 6);
					--postArray(1)(3 downto 2) <= preArray(2)(7 downto 6);
					--postArray( 1)(7 downto 4) <= preArray(3)(7 downto 4);
					postArray(1)(7 downto 0) <= "00000010";
				else
					i <= i + 1;
				end if;

			else
				i <= 0;
				
			end if;

		end if;
	end process;

	counting <= true when ((VSYNC = '0') and wantAnImage and HREF = '1') else false;

	process(VSYNC)
	begin
		if (VSYNC'event and VSYNC = '0') then
			
			if (getImagePin = '1') then
				wantAnImage <= true;
			else
				wantAnImage <= false;
			end if;
			
		end if;
	end process;
	
	
	process(clk)
	begin
		if (clk'event and clk='1') then
		
			if (XCLKticks = 3) then
				XCLKticks <= 0;
			else
				XCLKticks <= XCLKticks + 1;
			end if;
			
			-- Decisions based on ticks
			
			-- Incrementing ticks or resetting ticks and addr
			
			if (ticks = 15) then
			--kør koden igen, men sæt til 0 bagefter
			
				if (ticks mod 8 = 0) then
					addr <= addr + 1;
				end if;
				
				if (ticks < 8) then
					RAMdata <= postArray(1);
				else
					RAMdata <= postArray(0);
				end if;
				
				ticks <= 0;
				
				
			elsif(counting) then 
			
				if (ticks mod 8 = 0) then
					addr <= addr + 1;
				end if;
				
				if (ticks < 8) then
					RAMdata <= postArray(1);
				else
					RAMdata <= postArray(0);
				end if;
				
				ticks <= ticks + 1;
				
			elsif(currentLine) then
			
				addr <= 0;
				ticks <= 0;
				
				
			end if;
			
		end if;
	end process;
	
end Behavioral;