library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_reg_left is
    Port (
        clk : in STD_LOGIC;
        load : in STD_LOGIC;
        d : in STD_LOGIC_VECTOR(7 downto 0); 
        q : out STD_LOGIC_VECTOR(7 downto 0)
    );
end shift_reg_left;

architecture Behavioral of shift_reg_left is
    signal d_temp : STD_LOGIC_VECTOR(7 downto 0);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if load = '1' then
                d_temp <= d(7 downto 0);
                d_temp <= d;
            else
               -- Shift data on subsequent clock cycles
               d_temp <= d_temp(6 downto 0) & '0';
            end if;
        end if;
    end process;
        q <= d_temp;
end Behavioral;
