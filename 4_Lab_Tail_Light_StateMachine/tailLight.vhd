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
    type state_t is (off, left, right, hazard);
    signal state, next_state : state_t;
    signal lights_state : std_logic_vector(5 downto 0); 
begin

    the_machine: process(SW, state, RST)
        variable l_count : unsigned(2 downto 0);
        variable r_count : unsigned(2 downto 0);
    begin

        if RST = '1' then
            next_state <= off;
            lights <= (others => '0');
        else

        case state is
            when off => -- lights are off
            when left =>
            when right =>
            when hazard =>
                
                -- change lights accordingly.
                lights_state <= not lights_state;
                
                -- determine next state.
                if switches = '000' then
                    next_state <= off;
                elsif switches(0) = '1'
                    next_state <= hazard;
                elsif switches = '010' then
                    next_state <= right;
                else -- switches(2) = '1' and switches(0) = '0' then
                    next_state <= left;
                end if;

            when others =>
                -- do nothing
        end case;
        end if;
    end process the_machine;

    -- lights <= lights_state;

    the_registers: process(clock_slow, RST)
        if RST = '1' then
            state <= off;
        elsif clock_slow'EVENT and clock_slow = '1' then
            state <= next_state;
        end if;
    end process the_registers;

end rtl;