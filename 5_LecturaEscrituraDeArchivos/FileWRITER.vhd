----------------------------------------------------------------------------------
-- FileWRITER es un componente que se instancia en el codigo de test bench de simulacion, este sirve para
-- escribir en un archivo (asignado a "WriteFile" en la declaracion generica) la senal del bus de entrada 
-- "Input" de ancho "InputWidth". El componente escribe en el archivo un dato nuevo por cada flanco  
-- ascendente de la senal "NewData" mientras la senal "FileON" este en alto.
-- El nombre del archivo de salida se lo declara en la instanciacion.
-- Para el uso del componente es necesario agregar el archivo "txt_until.vhd" a la carpeta del proyecto.
----------------------------------------------------------------------------------
--COMPONENT FileWRITER
--	Generic(	WriteFile: string := "Archivo.dat";
--				InputWidth : integer := 8);
--	PORT	(
--		NewData 	: IN std_logic;
--		Input 	: IN std_logic_vector((InputWidth-1) downto 0);
--		FileON 	: IN std_logic);
--END COMPONENT;
--
--Inst_FileWRITER: FileWRITER 
--	GENERIC MAP(
--		WriteFile => "Archivo.dat",	-- En el caso de que el archivo no este en la carpeta de trabajo: C:\Carpeta/NombreArchivo.extension
--		InputWidth => 8)
--	PORT MAP(
--		NewData => ,
--		Input => ,
--		FileON => );
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use work.txt_util.all;

entity FileWRITER is
	Generic(	WriteFile: string := "Archivo.dat";	-- En el caso de que el archivo no este en la carpeta de trabajo: C:\Carpeta/NombreArchivo.extension
				InputWidth : integer := 8);
				
    Port	(	NewData 	: in  STD_LOGIC;
				Input 	: in  STD_LOGIC;--_VECTOR ((InputWidth-1) downto 0);
				FileON 	: in  STD_LOGIC);
end FileWRITER;

architecture Behavioral of FileWRITER is

FILE variableTB  :  text  open write_mode  is  WriteFile;

signal sigFileON	: STD_LOGIC := '0';
signal sigInput	: STD_LOGIC:='0';--_VECTOR ((InputWidth-1) downto 0) := (others => '0');

begin

write_proc: process
	variable LineVar : line;
	variable StringVar : string(1 to InputWidth);
   begin	
		wait until rising_edge(sigFileON);
		StringVar := str( sigInput );
		write ( LineVar , StringVar ) ;
		writeline ( variableTB , LineVar );
end process;

sigInput <= Input;
sigFileON <= FileON AND NewData;

end Behavioral;

