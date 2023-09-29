library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity cmp_tb is
end cmp_tb;

architecture tb of cmp_tb is 
    signal A_net, B_net : std_logic_vector(1 downto 0);

    signal LED0_net : std_logic;
    signal LED1_net : std_logic;
    signal LED2_net : std_logic;

    signal HEX0_net : std_logic_vector(6 downto 0);
    signal HEX1_net : std_logic_vector(6 downto 0);
    signal HEX2_net : std_logic_vector(6 downto 0);
    signal HEX3_net : std_logic_vector(6 downto 0);

    component cmp
    port (
        A : in std_logic_vector(1 downto 0);
        B : in std_logic_vector(1 downto 0);

        AGTB : out std_logic;
        AEQB : out std_logic;
        ALTB : out std_logic;

        HEX0 : out std_logic_vector(6 downto 0);
        HEX1 : out std_logic_vector(6 downto 0);
        HEX2 : out std_logic_vector(6 downto 0);
        HEX3 : out std_logic_vector(6 downto 0)
    );
    end component cmp;

begin

    cmp_instance: cmp
    port map(
        A => A_net,
        B => B_net,
        HEX0 => HEX0_net,
        HEX1 => HEX1_net,
        HEX2 => HEX2_net,
        HEX3 => HEX3_net,
        AGTB => LED0_net,
        AEQB => LED1_net,
        ALTB => LED2_net
    );

    tb: process
    begin
        A_net <= "00";
        B_net <= "00";
        wait for 100 ns;

        A_net <= "01";
        B_net <= "00";
        wait for 100 ns;

        A_net <= "00";
        B_net <= "01";
        wait for 100 ns;

        A_net <= "01";
        B_net <= "01";
        wait for 100 ns;

        A_net <= "10";
        B_net <= "00";
        wait for 100 ns;

        A_net <= "00";
        B_net <= "10";
        wait for 100 ns;

        A_net <= "10";
        B_net <= "10";
        wait for 100 ns;

        A_net <= "11";
        B_net <= "00";
        wait for 100 ns;

        A_net <= "00";
        B_net <= "11";
        wait for 100 ns;

        A_net <= "11";
        B_net <= "01";
        wait for 100 ns;

        A_net <= "01";
        B_net <= "11";
        wait for 100 ns;

        A_net <= "11";
        B_net <= "11";
        wait for 100 ns;

        A_net <= "10";
        B_net <= "01";
        wait for 100 ns;

        A_net <= "01";
        B_net <= "10";
        wait for 100 ns;

        A_net <= "10";
        B_net <= "11";
        wait for 100 ns;

        A_net <= "11";
        B_net <= "10";
        wait for 100 ns;

        assert false
        report "End of TestBench"
        severity failure;

    end process tb;
end tb;
