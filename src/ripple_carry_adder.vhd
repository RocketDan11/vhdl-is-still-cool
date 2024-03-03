----------------------------------------------------------------------------------
-- Company: 


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_carry_adder is
Port (
A : in STD_LOGIC_VECTOR (3 downto 0);
B : in STD_LOGIC_VECTOR (3 downto 0);
Cin : in STD_LOGIC;
Sum : out STD_LOGIC_VECTOR (3 downto 0);
Cout : out STD_LOGIC
);
end ripple_carry_adder;
architecture Behavioral of ripple_carry_adder is
signal C1, C2, C3: STD_LOGIC;
begin
-- Instantiate Full Adders
FA0: entity work.full_adder
Port Map (
A => A(0),
B => B(0),
Cin => Cin,
Sum => Sum(0),
Cout => C1
);
FA1: entity work.full_adder
Port Map (
A => A(1),
B => B(1),
Cin => C1,
Sum => Sum(1),
Cout => C2
);
FA2: entity work.full_adder
Port Map (
A => A(2),
B => B(2),
Cin => C2,
Sum => Sum(2),
Cout => C3
);
FA3: entity work.full_adder
Port Map (
A => A(3),
B => B(3),
Cin => C3,
Sum => Sum(3),
Cout => Cout
);
end Behavioral;
