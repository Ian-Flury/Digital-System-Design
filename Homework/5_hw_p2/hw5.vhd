library ieee;
use ieee.std_logic_1164.all;
use work.all;



entity hw5 is 
port(
    Clr, Clk, CE, C, A, B: in std_logic;
    Q: out std_logic
);
end hw5;

architecture rtl of hw5 is
begin

    process(Clk, Clr)
    begin
        if Clr = '1' then Q <= '0';
        elsif Clk'EVENT and Clk = '0' and CE = '1' then
            if C = '0' then Q <= A and B;
            else Q <= A or B; end if;
        end if;
    end process;

end rtl;