
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
    Port (
        input0 : in STD_LOGIC_VECTOR(7 downto 0);
        input1 : in STD_LOGIC_VECTOR(7 downto 0);
        sel : in STD_LOGIC;
        output : out STD_LOGIC_VECTOR(7 downto 0)
    );
end mux;

architecture Behavioral of mux is
begin
    output <= input0 when sel = '0' else
              input1;
end Behavioral;

