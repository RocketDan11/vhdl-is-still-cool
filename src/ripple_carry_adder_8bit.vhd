
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ripple_carry_adder_8bit is
    Port (
        A    : in STD_LOGIC_VECTOR (7 downto 0);
        B    : in STD_LOGIC_VECTOR (7 downto 0);
        Cin  : in STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR (7 downto 0);
        Cout : out STD_LOGIC
    );
end ripple_carry_adder_8bit;

architecture Behavioral of ripple_carry_adder_8bit is
    signal C4: STD_LOGIC; -- Intermediate carry
begin
    -- Lower 4 bits
    RCA_Lower: entity work.ripple_carry_adder
    Port Map (
        A   => A(3 downto 0),
        B   => B(3 downto 0),
        Cin => Cin,
        Sum => Sum(3 downto 0),
        Cout=> C4
    );

    -- Upper 4 bits
    RCA_Upper: entity work.ripple_carry_adder
    Port Map (
        A   => A(7 downto 4),
        B   => B(7 downto 4),
        Cin => C4,
        Sum => Sum(7 downto 4),
        Cout=> Cout
    );
end Behavioral;
