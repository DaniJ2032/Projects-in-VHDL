----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:09 10/25/2023 
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

entity main is Port (
 
	A : in  STD_LOGIC;		-- Entradas tipo std_logic
	B : in  STD_LOGIC;
	OUT1 : out  STD_LOGIC;	-- Salidas std_logic
	OUT2 : out  STD_LOGIC
);
	
end main;
----------------------------------------------------------------------------------
architecture Behavioral of main is

signal out_and_s: STD_LOGIC;	-- Signal std_logic

begin
	out_and_s <= A and B;			-- Compuerta AND entre entrada A y B conectado a su salida al signal	
	OUT1 <= out_and_s;			-- Salida conectada a la signal
	OUT2 <= out_and_s and B;	-- salida 2 conectada a una AND entre entrada C y la signal
	
end Behavioral;
