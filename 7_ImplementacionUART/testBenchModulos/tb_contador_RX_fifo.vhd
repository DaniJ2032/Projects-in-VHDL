
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_contador_RX_fifo IS
END tb_contador_RX_fifo;
 
ARCHITECTURE behavior OF tb_contador_RX_fifo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         rx : IN  std_logic;
         data_out_from_fifo_to_tx : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal rx : std_logic := '0';

 	--Outputs
   signal data_out_from_fifo_to_tx : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns; --1 / 100MHz
   constant bit_time     : time := 8.68055555555555555 us; --1 / 115200baudios
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clock => clock,
          reset => reset,
          rx => rx,
          data_out_from_fifo_to_tx => data_out_from_fifo_to_tx
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset <= '1';
      rx    <= '1';
      wait for 100 ns;	
      reset <= '0';
      rx    <= '1';

      wait for clock_period*10000;

      -- insert stimulus here 
      rx <= '0';  --start ERROR
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '0';   --stop ERROR
      wait for bit_time;

      rx <= '0';  --start 00000000
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00000001
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start ERROR
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '0';   --stop ERROR
      wait for bit_time;

      rx <= '0';  --start 00000010
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop 
      wait for bit_time;

      rx <= '0';  --start 00000011
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00000100
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00000101
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00000110
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00000111
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001000
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001001
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001010
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001011
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001100
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001101
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001110
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00001111
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00010000
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00010001
      wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      rx <= '0';  --start 00010010
      wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '1';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
        rx <= '0';
        wait for bit_time;
      rx <= '1';   --stop
      wait for bit_time;

      wait;
   end process;

END;
