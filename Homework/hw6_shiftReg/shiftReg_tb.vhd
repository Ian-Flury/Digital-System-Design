library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity shiftReg_tb is
end shiftReg_tb;

architecture tb of shiftReg_tb is

    constant period_c   : time := 10 ns;
    signal clock_net    : std_logic;
    signal SI_net           : std_logic;
    signal SO_net           : std_logic;
    signal EN_net           : std_logic;

    component shiftReg
        port(
            clock   : in std_logic;
            SI      : in std_logic;
            EN      : in std_logic;
            SO      : out std_logic
        );
    end component shiftReg;

begin 

    shiftReg_instance: shiftReg
    port map(
        clock => clock_net,
        SI => SI_net,
        EN => EN_net,
        SO => SO_net
    );

    tb_clk: process
    begin
        clock_net <= '1';
        wait for period_c / 2;
        clock_net <= '0';
        wait for period_c / 2 ;
    end process tb_clk;

    tb_p: process
    begin
        EN_net <= '1';
        SI_net <= '0';
        wait for 8 * period_c;
        SI_net <= '1';
        wait for 4 * period_c;
        EN_net <= '0';
        wait for 4 * period_c;

        assert false
        report "End of TestBench"
        severity failure;
    
    end process tb_p;

end tb;