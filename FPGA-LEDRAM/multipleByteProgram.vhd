library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity multipleByteProgram is
	port (
		address: out STD_LOGIC_VECTOR(18 downto 0);
		data: out STD_LOGIC_VECTOR(7 downto 0);
		WE, OE: out STD_LOGIC;
		CS: buffer STD_LOGIC;
		writebtn: in STD_LOGIC
	);
end multipleByteProgram;

architecture Behavorial of multipleByteProgram is
begin
		--type vector_array is array(0 to 4) of STD_LOGIC_VECTOR(7 downto 0);
		
		--variable data_array: vector_array;
		
		--data_array[0] := "00000001";
		--data_array[1] := "00000010";
		--data_array[2] := "00000011";
		--data_array[3] := "00000100";
		--data_array[4] := "00000101";
		
		
	process is
	begin
		
		if (writebtn'event and writebtn = '0') then
			
			for i in 0 to 4 loop
			address <= conv_std_logic_vector(i, address'length);
			data <= conv_std_logic_vector((i + 1), data'length);
			CS <= '0';
			WE <= '0';
			wait for 35 ns; --Dette virker ikke, lad istedet clocken på FPGAen tælle op i 2 clk cycles ved 50 MHz = 40 ns
			CS <= '1';
			WE <= '1';
			end loop;
			
		end if;
		
	end process;

end Behavorial;