library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_STD.ALL;

entity NewCamToRAM is 
  port (
    -- INPUTS

      -- 50 MHz clock 
      clock : in STD_LOGIC;

      --Switches on the dev board
      switchArray : in STD_LOGIC_VECTOR(7 downto 0);


    --OUTPUT

      --RAM address in 19 bit binary 
      RAMAddress : out STD_LOGIC_VECTOR(18 downto 0);

      --RAM Data pins
      RAMData : out STD_LOGIC_VECTOR(7 downto 0);

      --OUTPUT ENABLE(OE) & CHIP SELECT(S) & WRITE ENABLE(WE)
      OE, CS, WE : out STD_LOGIC

  );
end NewCamToRAM;

architecture Behavioral of NewCamToRAM is

  --Integer that runs from 0 to 15 with the clock frequency
  signal ticks : integer := 0;

  -- The addres should start at 0
  signal address : integer := 0;

  signal hold : integer := 0;


  begin
    --RAM setup:
      -- Chip select is active low
      CS <= '0';
      --Output enable is also active low. We are only interested in writing to the RAM while taking pictures
      OE <= '1';
      --Write enable is also active low and we want to write to the RAM while taking pictures.
      WE <= '0';
    -- END RAM setup

    hold <= 0 when (address < 11) else 1;

    RAMAddress <= STD_LOGIC_VECTOR(to_unsigned(address, RAMAddress'length));

    RAMData <= switchArray;

    -- Initializes ticks to loop from 0 to 15
   process(clock)
	begin
      if (hold = 0) then

          if(clock'event AND clock = '1') then

            if(ticks < 15) then

              ticks <= ticks + 1;
            else 

              ticks <= 0;
            end if;
          end if;
      end if;
        
      if (ticks = 0) then
        address <= address + 1;
      end if;

    end process;
end Behavioral;

  


    

