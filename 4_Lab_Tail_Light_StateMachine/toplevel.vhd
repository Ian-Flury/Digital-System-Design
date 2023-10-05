library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity tail_light_top is
    port(
        clock_50M   : in std_logic;
        KEY3        : in std_logic;                         -- RST key
        SW          : in std_logic_vector(2 downto 0);
        lights      : out std_logic_vector(5 downto 0);
        clock_out   : out std_logic
    );
end tail_light_top;

architecture structural of tail_light_top is

component counter
    port(
        clock       : in std_logic;
        RST         : in std_logic;
        clock_slow    : out std_logic
    );
end component;

component tailLight
    port(
        clock_slow    : in std_logic;
        RST         : in std_logic;
        switches    : in std_logic_vector(2 downto 0);
        lights      : out std_logic_vector(5 downto 0)
    );
end component;

begin

    counter_1: counter port map(clock => clock_50M, RST => KEY3, clock_slow => clock_out);

    tailLight_1: tailLight port 
    map(
        clock_slow => clock_out,
        RST => KEY3,
        switches => SW,
        lights => lights
    );

end structural; -- tail_light_top