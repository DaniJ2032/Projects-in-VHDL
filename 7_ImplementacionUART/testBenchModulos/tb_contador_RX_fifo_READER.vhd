
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_contador_RX_fifo_READER IS
END tb_contador_RX_fifo_READER;
 
ARCHITECTURE behavior OF tb_contador_RX_fifo_READER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         rx : IN  std_logic;
         data_out_from_fifo_to_tx : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

     --agrega el reader
    COMPONENT FileREADER
    GENERIC(ReadFile: string	  := "Archivo_de_Lectura.dat";
            OutputWidth	: integer := 10);
    PORT( NewData : IN std_logic;          
          FileON  : OUT std_logic;
          Output  : OUT std_logic_vector((OutputWidth-1) downto 0));
    END COMPONENT;   

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal rx : std_logic := '0';

   signal enable_lectura_READER : std_logic := '0';
   signal fileon                : std_logic := '0';
   signal arrRx                 : std_logic_vector(9 downto 0);


   --Outputs
   signal data_out_from_fifo_to_tx : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns; --1 / 100MHz
   constant bit_time     : time := 8.68055555555555555 us; --1 / 115200baudios
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clock => clock,
          reset => reset,
          rx => rx,
          data_out_from_fifo_to_tx => data_out_from_fifo_to_tx
        );

        --Instanciacion del reader
   Inst_FileREADER: FileREADER 
      GENERIC MAP(ReadFile      => "C:\\Users\\tomyb\\OneDrive\\Escritorio\\VHDL\\UART\\Archivo_de_Lectura.dat",	
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

      for i in 0 to 29 loop    -- Errores en luego del dato 16 y luego del dato 28 del archivo de texto.
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
