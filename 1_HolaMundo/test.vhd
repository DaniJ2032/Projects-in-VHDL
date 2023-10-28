--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:41:13 10/25/2023
-- Design Name:   
-- Module Name:   C:/Users/dajju/OneDrive/Escritorio/ProyectVHDL/A-HolaMundo/Extras/test.vhd
-- Project Name:  A-HolaMundo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
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
 
ENTITY test IS
END test;

ARCHITECTURE behavior OF test IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT main
    PORT(
         A : IN      std_logic;
         B : IN      std_logic;
         OUT1 : OUT  std_logic;
         OUT2 : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';

 	--Outputs
   signal OUT1: std_logic;
   signal OUT2: std_logic;
 
   -- constant <clock>_period : time := 10 ns;
 
BEGIN 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          A    => A,
          B    => B,
          OUT1 => OUT1,
          OUT2 => OUT2
        );

 -- Clock process definitions
   -- <clock>_process :process
   -- begin
   --    <clock> <= '0';
   --    wait for <clock>_period/2;
   --    <clock> <= '1';
   --    wait for <clock>_period/2;
   -- end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      A <= '0';
      B <= '0';
      wait for 100 ns;
      A <= '1';
      B <= '0';
      wait for 100 ns;
      A <= '0';
      B <= '1';
      wait for 100 ns;
      A <= '1';
      B <= '1';
      wait for 500 ns;
      A <= '0';
      B <= '0';		
      -- wait for <clock>_period*10;
      wait;
   end process;

END;
