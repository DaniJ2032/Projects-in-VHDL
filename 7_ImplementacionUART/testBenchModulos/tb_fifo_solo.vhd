
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_fifo_solo IS
END tb_fifo_solo;
 
ARCHITECTURE behavior OF tb_fifo_solo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFO
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         we : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal we : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 13.88888888888888888888888888888888888 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFO PORT MAP (
          clk => clk,
          reset => reset,
          we => we,
          data_in => data_in,
          data_out => data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset <= '1';
      data_in <= "00000000";
      we <= '0';
      wait for 100 ns;	
      reset <= '0';
      data_in <= "00000001";
      wait for clk_period*100;

      -- insert stimulus here 
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;
      
      data_in <= "00000010";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;
      
      data_in <= "00000011";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00000100";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00000101";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00000111";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001000";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001001";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001010";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001011";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001100";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001101";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001111";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00010000";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00010001";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "11111111";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "00001111";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;

      data_in <= "11110000";
      we <= '1';
      wait for clk_period;
      we <= '0';
      wait for 10416.66667 ns;


      






      wait;
   end process;

END;
