library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity lcd_ctrl_top is
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
end lcd_ctrl_top;

architecture structural of lcd_ctrl_top is

    signal two_ms_clk : std_logic;

    component counter
        port(
            clock       : in std_logic;
            RST         : in std_logic;
            clock_slow  : out std_logic
        );
    end component;

    component lcd_ctrl
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
    end component;

begin

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
        LCD_BLON => LCD_BLON
    );


end structural;