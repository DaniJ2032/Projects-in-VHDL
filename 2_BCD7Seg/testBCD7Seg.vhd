--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:20:48 10/26/2023
-- Design Name:   
-- Module Name:   C:/Users/dajju/OneDrive/Escritorio/ProyectVHDL/B-BCD7Seg/Extras/testBCD7Seg.vhd
-- Project Name:  B-BCD7Seg
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
 
ENTITY testBCD7Seg IS
END testBCD7Seg;
 
ARCHITECTURE behavior OF testBCD7Seg IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         mux_selec_in : IN  std_logic_vector(2 downto 0);
         bcd7seg_out : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mux_selec_in : std_logic_vector(2 downto 0) := (others => '0');
 	--Outputs
   signal bcd7seg_out : std_logic_vector(6 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          mux_selec_in => mux_selec_in,
          bcd7seg_out => bcd7seg_out
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      mux_selec_in <= "000";
      wait for 300 ns;
      mux_selec_in <= "001";
      wait for 300 ns;
      mux_selec_in <= "010";
      wait for 300 ns;
      mux_selec_in <= "011";
      wait for 300 ns;
      mux_selec_in <= "100";
      wait for 300 ns;
      mux_selec_in <= "101";
      wait for 300 ns;
      mux_selec_in <= "110";
      wait for 300 ns;
      mux_selec_in <= "111";
      wait for 300 ns;
      mux_selec_in <= "000";
      wait;
   end process;

END;
