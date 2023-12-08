
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;

entity tx_UART is
    Port( clock                : in  STD_LOGIC;
          reset                : in  STD_LOGIC;
          data_available       : in  STD_LOGIC;
          registro_actualizado : in  STD_LOGIC;
          data_in              : in  STD_LOGIC_VECTOR(7 downto 0);
          send_bit             : in  STD_LOGIC;
          read_address         : out  STD_LOGIC_VECTOR(4 downto 0);
          ready_to_send        : out  STD_LOGIC;
          enable_count         : out  STD_LOGIC;
          tx                   : out  STD_LOGIC
        );
end tx_UART;


architecture Behavioral of tx_UART is
	
  type state_type is (IDLE, actualiza_reg, START, envia_b0, envia_b1, envia_b2, envia_b3,
                      envia_b4, envia_b5, envia_b6, envia_b7, bSTOP, actualiza_ptr);  
  signal state : state_type;

  signal reg_lectura    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
  signal s_read_address : STD_LOGIC_VECTOR(4 downto 0);

  begin
    	
    SYNC_PROC: process (clock,reset)
    begin
        if(reset = '1') then 
            state           <= IDLE;
            read_address    <= "00000";
            s_read_address  <= "00000";
            ready_to_send   <= '0';
            enable_count    <= '0';
            tx              <= '1';
            reg_lectura     <= "00000000";
          
        elsif(clock'event and clock = '1') then
            read_address <= s_read_address;
           
            case(state) is
                when IDLE =>
                    if(data_available = '1') then
                        state <= actualiza_reg;
                    end if;	
                    enable_count  <= '0';
                    ready_to_send <= '1';
                    tx            <= '1';
                    
                when actualiza_reg =>
                    if(registro_actualizado = '1') then
                      state <= START;
                      ready_to_send <= '0';
                      reg_lectura   <= data_in;
                    end if;
                
                when START => 
                    if(send_bit = '1') then
                        state <= envia_b7; 
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= '0';
                
                when envia_b7 =>                     
                    if(send_bit = '1') then
                        state <= envia_b6;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(7);
                
                when envia_b6 =>
                    if(send_bit = '1') then
                        state <= envia_b5;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(6);
                
                when envia_b5 =>
                    if(send_bit = '1') then
                        state <= envia_b4;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(5);
               
                when envia_b4 =>
                    if(send_bit = '1') then
                      state <= envia_b3;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(4);
               
                when envia_b3 =>
                    if(send_bit = '1') then
                      state <= envia_b2;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(3);
                    
                when envia_b2 =>
                    if(send_bit = '1') then
                      state <= envia_b1;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(2);
                    
                when envia_b1 =>
                    if(send_bit = '1') then
                      state <= envia_b0;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(1);
                
                when envia_b0 =>
                    if(send_bit = '1') then
                      state <= bSTOP;                    
                    end if;
                    enable_count  <= '1';
                    ready_to_send <= '0';
                    tx            <= reg_lectura(0);
                    
                when bSTOP =>
                    if(send_bit = '1') then
                        state         <= actualiza_ptr;
                        ready_to_send <= '1';
                    else
                      enable_count  <= '1';
                      ready_to_send <= '0';
                      tx            <= '1';
                    end if;
                    
                when actualiza_ptr =>
                    state <= IDLE;
                    if(s_read_address < "11111") then
                        s_read_address <= s_read_address+1;
                        read_address   <= s_read_address+1;
                    else
                        s_read_address  <= "00000";
                        read_address    <= "00000";
                    end if;
                    
                    
                when others =>
                    state           <= IDLE;
                    s_read_address  <= "00000";
                    enable_count    <= '0';
                    ready_to_send   <= '0';
                    tx              <= '1';
                    
            end case;      
        end if;
    end process;
 
end Behavioral;


