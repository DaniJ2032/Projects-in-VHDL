-- Archivo LEDController.vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LEDController is
    Port (
        input_data : in STD_LOGIC;
        output_LED : out STD_LOGIC
    );

end LEDController;
---------------------------------------------
architecture Behavioral of LEDController is
    
begin
    process (input_data)
    begin
        if input_data = '1' then
            output_LED <= '1';  -- Enciende el LED si la entrada es 1
        else
            output_LED <= '0';
        end if;
    end process;

end Behavioral;