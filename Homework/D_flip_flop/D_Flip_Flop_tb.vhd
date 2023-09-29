library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity D_Flip_Flop_tb is
end D_Flip_Flop_tb;

architecture tb of D_Flip_Flop_tb is 
    constant period_c : time := 20 ns;
    signal CLK_net : std_logic := '1';
    signal Clr_net : std_logic := '0';
    signal Set_net : std_logic := '0';
    signal D_net   : std_logic := '1';
    signal Q_net   : std_logic;
    component D_Flip_Flop
    port (
        CLK : in std_logic;
        Clr : in std_logic;
        Set : in std_logic;
        D   : in std_logic;
        Q   : out std_logic
    );
    end component D_Flip_Flop;

begin

    D_Flip_Flop_instance: D_Flip_Flop
    port map(
        CLK => CLK_net,
        Clr => Clr_net,
        Set => Set_net,
        D => D_net,
        Q => Q_net
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

            D_net <= '0';
            wait for period_c;

            D_net <= '1';
            wait for period_c;
            D_net <= '0';

            wait for 2.5 ns;
            Clr_net <= '1';
            wait for 2.5 ns;
            Clr_net <= '0';

            wait for 2.5 ns;
            Set_net <= '1';
            wait for 2.5 ns;
            Set_net <= '0';

        assert false
        report "End of TestBench"
        severity failure;

    end process tb;
end tb;