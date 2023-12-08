
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;

entity contador_para_baudios is
    Generic( MAX : integer:= 868  -- ejemplo: 100MHz/115200 = 868
           );
    Port( clock       : in  STD_LOGIC;
          reset       : in  STD_LOGIC;
          enable      : in  STD_LOGIC;
          send_bit    : out  STD_LOGIC
        );
end contador_para_baudios;


architecture Behavioral of contador_para_baudios is

signal count  : integer range 0 to MAX := 0;
signal auxOut : STD_LOGIC :='0';

begin

  process(clock, reset) 
  begin
      if(reset = '1') then
          count  <= 3;
          auxOut <= '0';
      elsif(rising_edge(clock)) then
          if(enable = '1') then
              if(count = (MAX-1)) then 
                  auxOut <= '1';
                  count <= 0;
              else
                  count <= count + 1;
                  auxOut <= '0';
              end if;
          end if;
      end if;
  end process;

  send_bit <= auxOut;

end Behavioral;

