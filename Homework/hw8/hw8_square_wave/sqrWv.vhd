-- Name: Ian Flury
-- Assignment: HW8, P1 programmable square wave generator.
-- Class: CPEN430 Digital System Design
-- Date: 10/18/2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;


entity sqrWv is 
    port (
        clock : in std_logic;
        RST : in std_logic;
        H : in std_logic_vector(3 downto 0);
        L : in std_logic_vector(3 downto 0);
        wave_out : out std_logic
    );
end sqrWv;

architecture rtl of sqrWv is 

    signal slow_clock : std_logic;
    signal high_state : std_logic;

begin

    clock_100ns_period: process(clock)
        variable clk_cntr : unsigned(3 downto 0);
        begin
        if RST = '1' then
            clk_cntr := (others => '0');
            slow_clock <= '0';
        elsif clock'EVENT and clock = '1' then
            clk_cntr := clk_cntr + 1;
            if clk_cntr > 4 then
                clk_cntr := (others => '0');
                slow_clock <= not slow_clock;
            end if;
        end if;
    end process clock_100ns_period;

    logic: process(slow_clock)
        variable counter : unsigned(3 downto 0);
        variable down : unsigned(3 downto 0);
        variable up : unsigned(3 downto 0);
    
    begin
        if RST = '1' then
            counter := (others => '0');
            down := (others => '0');
            up := (others => '0');
        else
            if slow_clock'EVENT and slow_clock = '1' then
                if high_state = '1' then
                    if up = 0 then
                        high_state <= '0';
                        up := unsigned(H);
                        wave_out <= '0';
                    else
                        up := up - 1;
                        wave_out <= '1';
                    end if;
                else
                    if down = 0 then
                        high_state <= '1';
                        down := unsigned(L);
                        wave_out <= '1';
                    else
                        down := down - 1;
                        wave_out <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process logic;

end rtl;
