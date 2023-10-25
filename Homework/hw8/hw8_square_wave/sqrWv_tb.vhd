library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity sqrWv_tb is
end sqrWv_tb;

architecture tb of sqrWv_tb is

    constant period_c   : time := 10 ns;
    signal clock_net    : std_logic;
    signal RST_net : std_logic;
    signal H_net : std_logic_vector(3 downto 0);
    signal L_net : std_logic_vector(3 downto 0);
    signal wave_out_net : std_logic;

    component sqrWv 
        port (
            clock : in std_logic;
            RST : in std_logic;
            H : in std_logic_vector(3 downto 0);
            L : in std_logic_vector(3 downto 0);
            wave_out : out std_logic
        );
    end component sqrWv;


begin 

    sqrWv_instance: sqrWv
    port map(
        clock => clock_net,
        RST => RST_net,
        H => H_net,
        L => L_net,
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

        H_net <= "0011";
        L_net <= "0011";
        RST_net <= '1';
        wait for 4 * period_c;
        RST_net <= '0';

        wait for 1600 ns;

        assert false
        report "End of TestBench"
        severity failure;
    
    end process tb_p;

end tb;