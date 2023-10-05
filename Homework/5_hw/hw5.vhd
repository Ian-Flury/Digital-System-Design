	library ieee;
use ieee.std_logic_1164.all;
use work.all;



entity hw5 is 
port(
    S   : in std_logic;
    R   : in std_logic;
    Q   : out std_logic;
    Q_n : out std_logic
);
end hw5;

architecture rtl of hw5 is
    signal Q_sig    : std_logic;
begin

    SR_latch: process(S,R)
    begin
        if (S = '0') and (R = '0') then
            -- S and R both = '0', do nothing. Save state.
            Q_sig <= Q_sig;
        elsif (S = '1') and (R = '0') then
            Q_sig <= '1';
        elsif (S = '0') and (R = '1') then
            Q_sig <= '0';
        else -- S = '1' and R = '1'
            -- Invalid state, do nothing and save state.
            Q_sig <= Q_sig;
        end if;
    end process SR_latch;

    Q <= Q_sig;
    Q_n <= not Q_sig;

    end rtl;