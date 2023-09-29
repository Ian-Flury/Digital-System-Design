library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity hw4_tb is
end hw4_tb;

architecture tb of hw4_tb is 
    constant period_c : time := 20 ns;
    signal GATE_net         : std_logic;
    signal DATA_net         : std_logic;
    signal DATA_OUT_net     : std_logic;
    signal CLK_net          : std_logic;
    
    component hw4
    port (
        CLK         : in std_logic;
        DATA        : in std_logic;
        GATE        : in std_logic;
        DATA_OUT    : out std_logic
    );
    end component hw4;

begin

    hw4_instance: hw4
    port map(
        CLK => CLK_net,
        DATA => DATA_net,
        GATE => GATE_net,
        DATA_OUT => DATA_OUT_net
    );

    tb_clk: process
        begin
            CLK_net <= '1';
            wait for period_c / 2;
            CLK_net <= '0';
            wait for period_c / 2;
    end process tb_clk;

    tb: process
        begin
        GATE_net <= '0';
        DATA_net <= '0';

        wait for 10 ns;
        DATA_net <= '1';
        GATE_net <= '1';

        wait for 15 ns;
        DATA_net <= '0';
        GATE_net <= '0';
        wait for 20 ns;

        GATE_net <= '1';
        wait for 20 ns;

        assert false
        report "End of TestBench"
        severity failure;

    end process tb;
end tb;