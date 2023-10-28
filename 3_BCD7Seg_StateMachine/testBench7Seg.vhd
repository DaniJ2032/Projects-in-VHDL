--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:59:22 10/26/2023
-- Design Name:   
-- Module Name:   C:/Users/dajju/OneDrive/Escritorio/ProyectVHDL/3_BCD7Seg_StateMachine/C-BCD7Seg_StateMachine/Extras/testBench7Seg.vhd
-- Project Name:  C-BCD7Seg_StateMachine
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bcd7_Seg_SM
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
 
ENTITY testBench7Seg IS
END testBench7Seg;
 
ARCHITECTURE behavior OF testBench7Seg IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bcd7_Seg_SM
    PORT(
         clock_in : IN  std_logic;
         reset_in : IN  std_logic;
         mux_select_in : IN  std_logic_vector(2 downto 0);
         bcd7_seg_out : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock_in : std_logic := '0';
   signal reset_in : std_logic := '0';
   signal mux_select_in : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal bcd7_seg_out : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clock_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bcd7_Seg_SM PORT MAP (
          clock_in => clock_in,
          reset_in => reset_in,
          mux_select_in => mux_select_in,
          bcd7_seg_out => bcd7_seg_out
        );

   -- Clock process definitions
   clock_in_process :process
   begin
		clock_in <= '0';
		wait for clock_in_period/2;
		clock_in <= '1';
		wait for clock_in_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset_in <= '1';
      wait for clock_in_period*10;
		reset_in <= '0';
      wait for clock_in_period*10;	
		
		-- Init State Machine --
		mux_select_in <= "000";
		wait for clock_in_period*10;
		
		mux_select_in <= "001";
		wait for clock_in_period*10;
		
		mux_select_in <= "010";
		wait for clock_in_period*10;
		
		mux_select_in <= "011";
		wait for clock_in_period*10;
		
 		mux_select_in <= "100";
		wait for clock_in_period*10;
		
		mux_select_in <= "101";
		wait for clock_in_period*10;
		
		mux_select_in <= "110";
		wait for clock_in_period*10;
		
		mux_select_in <= "111";
		wait for clock_in_period*10;
		
		mux_select_in <= "000";
		wait for clock_in_period*10;
		
      wait;
   end process;

END;
