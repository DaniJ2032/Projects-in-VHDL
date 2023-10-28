------------------------------------------------------------------------  
-- Proyecto : Generador de baudios 
-- Nombre: divisorForFrec.vhd
-- Funcion: Se toma el reloj de la FPGA de 125 MHz y se declara un 
--          contador el cual se encarga de ir contando hasta ciertos 
-- valores que son de referencia para obtener las salidas en baudios 
-- requeridas. 
------------------------------------------------------------------------  
--         -- TABLA DE BAUDIOS Y VALOR DEL CONTADOR --
-- |bps     |   contador valor  |   Valor del selector  |
-- |____________________________|_______________________|     
-- |   300  |      416666.67    |       0000            |            
-- |  1200  |      104166.67    |       0001            |
-- |  2400  |      52083.33     |       0010            | 
-- |  9600  |      13020.83     |       0011            |
-- | 19200  |      6510.42      |       0100            |
-- | 38400  |      3255.21      |       0101            |
-- | 57600  |      2170.14      |       0110            |
-- |115200  |      1085.07      |       0111            |
-- |230400  |      542.53       |       1000            |       
-- |460800  |      271.27       |       1001            |
-- |921600  |      135.63       |       1010            |

-- Estos valores para el cotnador dan la salida de un siclo completo
-- para los baudios, por ende a la hora de comparar se dividien por dos 
-- para obtener 50% del periódo de las señales en alto y el el resto en 
-- bajo. 
------------------------------------------------------------------------  
        --  MODULO JERARQUICO PARA EL main PRINCIPAL -- 
-- BAUD_CLOCK: entity work.Baud_Generator
--     port map (
--         clock_in        => clock_in,          
--         reset_in        => reset_in,                             
--         select_frec_in  => select_frec_in,   
--         clk_out         => clk_out       
--     );
-------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Baud_Generator is
    Port ( 
        clock_in: in  STD_LOGIC;                              -- Reloj de entrada a 125 MHz
        reset_in: in STD_LOGIC;                             -- Reset del sistema
		select_frec_in: in std_logic_vector (3 downto 0);   -- Selector de baudios 
        clk_out: out STD_LOGIC                              -- Reloj de salida Hz
    );
end Baud_Generator;

architecture Behavioral of Baud_Generator is
    -- constants --
    -- Valores para el contador 
    constant CLOCK_SYS : integer := 125E6; -- Clock del sistema
    constant BPS_300 : integer :=   (CLOCK_SYS/300) / 2;
    constant BPS_1200 : integer :=  (CLOCK_SYS/1200) / 2;
    constant BPS_2400 : integer :=  (CLOCK_SYS/2400) / 2;
    constant BPS_9600 : integer :=  (CLOCK_SYS/9600) / 2;
    constant BPS_19200 : integer := (CLOCK_SYS/19200) / 2;
    constant BPS_38400 : integer := (CLOCK_SYS/38400) / 2;
    constant BPS_57600 : integer := (CLOCK_SYS/57600) / 2;
    constant BPS_115200 : integer := (CLOCK_SYS/115200) / 2;
    constant BPS_230400 : integer := (CLOCK_SYS/230400) / 2;
    constant BPS_460800 : integer := (CLOCK_SYS/460800) / 2;
    constant BPS_921600 : integer := (CLOCK_SYS/921600) / 2;
    --  Signals -- 
    signal counter_s : integer := 0;    --Contador
    signal clk_out_s : STD_LOGIC := '0';  -- Reloj a 9600 Hz
    signal select_frec_in_s: std_logic_vector (3 downto 0) := (others => '0');
	
begin
    -- Process --
    BAUD_SELECT: process (clock_in)
    begin
        if rising_edge(clock_in) then -- En cada flanco de subida 
            if (reset_in = '1') then
                counter_s <= 0;
                clk_out_s <= '0'; 
            else 
                case select_frec_in is
                    when "0000" => 
                        if counter_s = BPS_300 then   -- 300 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;
                    
                    when "0001" => 
                        if counter_s = BPS_1200 then   -- 1200 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;                        

                    when "0010" => 
                        if counter_s = BPS_2400 then   -- 2400 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if; 

                    when "0011" => 
                        if counter_s = BPS_9600 then   --  9600 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;                        

                    when "0100" => 
                        if counter_s = BPS_19200 then   --  19200 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;                        

                    when "0101" => 
                        if counter_s = BPS_38400 then   -- 38400 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;                        

                    when "0110" => 
                        if counter_s = BPS_57600 then   -- 57600 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;                        

                    when "0111" => 
                        if counter_s = BPS_115200 then   --  115200 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;                         

                    when "1000" => 
                        if counter_s = BPS_230400 then   --  230400 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;

                    when "1001" => 
                        if counter_s = BPS_460800 then   --  460800 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if;

                    when others => -- "1010" y el resto de combinaciones 
                        if counter_s = BPS_921600 then    -- 921600 bps
                            counter_s <= 0;
                            clk_out_s <= not clk_out_s;
                        else
                            counter_s <= counter_s + 1;
                            clk_out <= clk_out_s;
                        end if; 
                end case;            
            end if;
            select_frec_in_s <= select_frec_in;
            -- Si se realizó un cambio de baudios                                       
            if select_frec_in /= select_frec_in_s  then
            counter_s <= 0;     -- Se reseta el contador
            clk_out_s <= '0';   -- Se resetea el clock
            end if;
            clk_out <= clk_out_s;  -- Salida    
        end if;
    end process;

end Behavioral;

