
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity FIFO is
    Port( clk                 : in  STD_LOGIC;
          reset               : in  STD_LOGIC;
          we                  : in  STD_LOGIC;
          re                  : in  STD_LOGIC;
          write_ptr           : in  STD_LOGIC_VECTOR(4 downto 0);
          read_ptr            : in  STD_LOGIC_VECTOR(4 downto 0);
          data_in             : in  STD_LOGIC_VECTOR(7 downto 0);          
          data_available      : out STD_LOGIC;
          lectura_actualizada : out STD_LOGIC;
          data_out            : out STD_LOGIC_VECTOR(7 downto 0)
        );
end FIFO;

architecture Behavioral of FIFO is

type FIFO is array(31 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
signal mem : FIFO;

begin
    process(clk, reset) 
    begin  
        if(reset = '1') then
            data_available      <= '0';
            lectura_actualizada <= '0';
        elsif(rising_edge(clk)) then
            if(we = '1') then               --OPERACION DE ESCRITURA
                mem(conv_integer(write_ptr)) <= data_in;
                lectura_actualizada <= '0';
            elsif(re = '1') then            --OPERACION DE LECTURA
                if((read_ptr<write_ptr) or ((read_ptr-write_ptr)< "11111")) then
                    data_out            <= mem(conv_integer(read_ptr));
                    lectura_actualizada <= '1';
                end if;
            end if;
            
            if(((read_ptr+1) = write_ptr) or (read_ptr="11111" and write_ptr="00000")) then
                data_available  <= '0';
            else
                data_available  <= '1';
            end if;
        end if;
       
    end process;
end Behavioral;

