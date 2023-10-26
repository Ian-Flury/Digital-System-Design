-- Name: Ian Flury
-- Assignment: HW8, P1 programmable square wave generator.
-- Class: CPEN430 Digital System Design
-- Date: 10/18/2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity serial is 
    port (
        clock : in std_logic;
        RST : in std_logic;
        serial : in std_logic;
        wave_out : out std_logic
    );
end serial;

architecture rtl of serial is 

type state_t is (zero, one, two, three);
signal state, next_state : state_t;

begin

    the_machine: process(state, serial, RST)
    begin
        if RST = '1' then
            next_state <= zero;
            wave_out <= '0';
        else
            case state is
                when zero =>
                    if serial = '1' then
                        next_state <= one;
                    end if;
                when one =>
                    if serial = '1' then
                        next_state <= two;
                    else
                        next_state <= zero;
                    end if;
                when two =>
                    if serial = '1' then
                        next_state <= three;
                    else
                        next_state <= zero;
                    end if;
                when three =>
                    wave_out <= '1';
                    if serial = '0' then
                        wave_out <= '0';
                        next_state <= zero;
                    end if;
                when others =>
            end case;
        end if;
    end process the_machine;

    the_registers: process(clock, RST)
    begin
        if RST = '1' then
            state <= zero;
        elsif clock'EVENT and clock = '1' then
            state <= next_state;
        end if;
    end process the_registers;

end rtl;
