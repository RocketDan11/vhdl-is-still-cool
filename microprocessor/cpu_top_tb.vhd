
library ieee;
use ieee.std_logic_1164.all;

entity cpu_top_tb is
-- The testbench entity does not have ports.
end cpu_top_tb;

architecture testbench of cpu_top_tb is
 
  signal clk      : std_logic := '0';
  signal clk50    : std_logic := '0';
  signal reset    : std_logic := '0';
  signal an       : std_logic_vector(3 downto 0);
  signal ca, cb, cc, cd, ce, cf, cg : std_logic;

  -- Clock period constants
  constant clk_period : time := 10 ns;
  constant clk50_period : time := 20 ns;

  -- Component declaration for cpu_top (if you have a separate file)
  component cpu_top
    port(
      clk      : in std_logic;
      clk50    : in std_logic;
      reset    : in std_logic;
      an       : out std_logic_vector(3 downto 0);
      ca       : out std_logic;
      cb       : out std_logic;
      cc       : out std_logic;
      cd       : out std_logic;
      ce       : out std_logic;
      cf       : out std_logic;
      cg       : out std_logic
    );
  end component;

begin
  -- Instantiate the cpu_top component
  uut: cpu_top
    port map (
      clk      => clk,
      clk50    => clk50,
      reset    => reset,
      an       => an,
      ca       => ca,
      cb       => cb,
      cc       => cc,
      cd       => cd,
      ce       => ce,
      cf       => cf,
      cg       => cg
    );

  -- Clock generation process for system clock
  clk_process: process
  begin
      clk <= '1';
      wait for 50ps;
      clk <= '0';
      wait for 50ps;
  end process;

  -- Clock generation process for display clock
  clk50_process: process
  begin
      clk50 <= '1';
      wait for 100ps;
      clk50 <= '0';
      wait for 100ps;
  end process;
end testbench;
