-- Archivo ANDGate.vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ANDGate is
    Port (
        input_A : in STD_LOGIC;
        input_B : in STD_LOGIC;
        output_Y : out STD_LOGIC
    );
end ANDGate;

architecture Behavioral of ANDGate is
begin
    process (input_A, input_B)
    begin
        output_Y <= input_A and input_B;
    end process;
end Behavioral;

