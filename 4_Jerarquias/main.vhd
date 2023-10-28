-- Archivo MainSystem.vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainSystem is
    Port (
        input_A : in STD_LOGIC;
        input_B : in STD_LOGIC;
        output_LED : out STD_LOGIC
    );
end MainSystem;

architecture Behavioral of MainSystem is
    signal and_output : STD_LOGIC;
begin
    AND1: entity work.ANDGate
        port map (
            input_A => input_A,
            input_B => input_B,
            output_Y => and_output
        );

    LED_CTRL: entity work.LEDController
        port map (
            input_data => and_output,
            output_LED => output_LED
        );
end Behavioral;
