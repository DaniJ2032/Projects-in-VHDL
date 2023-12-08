
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_top_sin_Writer IS
END tb_top_sin_Writer;
 
ARCHITECTURE behavior OF tb_top_sin_Writer IS 
 
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
        GENERIC(ReadFile        : string  := "Archivo_de_Lectura.dat";
                OutputWidth	: integer := 10
               );
        PORT( NewData : IN std_logic;          
              FileON  : OUT std_logic;
              Output  : OUT std_logic_vector((OutputWidth-1) downto 0)
            );
    END COMPONENT;   

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal rx : std_logic := '0';
   signal reading: std_logic := '0';
   signal writing: std_logic := '0';

   signal enable_lectura_READER : std_logic := '0';
   signal fileon                : std_logic := '0';
   signal arrRx                 : std_logic_vector(9 downto 0);

   --Outputs
   signal tx : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns; --1 / 100MHz
   constant bit_time     : time := 8.68055555555555555 us; --1 / 115200baudios
 
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
      GENERIC MAP(ReadFile      => "./../../../Archivo_de_Lectura.dat",	
                  OutputWidth	=> 10)
      PORT MAP(
      	NewData	=> enable_lectura_READER,
      	FileON	=> fileon,
      	Output	=> arrRx);

   -- Clock process definitions
   clock_process :process
   begin
      clock <= '0';
      wait for clock_period/2;
      clock <= '1';
      wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      rx    <= '1';
      wait for 100 ns;	
      reset <= '0';
      rx    <= '1';

      wait for clock_period*1000;

      for i in 0 to 90909 loop    
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

END;
