library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bcd7_Seg_SM is Port ( 
    -- in's --
    clock_in        : in  STD_LOGIC;
    reset_in        : in  STD_LOGIC;
    mux_select_in   : in  STD_LOGIC_VECTOR (2 downto 0);
    -- Outs --
    bcd7_seg_out    : out  STD_LOGIC_VECTOR (6 downto 0)
);

end bcd7_Seg_SM;

architecture Behavioral of bcd7_Seg_SM is

                    -- MOORE MACHINE --
    type state_type is (disp_0, disp_1, disp_2, disp_3, disp_4,
    disp_5, disp_6, disp_7); -- Declara un nuevo tipo de variable. 
    signal state, next_state : state_type; 
    -- Declare internal signals for all outputs of the state-machine --
    signal bcd7_seg_out_s : std_logic_vector (6 downto 0); 
begin

    SYNC_PROC: process (clock_in)
    begin
        if (clock_in'event and clock_in = '1') then
            if (reset_in = '1') then    -- Si se reset_in esta, se lleva a un estado conocido.
                state <= disp_0;
            else                     -- Si no, se sigue el flujo de la maquina de estados.
                state <= next_state;
                bcd7_seg_out <= bcd7_seg_out_s;
            end if;
        end if;
    end process;
    
    --MOORE State-Machine - Outputs based on state only
    OUTPUT_DECODE: process (state)
    begin
        case state is
            when disp_1 =>
                bcd7_seg_out_s <= "1111001";    --1
            when disp_2 =>
                bcd7_seg_out_s <= "0100100";    --2
            when disp_3 =>
                bcd7_seg_out_s <= "0110000";    --3 
            when disp_4 =>
                bcd7_seg_out_s <= "0011001";    --4         
            when disp_5 =>
                bcd7_seg_out_s <= "0010010";    --5
            when disp_6 =>
                bcd7_seg_out_s <= "0000010";    --6 
            when disp_7 =>
                bcd7_seg_out_s <= "1111000";    --7 
            when others =>
                bcd7_seg_out_s <= "1000000";    --0    
        end case;
    end process;        

    DISPLY_PROC: process (state, mux_select_in)
    begin
        next_state <= state;  -- Asignación predeterminada
        
        case state is
            when disp_0 =>
                if mux_select_in = "000" then   --0
                    next_state <= disp_1;
                end if;
            when disp_1 =>
                if mux_select_in = "001" then   --1
                    next_state <= disp_2;
                end if; 
            when disp_2 =>
                if mux_select_in = "010" then   --2
                    next_state <= disp_3;
                end if;                 
            when disp_3 =>
                if mux_select_in = "011" then   --3
                    next_state <= disp_4;
                end if; 
            when disp_4 =>
                if mux_select_in = "100" then   --4
                    next_state <= disp_5;
                end if; 
            when disp_5 =>
                if mux_select_in = "101" then   --5
                    next_state <= disp_6;
                end if; 
            when disp_6 =>
                if mux_select_in = "110" then   --6
                    next_state <= disp_7;
                end if; 
            when disp_7 =>
                if mux_select_in = "111" then   --7
                    next_state <= disp_0;
                end if; 
        end case;
    end process;

end Behavioral;

