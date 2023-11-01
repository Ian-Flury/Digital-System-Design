library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity lcd_top_level is
    port(
        clock_50M   : in std_logic;
        KEY3        : in std_logic;
        KEY0        : in std_logic;
        LCD_DATA    : out std_logic_vector(7 downto 0);
        LCD_EN      : out std_logic;
        LCD_RW      : out std_logic;
        LCD_RS      : out std_logic;
        LCD_ON      : out std_logic;
        LCD_BLON    : out std_logic
    );
end lcd_top_level;

architecture structural of lcd_top_level is

    signal two_ms_clk : std_logic;
    signal button_signal : std_logic;
    
    component swdbnc
    port(
        CLK_50M         : in std_logic;
        KEY0  			: in std_logic;
        KEY3			: in std_logic;
        LEDG0 			: out std_logic
   );
    end component;
     
    component counter
        port(
            clock       : in std_logic;
            RST         : in std_logic;
            clock_slow  : out std_logic
        );
    end component;

    component lcd_ctrl
        port(
            clock       	: in std_logic;
            RST         	: in std_logic;
            LCD_DATA    	: out std_logic_vector(7 downto 0);
            LCD_EN      	: out std_logic;
            LCD_RW      	: out std_logic;
            LCD_RS      	: out std_logic;
            LCD_ON      	: out std_logic;
            LCD_BLON    	: out std_logic;
            button_signal   : in std_logic 
        );
    end component;

begin


     debouncer_1: swdbnc port
     map(
         CLK_50M => clock_50M,
         KEY0 => KEY3,
         KEY3 => KEY0,
         LEDG0 => button_signal
     );
     
    counter_1: counter port
    map(
        clock => clock_50M,
        RST => KEY0,
        clock_slow => two_ms_clk
    );

    lcd_ctrl_1: lcd_ctrl port 
    map(
        clock => two_ms_clk,
        RST => KEY0,
        LCD_DATA => LCD_DATA,
        LCD_EN => LCD_EN,
        LCD_RW => LCD_RW,
        LCD_RS => LCD_RS,
        LCD_ON => LCD_ON,
        LCD_BLON => LCD_BLON,
        button_signal => button_signal
    );

end structural;
