-- 
-- Authors: Ian Flury, Joey Macauley
-- file: swdbnc_tb.vhd
-- comments: This code implements a basic TestBench for the 
--           switch debouncer circuit defined in swdbnc.vhd
--

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity swdbnc_tb is
end swdbnc_tb;

architecture tb of swdbnc_tb is 
    constant period_c : time := 10 ns;
    
    signal CLK_50M_net  : std_logic;
    signal KEY0_net     : std_logic;
    signal KEY3_net     : std_logic;
    signal LEDG0_net    : std_logic;

    component swdbnc
    port (
        CLK_50M     : in std_logic;	 
        KEY0        : in std_logic;
        KEY3        : in std_logic;    
        LEDG0       : out std_logic
    ); 
    end component swdbnc;

begin

    swdbnc_instance: swdbnc
    port map(
        CLK_50M => CLK_50M_net,
        KEY0    => KEY0_net,
        KEY3    => KEY3_net,
        LEDG0   => LEDG0_net
    );

    tb_clk: process
        begin
            CLK_50M_net <= '1';
            wait for period_c / 2;
            CLK_50M_net <= '0';
            wait for period_c / 2;
    end process tb_clk;

    tb: process
        begin
            -- setup signals
            KEY0_net <= '1';
            
            -- do a reset
            KEY3_net <= '0';
            wait for 50 ns;
            KEY3_net <= '1';
            wait for 25 ns;
            
            -- first button press
            KEY0_net <= '1';
            wait for 50 ns;
            KEY0_net <= '0';
            wait for 50 ns;
            KEY0_net <= '1';

            wait for 350 ns;

            -- second button press
            KEY0_net <= '0';
            wait for 50 ns;
            KEY0_net <= '1';

            wait for 350 ns;

        assert false
        report "End of TestBench"
        severity failure;

    end process tb;
end tb;