library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multipleByteProgram is
	port (
		address: out STD_LOGIC_VECTOR(18 downto 0);
		RAMdata: out STD_LOGIC_VECTOR(7 downto 0);
		WE, OE: buffer STD_LOGIC;
		CS: buffer STD_LOGIC;
		LEDs: out STD_LOGIC_VECTOR(9 downto 0);
		writebtn, clk, switchyboi: in STD_LOGIC
	);
end multipleByteProgram;

architecture Behavorial of multipleByteProgram is

signal ticks: integer := 0;
signal counting, decrementingAmount: boolean;
signal amount: integer := 5;


begin
	
	CS <= '0';
	WE <= '0' when (ticks > 1) else '1';
	LEDs(4 downto 0) <= std_logic_vector(to_unsigned(amount, 5));
	LEDs(9 downto 5) <= std_logic_vector(to_unsigned(ticks, 5));
	
	
	process(clk)
	begin
		if (clk'event and clk='1' and switchyboi = '1') then
		
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
			if (ticks >= 5) then
				ticks <= 0;
				amount <= amount - 1;
			elsif (ticks >= 1) then
				address <= std_logic_vector(to_unsigned(amount, address'length));
				RAMdata <= std_logic_vector(to_unsigned((amount + 1), RAMdata'length));
			end if;
			
			
		
		end if;
	end process;
	

end Behavorial;