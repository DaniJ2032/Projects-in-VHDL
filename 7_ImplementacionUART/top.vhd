
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
        Generic(BAUDIOS    : integer:= 115200;
                FREQ_CLOCK : integer:= 100000000
               );
        Port( clock   : in STD_LOGIC;
              reset   : in STD_LOGIC;
              rx      : in STD_LOGIC;
              tx      : out STD_LOGIC;
              reading : out STD_LOGIC;
              writing : out STD_LOGIC
            );		
end top;



architecture Behavior of top is


  component contador is		
      Generic( MAX : integer:= 7500  -- ejemplo: 72MHz/9600 Baudios = 7500
             );
      Port( clock        : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            enable       : in  STD_LOGIC;
            top_count 	 : in  STD_LOGIC_VECTOR(1 downto 0);
            is_max_count : out  STD_LOGIC
          );
  end component contador;
  
  component rx_UART is
      Port( clock            : in  STD_LOGIC;
            reset            : in  STD_LOGIC;
            d_in             : in  STD_LOGIC;
            realiza_lectura  : in  STD_LOGIC;
            write_address    : out STD_LOGIC_VECTOR(4 downto 0);
            reg_lectura      : out STD_LOGIC_VECTOR(7 downto 0);
            lectura_completa : out STD_LOGIC;
            enable           : out STD_LOGIC;
            top_count 	     : out STD_LOGIC_VECTOR(1 downto 0)
          );
  end component rx_UART;	
  
  component FIFO is
      Port( clk                 : in  STD_LOGIC;
            reset               : in  STD_LOGIC;
            we                  : in  STD_LOGIC;
            re                  : in  STD_LOGIC;
            write_ptr           : in  STD_LOGIC_VECTOR(4 downto 0);
            read_ptr            : in  STD_LOGIC_VECTOR(4 downto 0);
            data_in             : in  STD_LOGIC_VECTOR(7 downto 0);
            data_available      : out  STD_LOGIC;
            lectura_actualizada : out  STD_LOGIC;
            data_out            : out  STD_LOGIC_VECTOR(7 downto 0)
          );
  end component FIFO;

  component contador_para_baudios is
    Generic( MAX : integer:= 868  -- ejemplo: 100MHz/115200 = 868
           );
    Port( clock    : in  STD_LOGIC;
          reset    : in  STD_LOGIC;
          enable   : in  STD_LOGIC;
          send_bit : out  STD_LOGIC
        );
  end component contador_para_baudios;

  component tx_UART is
    Port ( clock                : in  STD_LOGIC;
           reset                : in  STD_LOGIC;
           data_available       : in  STD_LOGIC;
           registro_actualizado : in  STD_LOGIC;
           data_in              : in  STD_LOGIC_VECTOR(7 downto 0);
           send_bit             : in  STD_LOGIC;
           read_address         : out STD_LOGIC_VECTOR(4 downto 0);
           ready_to_send        : out  STD_LOGIC;
           enable_count         : out  STD_LOGIC;
           tx                   : out  STD_LOGIC);
  end component tx_UART;

  
  signal enable_count_from_rx            : STD_LOGIC;
  signal top_count_from_rx               : STD_LOGIC_VECTOR(1 downto 0);
  signal is_max_count_to_rx              : STD_LOGIC;
  signal s_write_addr_from_tx_to_fifo    : STD_LOGIC_VECTOR(4 downto 0);
  signal s_read_addr_from_tx_to_fifo     : STD_LOGIC_VECTOR(4 downto 0);
  signal s_lectura_completa_to_fifo      : STD_LOGIC;
  signal s_reg_lectura_to_fifo           : STD_LOGIC_VECTOR(7 downto 0);
  signal s_data_available_from_fifo      : STD_LOGIC;
  signal s_lec_act_from_fifo_to_tx       : STD_LOGIC;
  signal s_data_out_from_fifo_to_tx      : STD_LOGIC_VECTOR(7 downto 0);
  signal s_ready_to_send_from_tx_to_fifo : STD_LOGIC;
  signal s_enable_counter_for_baudios    : STD_LOGIC;
  signal s_send_bit_to_tx                : STD_LOGIC;
  signal s_tx                            : STD_LOGIC;
  
  begin
      inst_contador : contador
          generic map( MAX => FREQ_CLOCK/BAUDIOS
                     )
          port map( clock        => clock,
                    reset        => reset,
                    enable       => enable_count_from_rx,
                    top_count    => top_count_from_rx,
                    is_max_count => is_max_count_to_rx
                  );
      											
      inst_rx_UART : rx_UART
          port map( clock            => clock,
                    reset            => reset,
                    d_in             => rx,
                    realiza_lectura  => is_max_count_to_rx,
                    write_address    => s_write_addr_from_tx_to_fifo,
                    reg_lectura      => s_reg_lectura_to_fifo,
                    lectura_completa => s_lectura_completa_to_fifo,
                    enable           => enable_count_from_rx,
                    top_count 	     => top_count_from_rx
                  );
      	
      inst_FIFO : FIFO
          port map( clk                 => clock,
                    reset               => reset,
                    we                  => s_lectura_completa_to_fifo,
                    re                  => s_ready_to_send_from_tx_to_fifo,
                    write_ptr           => s_write_addr_from_tx_to_fifo,
                    read_ptr            => s_read_addr_from_tx_to_fifo,
                    data_in             => s_reg_lectura_to_fifo,
                    data_available      => s_data_available_from_fifo,
                    lectura_actualizada => s_lec_act_from_fifo_to_tx,
                    data_out            => s_data_out_from_fifo_to_tx
                  );
      
      inst_contador_para_baudios : contador_para_baudios
          generic map( MAX => FREQ_CLOCK/BAUDIOS
                     )
          port map( clock    => clock,
                    reset    => reset,
                    enable   => s_enable_counter_for_baudios,
                    send_bit => s_send_bit_to_tx
                  );
      
      inst_tx_UART : tx_UART
            port map( clock                => clock,
                      reset                => reset,
                      data_available       => s_data_available_from_fifo,
                      registro_actualizado => s_lec_act_from_fifo_to_tx,
                      data_in              => s_data_out_from_fifo_to_tx,
                      send_bit             => s_send_bit_to_tx,
                      read_address         => s_read_addr_from_tx_to_fifo,
                      ready_to_send        => s_ready_to_send_from_tx_to_fifo,
                      enable_count         => s_enable_counter_for_baudios,
                      tx                   => s_tx  
                    );
      
      tx      <= s_tx;
      reading <= enable_count_from_rx;
      writing <= s_enable_counter_for_baudios;

end Behavior;


