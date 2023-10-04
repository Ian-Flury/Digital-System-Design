-- 
-- Authors: Ian Flury, Joey Macauley
-- file: 
-- comments: 
--

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity tail_light_top_tb is
end tail_light_top_tb;

architecture tb of tail_light_top_tb is

    constant period_c : time := 20 ns;

    signal clock_net    : std_logic;
    signal clock_24_net : std_logic;
    signal RST_top_net  : std_logic;

    component tail_light_top
        port(
            clock_50M   : in std_logic;
            RST_top     : in std_logic;
            clock_out   : out std_logic
        );
    end component tail_light_top;

begin

    tail_light_top_instance: tail_light_top
    port map(
        clock_50M => clock_net,
        RST_top => RST_top_net,
        clock_out => clock_24_net
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
        RST_top_net <= '1' after 20 ns;
        RST_top_net <= '0';

        wait for 500 ns;

    assert false
    report "End of TestBench"
    severity failure;
    
    end process;
end tb; -- tail_light_top_tb