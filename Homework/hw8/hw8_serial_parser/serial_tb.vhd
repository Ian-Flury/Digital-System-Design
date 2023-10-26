library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity serial_tb is
end serial_tb;

architecture tb of serial_tb is

    constant period_c   : time := 10 ns;
    signal clock_net    : std_logic;
    signal RST_net : std_logic;
    signal serial_net : std_logic;
    signal wave_out_net : std_logic;

    component serial 
        port (
            clock : in std_logic;
            RST : in std_logic;
            serial : in std_logic;
            wave_out : out std_logic
        );
    end component serial;


begin 

    serial_instance: serial
    port map(
        clock => clock_net,
        RST => RST_net,
        serial => serial_net,
        wave_out => wave_out_net
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
        serial_net <= '0';
        RST_net <= '1';
        wait for 4 * period_c;
        RST_net <= '0';

        wait for period_c;

        serial_net <= '1';
        wait for 4 * period_c;

        serial_net <= '0';
        wait for 2 * period_c;

        serial_net <= '1';
        wait for 2 * period_c;

        serial_net <= '1';
        wait for 3 * period_c;

        serial_net <= '0';
        wait for 5 * period_c;

        assert false
        report "End of TestBench"
        severity failure;
    
    end process tb_p;

end tb;