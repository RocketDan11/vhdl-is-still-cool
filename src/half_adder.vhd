

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity half_adder is
Port (
A : in std_logic;
B : in std_logic;
Sum : out std_logic;
Cout : out std_logic
);
end half_adder;
architecture Structural of half_adder is
begin
-- sum is xor of input bits and carry bits
sum <= a xor b;
-- carry out is generated if there are at least two 1s among a, b, and cin
cout <= (a and b);
end Structural;
