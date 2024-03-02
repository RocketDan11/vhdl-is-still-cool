library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- This library is required for the to_integer function

entity reg is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        d : in STD_LOGIC_VECTOR(7 downto 0);
        q : out STD_LOGIC_VECTOR(7 downto 0)
    );
end reg;

architecture Behavioral of reg is
    signal reg : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            reg <= d;
        end if;
    end process;
    q <= reg;
end Behavioral;
