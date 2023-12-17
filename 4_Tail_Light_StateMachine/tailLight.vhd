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
    type state_t is (off, hazard_one, hazard_two, hazard_three, right_one, right_two, right_three, left_one, left_two, left_three);
    signal state, next_state : state_t;
    signal lights_state : std_logic_vector(5 downto 0); 
begin

    the_machine: process(switches, state, RST)
        variable l_count : unsigned(2 downto 0);
        variable r_count : unsigned(2 downto 0);
    begin

        if RST = '0' then
            lights_state <= (others => '0');
            next_state <= off;
        else
            case state is
                when off =>
                    lights_state <= (others => '0');
                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= hazard_one;
                    elsif switches(2) = '1' then
                        next_state <= left_one;
                    else
                        next_state <= right_one;
                    end if;
                when hazard_one =>
                    lights_state <= "001100";
                    
                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= hazard_two;
                    elsif switches(2) = '1' then
                        next_state <= off;
                    else
                        next_state <= off;
                    end if;

                when hazard_two =>
                    lights_state <= "011110";

                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= hazard_three;
                    elsif switches(2) = '1' then
                        next_state <= off;
                    else
                        next_state <= off;
                    end if;

                when hazard_three =>
                    lights_state <= "111111";

                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= off;
                    elsif switches(2) = '1' then
                        next_state <= off;
                    else
                        next_state <= off;
                    end if;

                when right_one =>
                    lights_state <= "000100";

                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= off;
                    elsif switches(2) = '1' then
                        next_state <= off;
                    else
                        next_state <= right_two;
                    end if;

                when right_two =>
                    lights_state <= "000110";

                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= off;
                    elsif switches(2) = '1' then
                        next_state <= off;
                    else
                        next_state <= right_three;
                    end if;

                when right_three =>
                    lights_state <= "000111";

                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= off;
                    elsif switches(2) = '1' then
                        next_state <= off;
                    else
                        next_state <= off;
                    end if;

                when left_one =>
                    lights_state <= "001000";

                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= off;
                    elsif switches(2) = '1' then
                        next_state <= left_two;
                    else
                        next_state <= off;
                    end if;

                when left_two =>
                    lights_state <= "011000";
                    
                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= off;
                    elsif switches(2) = '1' then
                        next_state <= left_three;
                    else
                        next_state <= off;
                    end if;

                when left_three =>
                    lights_state <= "111000";

                    if switches = "000" then
                        next_state <= off;
                    elsif switches(0) = '1' then
                        next_state <= off;
                    elsif switches(2) = '1' then
                        next_state <= off;
                    else
                        next_state <= off;
                    end if;

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
            state <= next_state;
        end if;
    end process the_registers;
end rtl;