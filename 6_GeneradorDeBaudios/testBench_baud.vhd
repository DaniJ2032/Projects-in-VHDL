-------------------------------------------------------------------------
--				Test Bench para el modulo generador de baudios 				  --
-------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Baud_Generator_TestBench is
end Baud_Generator_TestBench;

architecture Behavioral of Baud_Generator_TestBench is
    signal clock_in :  STD_LOGIC  := '0';      -- Reloj del sistema
    signal reset_in: STD_LOGIC  := '0';      -- Reset del sistema   
    signal select_frec_in : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); -- Selector de baudios
    signal clk_out : STD_LOGIC;      -- Reloj de salida
begin
    -- Instancia de la unidad bajo prueba
    uut: entity work.Baud_Generator
        Port Map (
            clock_in => clock_in,
            reset_in => reset_in,
            select_frec_in => select_frec_in, 
            clk_out => clk_out
        );

    -- Seteo del clock del sistema a 125 MHz
    clock_in_process: process
    begin
        clock_in <= '0';
        wait for 4 ns;
        clock_in <= '1';
        wait for 4 ns;
    end process;

    -- Proceso de monitorización de la señal de salida
    monitor_process: process
    begin
        wait for 100 ns;  -- Espera antes de comenzar la monitorización
        reset_in <= '1';
        wait for 100 ns;
        reset_in <= '0';
        select_frec_in <= "0000";   -- 300 bps	
        wait for 6 ms;
        select_frec_in <= "0001";   -- 1200 bps
        wait for 6 ms;
        select_frec_in <= "0010";   -- 2400 bps
        wait for 6 ms;
        select_frec_in <= "0011";   -- 9600
        wait for 6 ms;        
        select_frec_in <= "0100";   -- 19200
        wait for 6 ms;
        select_frec_in <= "0101";   -- 38400
        wait for 6 ms;
        select_frec_in <= "0110";   -- 57600
        wait for 6 ms;
        select_frec_in <= "0111";   -- 115200
        wait for 6 ms;
        select_frec_in <= "1000";   -- 230400
        wait for 6 ms;
        select_frec_in <= "1001";   -- 460800
        wait for 6 ms;
        select_frec_in <= "1010";   -- 921600       

        wait;
    end process;
end Behavioral;
