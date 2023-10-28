
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testBench IS
END testBench;
 
ARCHITECTURE behavior OF testBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MainSystem
    PORT(
         input_A : IN  std_logic;
         input_B : IN  std_logic;
         output_LED : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input_A : std_logic := '0';
   signal input_B : std_logic := '0';

 	--Outputs
   signal output_LED : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MainSystem PORT MAP (
          input_A => input_A,
          input_B => input_B,
          output_LED => output_LED
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      input_A <= '0';
      input_B <= '0';
      wait for 300 ns;
      input_A <= '0';
      input_B <= '1';
      wait for 300 ns;
      input_A <= '1';
      input_B <= '0';
      wait for 300 ns;
      input_A <= '1';
      input_B <= '1';
      wait for 300 ns;
      -- insert stimulus here 
      wait;
   end process;

END;
