-- 
-- Authors: Ian Flury, Joey Macauley
-- file: TLSM.vhd
-- comments: this code is a finite state machine that implements the tail-lights 
--           of a 1965 Ford Thunderbird on an Altera Cyclone family FPGA.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity tailLight is 
    port (
        clock_24 : in std_logic;
        lights   : out std_logic_vector(5 downto 0)
    );
end tailLight;


architecture rtl of tailLight is 
    constant lights_on : unsigned(5 downto 0) := (others => '1');
    constant lights_off : unsigned(5 downto 0) := (others => '0');
    signal toggle : std_logic;

begin

    process(clock_24)
    begin
        if clock_24'EVENT and clock_24 = '1' then
            if toggle = '1' then
                lights <= lights_on;
            else
                lights <= lights_off;
            end if;
        end if;
    end process;

end rtl;