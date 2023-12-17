library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;

entity counter is 
    port(
        clock       : in std_logic;
        RST         : in std_logic;
        clock_slow    : out std_logic
    );
end counter;

architecture rtl of counter is
    -- 25000000
    constant limit_c : integer := 12000000;
begin

    counter_p: process(clock, RST)
        -- FIX: cannot set to zero right off the gate remove!
        variable count : unsigned(32 downto 0) := (others => '0');
        variable toggle : std_logic := '0';
    begin
        if RST = '0' then
            count := (others => '0');
        elsif clock'EVENT and clock = '1' then
            count := count + 1;
            if count > limit_c then
                -- if the counter's at the limit then reset it.
                count := (others => '0');
                if toggle = '0' then
                    toggle := '1';
                else 
                    toggle := '0';
                end if;
            end if;
        end if;
        clock_slow <= toggle;
        -- 1000000 is represented with 20 bits pick the high bit
    end process;

end rtl ; --counter