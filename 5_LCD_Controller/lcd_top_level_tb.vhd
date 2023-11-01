-- 
-- Authors: Ian Flury, Joey Macauley
-- file: 
-- comments: 
--
-- Requirements: 
--      there needs to be a TBF file, but no logging or printing
--      "Need to be able to see states change."

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity lcd_top_level_tb is
end lcd_top_level_tb;

architecture beh of lcd_top_level_tb is

    component lcd_top_level
        port(
            clock_50M   : in std_logic;
            KEY3        : in std_logic;
            KEY0        : in std_logic;
            LCD_DATA    : out std_logic_vector(7 downto 0);
            LCD_EN      : out std_logic;
            LCD_RW      : out std_logic;
            LCD_RS      : out std_logic;
            LCD_ON      : out std_logic;
            LCD_BLON    : out std_logic
        );
    end component lcd_top_level;

-- constant declaration:
    constant period_c   : time := 20 ns;
    constant probe_c    : time := 4 ns;     -- probe signals 4 ns before the end of the clock cycle
    constant tb_skew_c  : time := 1 ns;     -- simulated clock skew
    constant severity_c : severity_level:= warning;

-- signal declaration:
    signal ck           : std_logic;
    signal tb_ck        : std_logic;
    signal KEY3_net     : std_logic;
    signal RST_net      : std_logic;
    signal LCD_DATA_net : std_logic_vector(7 downto 0);
    signal LCD_EN_net   : std_logic;
    signal LCD_RW_net   : std_logic;
    signal LCD_RS_net   : std_logic;
    signal LCD_ON_net   : std_logic;
    signal LCD_BLON_net : std_logic;

begin -- beh

-- mapping:
    lcd_top_level_instance: lcd_top_level
    port map(
        clock_50M => ck,
        KEY3 => KEY3_net,
        KEY0 => RST_net,
        LCD_DATA => LCD_DATA_net,
        LCD_EN => LCD_EN_net,
        LCD_RW => LCD_RW_net,
        LCD_RS => LCD_RS_net,
        LCD_ON => LCD_ON_net,
        LCD_BLON => LCD_BLON_net
    );

-- tb clock generator
    tb_clk: process
    begin
        tb_ck <= '1';
        wait for period_c;
        tb_ck <= '0';
        wait for period_c;
    end process;

-- system clock generator
    clock_gen : process (tb_ck)
    begin
        ck <= transport tb_ck after tb_skew_c;
    end process;


    --
    -- the test bench process
    --
    test_bench: process
    -- define testing procedures

    --
    -- wait for the rising edge of tb_ck
    --
    procedure wait_tb_ck(num_cyc : integer := 1) is
    begin
        for i in 1 to num_cyc loop
            wait until tb_ck'EVENT and tb_ck = '1';
        end loop;
    end wait_tb_ck;

    --
    -- wait for the rising edge of ck
    --
    procedure wait_ck(num_cyc : integer := 1) is
    begin
        for i in 1 to num_cyc loop
            wait until ck'EVENT and ck = '1';
        end loop;
    end wait_ck;

    --
    -- initialize all input signals: Don't leave anything floating
    --
    procedure initialize_tb is
    begin
        KEY3_net <= '1';    -- KEY3, the counting key
    end initialize_tb;

    --
    -- reset the tb
    --
    procedure reset_tb is
    begin
        RST_net <= '1';
        wait for 1 ns;
        RST_net <= '0';
        wait for 1 ns;
        RST_net <= '1';
    end reset_tb;

    --
    -- press the button to increment the counter
    --
    procedure button_press is
    begin
        KEY3_net <= '0';
        wait_tb_ck(1);
        KEY3_net <= '1';
    end button_press;

    begin
        initialize_tb;
        reset_tb;

        -- waste some clock time
        wait_tb_ck(100);

        button_press;

        -- waste some clock time
        wait_tb_ck(20);


        assert false
        report "End of Simulation"
        severity failure;
    end process test_bench;

end beh; -- tail_light_top_tb