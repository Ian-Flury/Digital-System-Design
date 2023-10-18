library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;

entity lcd_ctrl is
    port(
        clock       : in std_logic;
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

type state_t is (Fn_1, Fn_2, Fn_3, Fn_4, Clr_Disp, Disp_Ctl, Entry_Mode);
signal state, next_state : state_t;

begin


    the_machine: process(next_state)
    begin
    end process the_machine;


    the_registers: process(clock)
    begin
    end process the_registers;

end rtl;