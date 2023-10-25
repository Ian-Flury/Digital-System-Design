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
type state_t is (Fn_1, Fn_2, Fn_3, Fn_4, Clr_Disp, Disp_Ctl, Entry_Mode, Set_Address, Write_Data, Ret_Home);

signal state, next_state : state_t;

begin


    the_machine: process(state, RST)
    begin
        if RST = '0' then
            next_state <= Fn_1;
            LCD_DATA <= (others => '0');
            LCD_RW <= '0';
            LCD_RS <= '0';
            LCD_ON <= '0';
            LCD_BLON <= '0';
        else
				LCD_ON <= '1';
				LCD_BLON <= '0';
				case state is
                when Fn_1 =>
                    -- turn on power
                    LCD_DATA <= "00110000";
                    LCD_RS <= '0';
                    LCD_RW <= '0';
						  next_state <= Fn_2;
                when Fn_2 =>
                    -- wait 
						  LCD_DATA <= "00110000";
                    LCD_RS <= '0';
                    LCD_RW <= '0';
                    next_state <= Fn_3;
                when Fn_3 =>
						  LCD_DATA <= "00110000";
                    LCD_RS <= '0';
                    LCD_RW <= '0';
                    next_state <= Fn_4;
                when Fn_4 =>
                    LCD_DATA <= "00111000";
                    LCD_RS <= '0';
                    LCD_RW <= '0';
                    next_state <= Clr_Disp;
                when Clr_Disp =>
						  LCD_DATA <= "00000001";
                    LCD_RS <= '0';
                    LCD_RW <= '0';
						  next_state <= Disp_Ctl;
					 when Disp_Ctl =>
                    LCD_DATA <= "00001100";
                    LCD_RS <= '0';
                    LCD_RW <= '0';
                    next_state <= Entry_Mode;
                when Entry_Mode =>
						  LCD_DATA <= "00000110";
                    LCD_RS <= '0';
                    LCD_RW <= '0';
                    next_state <= Set_Address;
                when Set_Address =>
						  LCD_DATA <= (others => '0');
						  LCD_RS <= '0';
						  LCD_RW <= '0';
						  
						  next_state <= Write_Data;
                when Write_Data =>
						  LCD_DATA <= "01010110"; --V
						  LCD_RS <= '1';
						  LCD_RW <= '0';
						  next_state <= Set_Address;
					 when Ret_Home =>
						  LCD_DATA <= (others => '0');
						  LCD_RS <= '0';
						  LCD_RW <= '0';
					 when others =>
                    -- Do nothing
            end case;

        end if;
    end process the_machine;
	
    LCD_EN <= clock;

    the_registers: process(clock, RST)
    begin
        if RST = '0' then
            state <= Fn_1;
        elsif clock'EVENT and clock = '1' then
            state <= next_state;
        end if;
    end process the_registers;

end rtl;