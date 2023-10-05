library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity hw5_tb is
end hw5_tb;

architecture tb of hw5_tb is 
    signal S_net   : std_logic;
    signal R_net   : std_logic;
    signal Q_net   : std_logic;
    signal Q_n_net : std_logic;
component hw5
port (
    S      : in std_logic;
    R      : in std_logic;
    Q      : out std_logic;
    Q_n    : out std_logic
    );
    end component hw5;
    
begin

    hw5_instance: hw5
    port map(
        S => S_net,
        R => R_net,
        Q => Q_net,
        Q_n => Q_n_net
    );

    tb: process
        begin
            S_net <= '0';
            R_net <= '0';
            wait for 50 ns;

            S_net <= '1';
            wait for 50 ns;
            S_net <= '0';

            wait for 50 ns;

            R_net <= '1';
            wait for 50 ns;
            R_net <= '0';

            wait for 50 ns;
            S_net <= '1';
            R_net <= '1';

            wait for 50 ns;

        assert false
        report "End of TestBench"
        severity failure;

    end process tb;
end tb;