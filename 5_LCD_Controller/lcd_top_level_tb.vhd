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

    component lcd_ctrl_top
        port(
            clock_50M   : in std_logic;
            KEY3        : in std_logic
        );
    end component lcd_ctrl_top;

begin

    lcd_ctrl_top_instance: lcd_ctrl_top
    port map(
        clock_50M => clock_net,
        KEY3 => KEY3_net
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
    
    
        KEY3_net <= '0';


    assert false
    report "End of TestBench"
    severity failure;
    
    end process;
end tb; -- tail_light_top_tb