-- 
-- author:   Claudio Talarico
-- file:     mux-tb.vhdl
-- comments: very basic tb for 2:1 mux
--

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity mux_tb is
end mux_tb;

architecture beh of mux_tb is

  -- signal and variable declaration
  signal a : std_logic;
  signal b : std_logic;
  signal s : std_logic;
  signal z : std_logic;

  component mux
    port ( a : in  std_logic;
           b : in  std_logic;
           s : in  std_logic;
           z : out std_logic);
  end component mux;

begin
 
  mux_instance: mux
  port map (
    a => a,
    b => b,
    s => s,
    z => z );
  
  tb: process
  begin

    a <= '0';
    b <= '0';
    s <= '0';
    wait for 100 ns;
 
    a <= '0';
    b <= '0';
    s <= '1';
    wait for 100 ns;

    a <= '0';
    b <= '1';
    s <= '0';
    wait for 100 ns;

    a <= '0';
    b <= '1';
    s <= '1';
    wait for 100 ns;
	 
    a <= '1';
    b <= '0';
    s <= '0';
    wait for 100 ns;
 
    a <= '1';
    b <= '0';
    s <= '1';
    wait for 100 ns;

    a <= '1';
    b <= '1';
    s <= '0';
    wait for 100 ns;

    a <= '1';
    b <= '1';
    s <= '1';
    wait for 100 ns;
	 
    assert false
    report "End of TestBench"
    severity failure;

  end process tb;
    
end architecture beh;

