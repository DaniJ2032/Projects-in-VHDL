
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity contador is
    Generic( MAX : integer:= 7500  -- ejemplo: 72MHz / 9600Baudios = 7500
           );
    Port( clock        : in  STD_LOGIC;
          reset        : in  STD_LOGIC;
          enable       : in  STD_LOGIC;
          top_count    : in  STD_LOGIC_VECTOR(1 downto 0);
          is_max_count : out STD_LOGIC
        );
end contador;

architecture Behavioral of contador is

  signal count : integer range 0 to (3*MAX)/2 := 0; -- Determina los bits necesarios
                                                    --para represtar el tope.

  begin
  
  COUNT_ACTION : process(clock, reset) 
  begin
      if(reset='1') then 
          count        <= 0;
          is_max_count <= '0';
      elsif(clock = '1' and clock'event) then
          
          if(enable='1') then
            case(top_count) is
                when "00" => -- Cuenta hasta 1/2 tiempo de bit
                    if(count = (MAX/2)) then 
                        is_max_count <= '1';
                        count <= 0;
                    else
                        count <= count + 1;
                        is_max_count <= '0';
                    end if;
                
                when "01" => -- Cuenta hasta 1 tiempo de bit
                    if(count = MAX) then 
                        is_max_count <= '1';
                        count <= 0;
                    else
                        count <= count + 1;
                        is_max_count <= '0';
                    end if;
                
                when "10" => -- Cuenta hasta 1.5 tiempo de bit
                    if(count = (3*MAX)/2) then 
                        is_max_count <= '1';
                        count <= 0;
                    else
                        count <= count + 1;
                        is_max_count <= '0';
                    end if;
                
                when others =>
                    count        <= 0;
                    is_max_count <= '0';
            end case;
          end if;
      end if;
  end process;
		
end Behavioral;

