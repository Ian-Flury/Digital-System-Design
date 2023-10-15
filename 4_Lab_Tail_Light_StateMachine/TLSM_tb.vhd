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

    constant period_c   : time := 20 ns;
    signal clock_net    : std_logic;
    signal clock_slow   : std_logic;
    signal KEY3_net     : std_logic;
    signal SW_net       : std_logic_vector(2 downto 0);
    signal lights_net   : std_logic_vector(5 downto 0);

    component tail_light_top
        port(
            clock_50M   : in std_logic;
            KEY3        : in std_logic;                         -- RST key
            SW          : in std_logic_vector(2 downto 0);
            lights      : out std_logic_vector(5 downto 0);
            clock_out   : out std_logic
        );
    end component tail_light_top;

begin

    tail_light_top_instance: tail_light_top
    port map(
        clock_50M => clock_net,
        KEY3 => KEY3_net,
        SW => SW_net,
        lights => lights_net,
        clock_out => clock_slow
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
        -- wait for 20 ns;
        -- SW_net <= (others => '0');
        -- KEY3_net <= '1';
        -- wait for 20 ns;
        -- KEY3_net <= '0';
        
        wait for 50 ns;
        SW_net <= "001";


        wait for 800 ns;

    assert false
    report "End of TestBench"
    severity failure;
    
    end process;
end tb; -- tail_light_top_tb