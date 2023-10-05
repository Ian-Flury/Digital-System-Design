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
        clock_slow    : in std_logic;
        RST         : in std_logic;
        switches    : in std_logic_vector(2 downto 0);
        lights      : out std_logic_vector(5 downto 0)
    );
end tailLight;


architecture rtl of tailLight is 
    type state_t is (off, left, right, hazard);
    signal state, next_state : state_t;
    signal lights_state : std_logic_vector(5 downto 0);

constant lights_on : unsigned(5 downto 0) := (others => '1');
    constant lights_off : unsigned(5 downto 0) := (others => '0');
    signal toggle : std_logic;

begin

    the_machine: process(SW, state, RST)
    begin

    end process the_machine;

    the_registers: process(clock_slow, RST)
        if RST = '1' then
            state <= off;
        elsif clock_slow'EVENT and clock_slow = '1' then
            state <= next_state;
        end if;
    end process the_registers;

    -- process(clock_slow)
    -- begin
    --     if RST = '1' then
    --         lights <= (others => '0');
    --     elsif clock_slow'EVENT and clock_slow = '1' then
    --         if toggle = '1' then
    --             lights <= lights_on;
    --         else
    --             lights <= lights_off;
    --         end if;
    --     end if;
    -- end process;

end rtl;