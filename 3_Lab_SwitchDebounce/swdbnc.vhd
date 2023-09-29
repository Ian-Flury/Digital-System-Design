-- 
-- Authors: Ian Flury, Joey Macauley
-- file: swdbnc.vhd
-- comments: this code implements a hardware button/switch swdbnc.
--           CLK = 50MHz -> period of 20 ns
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.all;

-- 2,500,000 clock cycles is 50ms
-- Note: you cannot initialize anything in hardware.
-- instead you should add a RST to the counter to set
-- it to zero and start counting from there.



entity swdbnc is port(
    CLK_50M         : in std_logic;
    KEY0  			: in std_logic;
    KEY3			: in std_logic;
    LEDG0 			: out std_logic
    );
end swdbnc;
     
architecture rtl of swdbnc is
    
     constant LIMIT_c : integer := 10;
     signal ENAB1		 : std_logic;
     signal ENAB2 		 : std_logic;
     signal RST			 : std_logic;
     signal LED_FLAG     : std_logic;
     signal led_flag_off : std_logic;
     signal rst_state	 : std_logic;
     
     signal prev_state : std_logic;
     signal cur_state : std_logic;
     signal led_state : std_logic;

begin

    pressed_p: process(CLK_50M)
    begin
        if CLK_50M'EVENT and CLK_50M = '1' then
            if (KEY0 <= '0') and (prev_state = '1') then
                ENAB1 <= '1';
                prev_state <= KEY0;
                else
                prev_state <= KEY0;
            end if;
        else
        end if;
    end process;


    timer1: process(CLK_50M)
        variable count1 : unsigned(21 downto 0);
    begin
        if CLK_50M'EVENT and CLK_50M = '1' then
            if RST = '1' then
                count1 := (others => '0');
            elsif rst_state = '1' then
                count1 := (others => '0');
            elsif ENAB1 = '1' then
                count1 := count1 + 1;
                if count1 > LIMIT_c then
                    ENAB2 <= '1';
                else
                    
                end if;
            else
            end if;
        else
        end if;
    end process;
    
    
    timer2_p: process(CLK_50M)
        variable count2 : unsigned(21 downto 0);
    begin
        if CLK_50M'EVENT and CLK_50M = '1' then
            if RST = '1' then
                count2 := (others => '0');
            elsif led_flag_off = '1' then
                LED_FLAG <= '0';
            elsif rst_state = '1' then
                count2 := (others => '0');
            elsif ENAB2 = '1' then
                count2 := count2 + 1;
                if count2 > LIMIT_c then
                    LED_FLAG <= '1';
                    led_flag_off <= '1';
                else
                    
                end if;
            else
            end if;
        else
        end if;
    end process;

    led_p: process(CLK_50M)
    begin
        if CLK_50M'EVENT and CLK_50M = '1' then
            if RST = '1' then
                led_state <= '0';
                LEDG0 <= '0';
            elsif LED_FLAG = '1' then
                if KEY0 = '1' then
                    led_state <= not led_state;
                    rst_state <= '1';
                else
                end if;
            else
            end if;
        else
        end if;
        LEDG0 <= led_state;
    end process;


    reset_p: process(CLK_50M)
    begin
        -- need to set previous state back to 1 to make the first process to work
        if CLK_50M'EVENT and CLK_50M = '1' then
            if KEY3 = '0' then 
                RST <= '1';
            else
                RST <= '0';
            end if;
        else
        end if;
    end process;

end rtl;



