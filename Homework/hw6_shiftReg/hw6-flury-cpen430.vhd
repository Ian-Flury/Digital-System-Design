-- Name: Ian Flury
-- Assignment: HW6
-- Class: CPEN430 Digital System Design
-- Date: 10/18/2023

-- -------- Problem 1 --------
-- Write a VHDL Module that describes a 16-bit serial-in, serial-out shift register 
-- with inputs SI (serial input), EN (enable), and CK (clock, shifts on rising edge),
-- and SO (serial output)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity shiftReg is 
    port (
        clock   : in std_logic;
        SI      : in std_logic;
        EN      : in std_logic;
        SO      : out std_logic
    );
end shiftReg;

architecture rtl of shiftReg is 

    signal reg : std_logic_vector(15 downto 0);

begin

    process(clock)
    begin
        if (clock'EVENT and clock = '1') and (EN = '1') then
            -- shift
            for i in reg'high downto reg'low + 1 loop
                reg(i) <= reg(i-1);
            end loop;
            SO <= reg(reg'high);
            reg(reg'low) <= SI;
        end if;
    end process;

end rtl;