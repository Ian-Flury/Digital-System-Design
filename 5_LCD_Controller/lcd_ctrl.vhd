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
type state_t is (Fn_1, Fn_2, Fn_3, Fn_4, 
						Clr_Disp, Disp_Ctl, Entry_Mode, Set_Address_V,
						V, H, Set_Address_D, D, L, 
						num_address, number, Ret_Home);

signal state, next_state : state_t;

begin


    the_machine: process(state, RST)
		  variable num : unsigned(3 downto 0);
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
                    next_state <= Set_Address_V;
                when Set_Address_V =>
						  LCD_DATA <= "10000000";
						  LCD_RS <= '0';
						  LCD_RW <= '0';
						  next_state <= V;
                when V =>
						  LCD_DATA <= "01010110"; --V
						  LCD_RS <= '1';
						  LCD_RW <= '0';
						  next_state <= H;
					 when H =>
						  LCD_DATA <= "01001000"; --H
						  LCD_RS <= '1';
						  LCD_RW <= '0';
						  next_state <= Set_Address_D;
					 when Set_Address_D =>
						  LCD_DATA <= "11000010";
						  LCD_RS <= '0';
						  LCD_RW <= '0';
						  next_state <= D;
					 when D =>
						  LCD_DATA <= "01000100";
						  LCD_RS <= '1';
						  LCD_RW <= '0';
						  next_state <= L;
					 when L =>
						  LCD_DATA <= "01001100";
						  LCD_RS <= '1';
						  LCD_RW <= '0';
						  next_state <= num_address;
					 when num_address =>
						  LCD_DATA <= "11001111";
						  LCD_RS <= '0';
						  LCD_RW <= '0';
						  next_state <= number;
					 when number =>
						  LCD_DATA <= "00110000";
						  LCD_RS <= '1';
						  LCD_RW <= '0';
						  next_state <= num_address;
					 when Ret_Home =>
						  LCD_DATA <= (others => '0');
						  LCD_RS <= '0';
						  LCD_RW <= '0';
						-- num add: "11001111"
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