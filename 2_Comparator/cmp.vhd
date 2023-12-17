-- 
-- author:   Ian Flury
-- file:     cmp.vhd
-- comments: this code implements a 2-bit comparator
--

library ieee;
use ieee.std_logic_1164.all;
use work.all;



entity cmp is port(
    A: in std_logic_vector(1 downto 0);
    B: in std_logic_vector(1 downto 0);

    HEX0: out std_logic_vector(6 downto 0);
    HEX1: out std_logic_vector(6 downto 0);
    HEX2: out std_logic_vector(6 downto 0);
    HEX3: out std_logic_vector(6 downto 0);
    
    AGTB: out std_logic;
    AEQB: out std_logic;
    ALTB: out std_logic
    );

end cmp;

architecture rtl of cmp is
begin
 
  cmp_p: process(A,B)
  begin
  
    if (A = B) then
        AEQB <= '1';
        AGTB <= '0';
        ALTB <= '0';
        HEX0 <= "0000000";
        HEX1 <= "0011000";
        HEX2 <= "0000110";
        HEX3 <= "0001000";
    elsif (A < B) then
        AEQB <= '0';
        AGTB <= '0';
        ALTB <= '1';
        HEX0 <= "0000000";
        HEX1 <= "0000111";
        HEX2 <= "1000111";
        HEX3 <= "0001000";
    else
        AEQB <= '0';
        AGTB <= '1';
        ALTB <= '0';
        HEX0 <= "0000000";
        HEX1 <= "0000111";
        HEX2 <= "0000010";
        HEX3 <= "0001000";
    end if;
  
  end process cmp_p;
    
end rtl;
