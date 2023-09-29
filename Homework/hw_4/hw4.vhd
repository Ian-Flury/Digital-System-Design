library ieee;
use ieee.std_logic_1164.all;
use work.all;



entity hw4 is 
port(
    GATE 		: in std_logic;
    DATA 		: in std_logic;
    CLK 		: in std_logic;
    DATA_OUT    : out std_logic
);
end hw4;

architecture rtl of hw4 is
    signal Q   : std_logic;
    signal D   : std_logic;
begin

    dff_p: process(CLK)
    begin
        if CLK'event and CLK = '1' then
            Q <= D;
        end if;
    
    end process dff_p;

    combinational_p: process(GATE, DATA, Q)
    begin
            if GATE = '1' then
                D <= DATA;
            else
                D <= Q;
            end if;
        
    end process combinational_p;
    
    DATA_OUT <= Q;
    
end rtl;