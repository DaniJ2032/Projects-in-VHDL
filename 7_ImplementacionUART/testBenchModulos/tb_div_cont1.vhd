--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:26:11 10/27/2023
-- Design Name:   
-- Module Name:   C:/VHDL/UART/tb_div_cont1.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_div_cont1 IS
END tb_div_cont1;
 
ARCHITECTURE behavior OF tb_div_cont1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         enable2 : IN  std_logic;
         top_count2 : IN  std_logic;
         is_max_count2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal tb_clock : std_logic := '0';
   signal tb_reset : std_logic := '0';
   signal tb_enable2 : std_logic := '0';
   signal tb_top_count2 : std_logic := '0';

 	--Outputs
   signal tb_is_max_count2 : std_logic;

   -- Clock period definitions
   constant clock_period : time := 13.8888888888888888888888888888888888888888888888888888888888888 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clock => tb_clock,
          reset => tb_reset,
          enable2 => tb_enable2,
          top_count2 => tb_top_count2,
          is_max_count2 => tb_is_max_count2
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
		tb_enable2 <= '0';
		tb_top_count2 <= '0';
		wait for 50 ns;
		tb_reset <= '0';
		
      wait for clock_period*10;
		
		tb_enable2 <= '1';
		wait for 1000 us;
		tb_top_count2 <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
