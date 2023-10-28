----------------------------------------------------------------------------------
-- FileREADER es un componente que se instancia en el codigo de test bench de simulacion, este sirve para
-- leer un archivo (asignado a "ReadFile" en la declaracion generica) y transformar sus lineas en una senal 
-- logica de ancho "OutputWidth". El componente proporciona datos nuevos al por cada flanco ascendente de
-- la senal "NewData" e indica que el archivo finalizo con la senal "FileON" en bajo.
-- Para el uso del componente es necesario agregar el archivo "txt_until.vhd" a la carpeta del proyecto.
----------------------------------------------------------------------------------
-- Declaracion de componente:
--
--COMPONENT FileREADER
--	GENERIC(	ReadFile: string	:= "AddressFile.dat";
--				OutputWidth	: integer := 8);
--	PORT(	NewData	: IN std_logic;          
--			FileON	: OUT std_logic;
--			Output	: OUT std_logic_vector((OutputWidth-1) downto 0));
--END COMPONENT;
--
-- Instanciacion de componente:
--
--Inst_FileREADER: FileREADER 
--	GENERIC MAP(
--		ReadFile		=> "AddressFile.dat",	-- En el caso de que el archivo no este en la carpeta de trabajo: C:\Carpeta/NombreArchivo.extension
--		OutputWidth	=> 8)
--	PORT MAP(
--		NewData	=> ,
--		FileON	=> ,
--		Output	=> );
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use work.txt_util.all;

entity FileREADER is
	Generic(	ReadFile: string := "AddressFile.dat";	-- En el caso de que el archivo no este en la carpeta de trabajo: C:\Carpeta/NombreArchivo.extension
				OutputWidth : integer := 8);

	Port(	NewData 	: in   STD_LOGIC;
			FileON 	: out  STD_LOGIC;
			Output 	: out  STD_LOGIC_VECTOR ((OutputWidth-1) downto 0));
end FileREADER;

architecture Behavioral of FileREADER is
FILE variableTB	: text  open read_mode  is  ReadFile;

signal sigFileON	: STD_LOGIC := '0';
signal sigOutput	: STD_LOGIC_VECTOR ((OutputWidth-1) downto 0) := (others => '0');

begin

read_proc: process
	variable LineVar : line;
	variable StringVar : string(1 to OutputWidth);
begin	
	while not endfile ( variableTB ) loop
		sigFileON <= '1';
		wait until rising_edge(NewData);
		readline ( variableTB , LineVar );
		read ( LineVar , StringVar ) ;
		sigOutput <= to_std_logic_vector( StringVar );
	end loop;
	sigFileON <= '0';
	file_close(variableTB);
end process;

Output <= sigOutput;
FileON <= sigFileON;

end Behavioral;

