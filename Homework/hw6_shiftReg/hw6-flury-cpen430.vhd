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
            reg(reg'low) <= SI;
        end if;
    end process;
	SO <= reg(reg'high);
end rtl;

-- -------- Problem 2 --------
-- (a) Explain why a latch would be created when the code is synthesized.
--      - A latch would be created because the "if" statement do not have an "else" case.
--        This means that we are no specifying what should happen with every possible 
--        combination of inputs.
--        For example, if state = 0 and X = 1, we go to state 1, then if X still = 1,
--        we haven't defined what should happen with an else condition, and we infer a
--        a latch.
-- (b) What signal would appear at the latch output?
--      - nextstate would be latched at the output.
-- (c) Make changes in the code which would eliminate the latch.
--      - Inside of the else statements, we define that the state should stay at the current
--        until the condition for moving on is met. The functionality of the logic 
--        would be the same without these statement, but I have chosen to include them for
--        clarity.
process(state, X)
begin
    case state is
        when 0 => 
            if X = '1' then 
                nextstate <= 1;
            else
                nextstate <= 0;
            end if;
        when 1 =>
            if X = '0' then 
                nextstate <= 2;
            else
                nextstate <= 1;
            end if;
        when 2 =>
            if X = '1' then
                nextstate <= 0;
            else
                nextstate <= 2;
            end if;
        when others =>
            nextstate <= 0;
    end case;
end process;

-- -------- Problem 3 --------
-- What is wrong with the following model of a 4-1 mux? (not a syntax problem)
-- - The signal "sel" in the architecture needs to be made a variable inside of the process
--   so it can be re-asigned inside of the process.
