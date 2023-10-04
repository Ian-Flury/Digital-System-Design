library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity tail_light_top is
    port(
        clock_50M   : in std_logic;
        RST_top     : in std_logic;
        clock_out   : out std_logic
    );
end tail_light_top;

architecture structural of tail_light_top is

component counter
    port(
        clock       : in std_logic;
        RST         : in std_logic;
        clock_24    : out std_logic
    );
end component;

begin

    counter_1: counter port map(clock => clock_50M, RST => RST_top, clock_24 => clock_out);

end structural; -- tail_light_top