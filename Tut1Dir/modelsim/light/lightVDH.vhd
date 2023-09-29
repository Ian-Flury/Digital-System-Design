library ieee;
use ieee.std_logic_1164.all;
entity light_tb is
end light_tb;

architecture beh of light_tb is
component light
port(
  x1 : in std_logic;
  x2 : in std_logic;
  f  : out std_logic);
end component;

signal x1_sig : std_logic := '0';
signal x2_sig : std_logic := '0';
signal f_sig : std_logic;

begin
--instantiate the component
light_inst: light port map(
x1 => x1_sig,
x2 => x2_sig,
f => f_sig);

-- ALTERA's testbench processes
-- process
--   begin
--   x1_sig <= '0';
--   wait for 20 ns;
--   x1_sig <= '1';
--   wait for 20 ns;
-- end process;

-- process
--   begin
--   x2_sig <= '0';
--   wait for 40 ns;
--   x2_sig <= '1';
--   wait for 20 ns;
-- end process;
-- END of ALTERA's testbench processes

-- Claudio's testbench process
process
  begin
    x1_sig <= '0';
    x2_sig <= '0';
    wait for 20 ns;
    x1_sig <= '0';
    x2_sig <= '1';
    wait for 20 ns;
    x1_sig <= '1';
    x2_sig <= '0';
    wait for 20 ns;
    x1_sig <= '1';
    x2_sig <= '1';
    wait for 40 ns;

    assert false
    report "End of Testbench"
    severity failure;

end process;
-- END Claudio's of testbench process

end beh;
 
