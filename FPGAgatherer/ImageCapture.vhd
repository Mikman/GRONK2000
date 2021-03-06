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
		LEDs: out STD_LOGIC_VECTOR(7 downto 0);
		HEX0 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX1 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX2 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX3 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX4 : out STD_LOGIC_VECTOR(6 downto 0);
		HEX5 : out STD_LOGIC_VECTOR(6 downto 0)
	);
end ImageCapture;

architecture Behavioral of ImageCapture is

signal ticks, XCLKticks, i, j: integer := 0;
signal addr: integer range 0 to 512000 := 0;

signal counting, wantAnImage, VSYNC_falling, saveNextImage: boolean := false;

signal currentLine: boolean := true;

type preEditBuffer is array(3 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
type postEditBuffer is array(1 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
signal preArray: preEditBuffer;
signal postArray: postEditBuffer;

begin
	
	-- Constant assignments for RAM
	CS <= '0';
	WE <= '0' when ((ticks mod 8) >= 1 AND transferPin = '0') else '1';
	address <= std_logic_vector(to_unsigned(addr, address'length));

	-- Constant assignments for camera
	XCLK <= '1' when (XCLKticks < 2) else '0';
	RESET <= '1';
	PWDN <= '0';
	
	counting <= true when (VSYNC = '0' and wantAnImage and HREF = '1') else false;
	
	LEDs(7 downto 0) <= RAMdata(7 downto 0);
	
	currentLine <= false when (VSYNC = '0') else true;
	
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
	

	process(PCLK) -- Da der kontinuerligt bliver lagt data over på RAM, så bliver de første to pixels fyldt med bras og sendt
	begin
		if (PCLK'event and PCLK = '1') then
			if (counting) then
				preArray(i) <= CAMdata;
				if (i = 3) then
					i <= 0;
					
					-- Greyscale
					postArray(0) <= preArray(1); -- 8 bit Y
					postArray(1) <= preArray(3); -- 8 bit Y
					
					
					-- RGB565 (half horizontal resolution)
					--postArray(0) <= preArray(0);
					--postArray(1) <= preArray(1);
					
					
					
					-- YCbCr (heavy compression)
					--postArray(0)(7 downto 4) <= preArray(1)(7 downto 4); -- 4 bit Y
					--postArray(0)(3 downto 2) <= preArray(0)(7 downto 6); -- 2 bit Cb
					--postArray(0)(1 downto 0) <= preArray(2)(7 downto 6); -- 2 bit Cr
					--postArray(1)(7 downto 4) <= preArray(3)(7 downto 4); -- 4 bit Y
					--postArray(1)(3 downto 2) <= preArray(0)(7 downto 6); -- 2 bit Cb
					--postArray(1)(1 downto 0) <= preArray(2)(7 downto 6); -- 2 bit Cr
					
					
					-- YCbCr (half horizontal resolution)
					--postArray(0)(7 downto 0) <= preArray(1)(7 downto 0); -- 8 bit Y (half width)
					--postArray(1)(7 downto 4) <= preArray(0)(7 downto 4); -- 4 bit Cb (half width)
					--postArray(1)(3 downto 0) <= preArray(2)(7 downto 4); -- 4 bit Cr (half width)
					
					
				else
					i <= i + 1;
				end if;

			else
				i <= 0;
				
			end if;

		end if;
	end process;

	

	process(VSYNC)
	begin
		if (VSYNC'event and VSYNC = '0') then
			
			if (saveNextImage = true) then
				wantAnImage <= true;
			else
				wantAnImage <= false;
			end if;
		end if;
	end process;
	
	
	
	process(getImagePin, VSYNC)
	begin
		if (getImagePin = '1') then 
			saveNextImage <= true; 
		elsif (VSYNC'event and VSYNC = '0') then 
			saveNextImage <= false;
			
		end if; 
	end process; 
	
	
	
	process(clk)
	begin
		if (clk'event and clk='1') then
		
			if ( transferPin = '1' ) then 
				addr <= j;
				RAMdata <= "ZZZZZZZZ"; -- Set to high impedance (input) so FPGA and RAM are not both outputs at the same time
				
			else
			
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
						RAMdata <= postArray(0);
					else
						RAMdata <= postArray(1);
					end if;
					
					ticks <= 0;
					
				elsif(counting) then 
				
					if (ticks mod 8 = 0) then
						addr <= addr + 1;
					end if;
					
					if (ticks < 8) then
						RAMdata <= postArray(0);
					else
						RAMdata <= postArray(1);
					end if;
					
					ticks <= ticks + 1;
					
				elsif(currentLine) then
				
					addr <= 0;
					ticks <= 0;
						
				end if;
			end if;
		end if;
	end process;
	


	
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