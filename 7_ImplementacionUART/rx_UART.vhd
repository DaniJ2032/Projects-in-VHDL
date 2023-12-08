
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;


entity rx_UART is
    Port( clock            : in  STD_LOGIC;
          reset            : in  STD_LOGIC;
          d_in             : in  STD_LOGIC;
          realiza_lectura  : in  STD_LOGIC;
          write_address    : out STD_LOGIC_VECTOR(4 downto 0);
          reg_lectura      : out STD_LOGIC_VECTOR(7 downto 0);
          lectura_completa : out STD_LOGIC;
          enable           : out STD_LOGIC;
          top_count        : out STD_LOGIC_VECTOR(1 downto 0)
        );
end rx_UART;	

architecture Behavioral of rx_UART is
	
  type state_type is (IDLE, lectura_b0, lectura_b1, lectura_b2, lectura_b3, lectura_b4,
                      lectura_b5, lectura_b6, lectura_b7, lectura_bSTOP, actualiza_ptr, ERR_St);  
  signal state : state_type;
  
  signal s_write_address : STD_LOGIC_VECTOR(4 downto 0);

  begin
    	
    SYNC_PROC: process (clock,reset)
    begin
        if(reset = '1') then 
            state            <= IDLE;
            s_write_address  <= "00001";
            write_address    <= "00001";
            reg_lectura      <= "00000000";
            lectura_completa <= '0';
            enable           <= '0';
            top_count        <= "00";
          
        elsif(clock'event and clock = '1') then
            write_address <= s_write_address;
            
            case(state) is
                when IDLE =>
                    if(d_in = '0') then
                        state       <= lectura_b7;
                        reg_lectura <= "00000000";
                    end if;	
                    lectura_completa <= '0';
                    enable           <= '0';
                    top_count        <= "10";
                
                when lectura_b7 => 
                    if(realiza_lectura = '1') then
                        state          <= lectura_b6;
                        reg_lectura(7) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "10";
                
                when lectura_b6 =>
                    if(realiza_lectura = '1') then
                        state          <= lectura_b5;
                        reg_lectura(6) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "01";
                
                when lectura_b5 =>
                    if(realiza_lectura = '1') then
                        state          <= lectura_b4;
                        reg_lectura(5) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "01";
               
                when lectura_b4 =>
                    if(realiza_lectura = '1') then
                        state          <= lectura_b3;
                        reg_lectura(4) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "01";
               
                when lectura_b3 =>
                    if(realiza_lectura = '1') then
                        state          <= lectura_b2;
                        reg_lectura(3) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "01";
                    
                when lectura_b2 =>
                    if(realiza_lectura = '1') then
                        state          <= lectura_b1;
                        reg_lectura(2) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "01";
                    
                when lectura_b1 =>
                    if(realiza_lectura = '1') then
                        state          <= lectura_b0;
                        reg_lectura(1) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "01";
                
                when lectura_b0 =>
                    if(realiza_lectura = '1') then
                        state          <= lectura_bSTOP;
                        reg_lectura(0) <= d_in;
                    end if;
                    lectura_completa <= '0';
                    enable           <= '1';
                    top_count        <= "01";
                    
                when lectura_bSTOP =>
                    if(realiza_lectura = '1') then
                        if(d_in = '0') then
                            state            <= ERR_St;
                            enable           <= '1';
                            top_count        <= "00";
                            lectura_completa <= '0';
                            reg_lectura      <= "00000000";
                        else
                            state            <= actualiza_ptr;
                            enable           <= '0';
                            top_count        <= "10";
                            lectura_completa <= '1';
                        end if;
                        
                    else
                        enable           <= '1';
                        top_count        <= "01";
                        lectura_completa <= '0';
                    end if;
                  
                when actualiza_ptr =>
                    state            <= IDLE;
                    lectura_completa <= '0';
                    
                    if(s_write_address < "11111") then
                        s_write_address  <= s_write_address+1;
                    else
                        s_write_address  <= "00000";
                    end if;
                 
                when ERR_St =>
                    if(realiza_lectura = '1') then
                        state       <= IDLE;
                    end if;
                    enable           <= '1';
                    top_count        <= "00";
                    lectura_completa <= '0';
                    
                when others =>
                    state            <= IDLE;
                    s_write_address  <= "00001";
                    lectura_completa <= '0';
                    enable           <= '0';
                    top_count        <= "01";
                    reg_lectura      <= "00000000";
                    
            end case;      
            
        end if;
    end process;
   
 
end Behavioral;

