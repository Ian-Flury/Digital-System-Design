-- 
-- Authors: Ian Flury, Joey Macauley
-- file: 
-- comments: 
--

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity lcd_top_level_tb is
end lcd_top_level_tb;

architecture tb of lcd_top_level_tb is

    constant period_c   : time := 20 ns;
    signal clock_net    : std_logic;
    signal KEY3_net     : std_logic;
    signal KEY0_net     : std_logic;
    signal LCD_DATA_net : std_logic_vector(7 downto 0);
    signal LCD_EN_net   : std_logic;
    signal LCD_RW_net   : std_logic;
    signal LCD_RS_net   : std_logic;
    signal LCD_ON_net   : std_logic;
    signal LCD_BLON_net : std_logic;

    component lcd_ctrl_top
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
    end component lcd_ctrl_top;

begin

    lcd_top_level_instance: lcd_ctrl_top
    port map(
        clock_50M => clock_net,
        KEY3 => KEY3_net,
        KEY0 => KEY0_net,
        LCD_DATA => LCD_DATA_net,
        LCD_EN => LCD_EN_net,
        LCD_RW => LCD_RW_net,
        LCD_RS => LCD_RS_net,
        LCD_ON => LCD_ON_net,
        LCD_BLON => LCD_BLON_net
    );
    
    tb_clk: process
    begin
        clock_net <= '1';
        wait for period_c;
        clock_net <= '0';
        wait for period_c;
    end process;

    tb_p: process
    begin

        KEY3_net <= '1';
        wait for 20 ns;
        KEY3_net <= '0';

        wait for 2000 ns;

    assert false
    report "End of TestBench"
    severity failure;
    
    end process;
end tb; -- tail_light_top_tb