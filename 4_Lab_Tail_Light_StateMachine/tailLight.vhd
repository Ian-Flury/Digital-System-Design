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
        clock_slow  : in std_logic;
        RST         : in std_logic;
        switches    : in std_logic_vector(2 downto 0);
        lights      : out std_logic_vector(5 downto 0)
    );
end tailLight;


architecture rtl of tailLight is 
    type state_t is (off, hazard_zero, hazard_one, right_one, right_two, right_three, left_one, left_two, left_three);
    signal state, next_state : state_t;
    signal lights_state : std_logic_vector(5 downto 0); 
begin

    the_machine: process(switches, state, RST)
        variable l_count : unsigned(2 downto 0);
        variable r_count : unsigned(2 downto 0);
    begin

        if RST = '0' then
            lights_state <= (others => '0');
        else
            case state is
                when off =>
                    lights_state <= (others => '0');
                when hazard_zero =>
                    lights_state <= (others => '0');
                when hazard_one =>
                    lights_state <= (others => '1');
                when right_one =>
                    lights_state <= "000100";
                when right_two =>
                    lights_state <= "000110";
                when right_three =>
                    lights_state <= "000111";
                when left_one =>
                    lights_state <= "001000";
                when left_two =>
                    lights_state <= "011000";
                when left_three =>
                    lights_state <= "111000";
                when others =>
                    -- do nothing
            end case;
        end if;
    end process the_machine;

    lights <= lights_state;

    the_registers: process(clock_slow, RST)
    begin
        if RST = '0' then
            state <= off;
        elsif clock_slow'EVENT and clock_slow = '1' then
            if switches = "000" then
                state <= off;
            elsif switches(0) = '1' then
                -- hazard
                if state /= hazard_one then
                    state <= hazard_one;
                else
                    state <= hazard_zero;
                end if;
            elsif switches(2) = '1' then
                -- left signal
                if state = off then
                    state <= left_one;
                elsif state = left_one then
                    state <= left_two;
                elsif state = left_two then
                    state <= left_three;
                else
                    state <= off;
                end if;
            elsif switches(1) = '1' then
                -- right signals
                if state = off then
                    state <= right_one;
                elsif state = right_one then
                    state <= right_two;
                elsif state = right_two then
                    state <= right_three;
                else
                    state <= off;
                end if;
            end if;
        end if;
    end process the_registers;
end rtl;