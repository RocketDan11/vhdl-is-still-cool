library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity clock_24 is
          Port ( clk: in std_logic;
                second_7seg_1: out std_logic_Vector(6 downto 0);
                second_7seg_2: out std_logic_Vector(6 downto 0);
                minute_7seg_1: out std_logic_Vector(6 downto 0);
                minute_7seg_2: out std_logic_Vector(6 downto 0);
                hour_7seg_1: out std_logic_Vector(6 downto 0);
                hour_7seg_2: out std_logic_Vector(6 downto 0)); --1hz);
end clock_24;

architecture Behavioral of clock_24 is

component disp_6 is
  Port (
        clk:    in std_logic ;
        disp_in:    in std_logic_vector(23 downto 0 );
        an:     out std_logic_vector( 5 downto 0 );
        CA,CB,CC,CD,CE,CF,CG: out std_logic);
end component;

begin



end Behavioral;

