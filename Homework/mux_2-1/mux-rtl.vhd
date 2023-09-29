-- 
-- author:   Claudio Talarico
-- file:     mux-rtl.vhdl
-- comments: this code implements a 2:1 mux
--

library ieee;
use ieee.std_logic_1164.all;

entity mux is
port ( a : in  std_logic;
       b : in  std_logic;
       s : in  std_logic;
       z : out std_logic
     );

end mux;

architecture rtl of mux is
begin
 
  mux_p: process(a,b,s)
  begin
    if(s='0') then
      z <= a;
    else
      z <= b;
    end if;
  end process mux_p;
    
end rtl;
