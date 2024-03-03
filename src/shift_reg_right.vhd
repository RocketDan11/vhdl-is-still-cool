library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_reg_right is
    Port (
        clk : in STD_LOGIC;
        load : in STD_LOGIC;
        d : in STD_LOGIC_VECTOR(7 downto 0);
        q : out STD_LOGIC  -- Single bit output
    );
end shift_reg_right;

architecture Behavioral of shift_reg_right is
    signal d_temp : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');  -- Temporary storage for shifting
begin
    process(clk)
    begin
        if clk = '1' then
            if load = '1' then
                -- Do not shift; just load initial value if rst is active
                d_temp <= "0000" & d(3 downto 0);
            else
                -- Shift right by 1 bit on each clock cycle when rst is not active
                d_temp <= '0' & d_temp(7 downto 1);  -- Prepend '0' to simulate right shift
            end if;
        end if;
    end process;
    q <= d_temp(0);
end Behavioral;
