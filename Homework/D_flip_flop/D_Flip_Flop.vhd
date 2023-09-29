
library ieee;
use ieee.std_logic_1164.all;
use work.all;



entity D_Flip_Flop is 
port(
    CLK : in std_logic;
    Clr : in std_logic;
    Set : in std_logic;
    D   : in std_logic;
    Q   : out std_logic
);
end D_Flip_Flop;

architecture rtl of D_Flip_Flop is
begin

	dff_p: process(CLK, Clr, Set)
	begin
		if Clr = '1' then Q <= '0';
		elsif Set = '1' then Q <= '1';
		elsif CLK'event and CLK = '0' then
			Q <= D;
		end if;
	
	end process dff_p;

end rtl;