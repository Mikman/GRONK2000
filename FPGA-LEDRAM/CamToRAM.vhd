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

signal ticks, addr, i: integer := 0;
signal currentImage: boolean;
signal counting, wantAnImage: boolean := false;
signal nVSYNC: STD_LOGIC;

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
	XCLK <= '1' when ((ticks mod 4) < 2) else '0';
	RESET <= '1';
	PWDN <= '0';


	process(PCLK)
	begin
		if (PCLK'event and PCLK = '1') then
			if (VSYNC ='0' and HREF = '1' and getImagePin = '1') then
				preArray(i) <= CAMdata;
				if (i >= 3) then
					i <= 0;
				else
					i <= i + 1;
				end if;
			end if;
			
			if (currentImage) then
				counting <= true;
			else
				counting <= false;
			end if;

		end if;
	end process;

	
	currentImage <= true when ((VSYNC = '0') and wantAnImage) else false;

	process(VSYNC, nVSYNC)
	begin
		if (VSYNC'event and VSYNC = '0') then
			if (getImagePin = '1') then
				wantAnImage <= true;
			else
				wantAnImage <= false;
			end if;
		end if;
	end process;




	process(i)
	begin
		if (i = 0) then
			-- First pixel
			postArray(0)(1 downto 0) <= preArray(0)(7 downto 6);
			postArray(0)(3 downto 2) <= preArray(2)(7 downto 6);
			postArray(0)(7 downto 4) <= preArray(1)(7 downto 4);
			
			--Second pixel
			postArray(1)(1 downto 0) <= preArray(0)(7 downto 6);
			postArray(1)(3 downto 2) <= preArray(2)(7 downto 6);
			postArray(1)(7 downto 4) <= preArray(3)(7 downto 4);
		end if;
	end process;
	
	
	
	
	process(clk)
	begin
		if (clk'event and clk='1') then
			
			-- Decisions based on ticks
			if (ticks > 15) then
				ticks <= 0;
			end if;
			
			if (ticks mod 8 = 0) then
				addr <= addr + 1;
			end if;
			
			if (ticks < 8) then
				RAMdata <= postArray(0);
			else
				RAMdata <= postArray(1);
			end if;
			
			-- Incrementing ticks or resetting ticks and addr
			if (counting) then
				ticks <= ticks + 1;
			else
				ticks <= 0;
				addr <= 0;
			end if;
		end if;
	end process;
	
end Behavioral;