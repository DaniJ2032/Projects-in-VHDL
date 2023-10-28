----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:18:14 10/26/2023 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( mux_selec_in : in  STD_LOGIC_VECTOR (2 downto 0);
           bcd7seg_out : out  STD_LOGIC_VECTOR (6 downto 0));
end main;

architecture Behavioral of main is

begin
						-- with - select --
-- with mux_selec_in select
-- bcd7seg_out <= 
-- 					"1000000" when "000",   --0	
-- 					"1111001" when "001",   --1
-- 					"0100100" when "010",   --2
-- 					"0110000" when "011",   --3
-- 					"0011001" when "100",   --4
-- 					"0010010" when "101",   --5
-- 					"0000010" when "110",   --6
-- 					"1111000" when others;  --7

					-- when - else --	
bcd7seg_out <=	"1000000" when mux_selec_in = "000"  else   --0	
					"1111001" when mux_selec_in = "001"  else   --1
					"0100100" when mux_selec_in = "010"  else   --2
					"0110000" when mux_selec_in = "011"  else   --3
					"0011001" when mux_selec_in = "100"  else   --4
					"0010010" when mux_selec_in = "101"  else   --5
					"0000010" when mux_selec_in = "110"  else   --6
					"1111000" when mux_selec_in = "111";   	  --7							

end Behavioral;

