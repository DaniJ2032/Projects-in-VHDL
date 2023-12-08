
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         rx : IN  std_logic;
         tx : OUT  std_logic;
         reading : out STD_LOGIC;
         writing : out STD_LOGIC
        );
    END COMPONENT;
    
     --agrega el reader
    COMPONENT FileREADER
        GENERIC(ReadFile        : string  := "C:/Users/dajju/OneDrive/Escritorio/VHDL/runVHDL/7_UART/UART/Extras/Archivo_de_Lectura.dat";
                OutputWidth	: integer := 10
               );
        PORT( NewData : IN std_logic;          
              FileON  : OUT std_logic;
              Output  : OUT std_logic_vector((OutputWidth-1) downto 0)
            );
    END COMPONENT;   

     -- Agrega el writer.
    COMPONENT FileWRITER is
        GENERIC(WriteFile  : string  := "C:/Users/dajju/OneDrive/Escritorio/VHDL/runVHDL/7_UART/UART/Extras/Archivo_de_Escritura.dat"; --  C:/Carpeta/NombreArchivo.extension
                InputWidth : integer := 10
               );
        PORT( NewData : in  STD_LOGIC;
              Input   : in  STD_LOGIC_VECTOR ((InputWidth-1) downto 0);
              FileON  : in  STD_LOGIC);
    end COMPONENT;


   --Inputs
   signal clock   : std_logic := '0';
   signal reset   : std_logic := '0';
   signal rx      : std_logic := '0';
   signal reading : std_logic := '0';
   signal writing : std_logic := '0';

   signal enable_lectura_READER : std_logic := '0';
   signal fileon                : std_logic := '0';
   signal arrRx                 : std_logic_vector(9 downto 0);

   signal enable_escritura_WRITER : std_logic := '0';
   signal arrTx                   : std_logic_vector(9 downto 0);

   --Outputs
   signal tx : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns; --1 / 100MHz
   constant bit_time     : time := 8.68055555555555555 us; --1 / 115200baudios

   constant file_lines : integer := 90909;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clock => clock,
          reset => reset,
          rx => rx,
          tx => tx,
          reading => reading,
          writing => writing
        );

        --Instanciacion del reader
   Inst_FileREADER: FileREADER 
      GENERIC MAP(ReadFile      => "C:/Users/dajju/OneDrive/Escritorio/VHDL/runVHDL/7_UART/UART/Extras/Archivo_de_Lectura.dat",	
                  OutputWidth	=> 10)
      PORT MAP(
      	NewData	=> enable_lectura_READER,
      	FileON	=> fileon,
      	Output	=> arrRx);

   Inst_FileWRITER: FileWRITER 
      GENERIC MAP(WriteFile  => "C:/Users/dajju/OneDrive/Escritorio/VHDL/runVHDL/7_UART/UART/Extras/Archivo_de_Escritura.dat", --  C:/Carpeta/NombreArchivo.extension
                  InputWidth => 10
                 )
      PORT MAP( NewData => enable_escritura_WRITER,
                Input   => arrTx,
                FileON  => fileon
              );


   -- Clock process definitions
   clock_process :process
   begin
      clock <= '0';
      wait for clock_period/2;
      clock <= '1';
      wait for clock_period/2;
   end process;
 

   -- Stimulus process
   reading_proc: process
   begin		
      reset <= '1';
      rx    <= '1';
      wait for 100 ns;	
      reset <= '0';
      rx    <= '1';
      
      wait for clock_period*1000;
      
      for i in 0 to file_lines  loop    
          enable_lectura_READER <= '1';
          rx <= arrRx(9);
          wait for bit_time;
          enable_lectura_READER <= '0';
          rx <= arrRx(8);
          wait for bit_time;
          rx <= arrRx(7);
          wait for bit_time;
          rx <= arrRx(6);
          wait for bit_time;
          rx <= arrRx(5);
          wait for bit_time;
          rx <= arrRx(4);
          wait for bit_time;
          rx <= arrRx(3);
          wait for bit_time;
          rx <= arrRx(2);
          wait for bit_time;
          rx <= arrRx(1);
          wait for bit_time;
          rx <= arrRx(0);
          wait for bit_time;
      end loop;
      
      wait;
   end process;
  

   writing_proc: process
   begin		
      for i in 0 to file_lines loop    
          wait until rising_edge(writing);
          wait for bit_time/2;
          arrTx(9) <= tx;
          wait for bit_time;
          arrTx(8) <= tx;
          wait for bit_time;
          arrTx(7) <= tx;
          wait for bit_time;
          arrTx(6) <= tx;
          wait for bit_time;
          arrTx(5) <= tx;
          wait for bit_time;
          arrTx(4) <= tx;
          wait for bit_time;
          arrTx(3) <= tx;
          wait for bit_time;
          arrTx(2) <= tx;
          wait for bit_time;
          arrTx(1) <= tx;
          wait for bit_time;
          arrTx(0) <= tx;
          if(i = conv_integer(0)) then
            enable_escritura_WRITER <= '0';
          else
            enable_escritura_WRITER <= '1';
          end if;
          wait for bit_time/2;
          enable_escritura_WRITER <= '0';
      end loop;
      
      wait;
   end process;
END;
