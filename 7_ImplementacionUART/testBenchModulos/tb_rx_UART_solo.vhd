
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_rx_UART_solo IS
END tb_rx_UART_solo;
 
ARCHITECTURE behavior OF tb_rx_UART_solo IS 
 
  -- Component Declaration for the Unit Under Test (UUT)
 
  COMPONENT rx_UART
  PORT(
       clock            : IN  std_logic;
       reset            : IN  std_logic;
       d_in             : IN  std_logic;
       realiza_lectura  : IN  std_logic;
       lectura_completa : OUT  std_logic;
       reg_lectura      : OUT  std_logic_vector(7 downto 0);
       enable           : OUT  std_logic;
       top_count        : OUT  std_logic_vector(1 downto 0)
      );
  END COMPONENT;
  

  --Inputs
  signal tb_clock           : std_logic := '0';
  signal tb_reset           : std_logic := '0';
  signal tb_d_in            : std_logic := '0';
  signal tb_realiza_lectura : std_logic := '0';

       --Outputs
  signal tb_lectura_completa : std_logic;
  signal tb_reg_lectura      : std_logic_vector(7 downto 0);
  signal tb_enable           : std_logic;
  signal tb_top_count        : std_logic_vector(1 downto 0);


  -- Clock period definitions
  constant clock_period : time := 13.888888888888888888 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
  uut: rx_UART PORT MAP (
         clock            => tb_clock,
         reset            => tb_reset,
         d_in             => tb_d_in,
         realiza_lectura  => tb_realiza_lectura,
         lectura_completa => tb_lectura_completa,
         reg_lectura      => tb_reg_lectura,
         enable           => tb_enable,
         top_count        => tb_top_count
       );

  -- Clock process definitions
  clock_process :process
  begin
       tb_clock <= '0';
       wait for clock_period/2;
       tb_clock <= '1';
       wait for clock_period/2;
  end process;
 

  -- Stimulus process
  stim_proc: process
  begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
      tb_reset <= '1';
      tb_d_in  <= '1';
      wait for 100 ns;
      tb_reset <= '0';
     		
      wait for clock_period*10000;
      
      tb_d_in <= '0';  --start
      wait for 104.166667 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';   --stop
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      --wait for 52.0694411 us;
      
      wait for 52.083333 us;  -- espera medio tiempo de bit
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
  
			
      tb_d_in <= '0';  --start
      wait for 104.166667 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';     --stop
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
			
			
      tb_d_in <= '0';  --start
      wait for 104.166667 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '0';
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      tb_d_in <= '1';   --stop
      wait for 52.083333 us;
      tb_realiza_lectura<='1';
      wait for 13.888888888 ns;
      tb_realiza_lectura<='0';
      wait for 52.0694411 us;
      
      
      wait;
   end process;

END;
