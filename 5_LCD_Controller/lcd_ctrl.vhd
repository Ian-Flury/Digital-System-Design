library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;

entity lcd_ctrl is
    port(
        clock       : in std_logic;     -- the "EN" specified in the datasheet
        RST         : in std_logic;
        LCD_DATA    : out std_logic_vector(7 downto 0);
        LCD_EN      : out std_logic;
        LCD_RW      : out std_logic;
        LCD_RS      : out std_logic;
        LCD_ON      : out std_logic;
        LCD_BLON    : out std_logic
    );
end lcd_ctrl;


architecture rtl of lcd_ctrl is 

-- Note: the "running" mode is the state of the initialization machine when 
--       init is complete and the display is ready to be communicated with normally,
--       i.e. a character write sequence can be performed.
type state_t is (Fn_1, Fn_2, Fn_3, Fn_4, Clr_Disp, Disp_Ctl, Entry_Mode, running);
signal state, next_state : state_t;

begin


    the_machine: process(state, RST)
    begin
        if RST = '1' then
            next_state <= Fn_1;
        else

            case state is
                when Fn_1 =>
                    -- outputs
                    next_state <= Fn_2;
                when Fn_2 =>
                    next_state <= Fn_3;
                when Fn_3 =>
                    next_state <= Fn_4;
                when Fn_4 =>
                    next_state <= Clr_Disp;
                when Clr_Disp =>
                    next_state <= Disp_Ctl;
                when Disp_Ctl =>
                    next_state <= Entry_Mode;
                when Entry_Mode =>
                    next_state <= running;
                when running =>

                when others =>
                    -- Do nothing
            end case;

        end if;
    end process the_machine;


    the_registers: process(clock)
    begin
    end process the_registers;

end rtl;