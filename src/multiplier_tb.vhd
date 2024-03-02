library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier_tb is
-- This is a testbench entity so it doesn't have ports.
end entity multiplier_tb;

architecture Behavioral of multiplier_tb is

    -- Component under test
    component multiplier
        port (
            clk, reset : in STD_LOGIC;
            multiplicand, mult : in STD_LOGIC_VECTOR(7 downto 0);
            product : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Testbench signals
    signal tb_clk, tb_reset : STD_LOGIC := '0';
    signal tb_multiplicand, tb_multiplier : STD_LOGIC_VECTOR(7 downto 0);
    signal tb_product : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate the multiplier
    uut: multiplier
        port map (
            clk => tb_clk,
            reset => tb_reset,
            multiplicand => tb_multiplicand,
            mult => tb_multiplier,
            product => tb_product
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            tb_clk <= '0';
            wait for 10 ns; -- Clock low for 10 ns
            tb_clk <= '1';
            wait for 10 ns; -- Clock high for 10 ns
        end loop;
    end process;

    -- Test stimulus
    stimulus_proc: process
    begin
            -- Apply a reset
        tb_reset <= '1';
        wait for 40 ns; -- Hold reset high for 20 ns
        tb_reset <= '0';
    
        -- Test case a) 1101 x 1010 (Extended to 8 bits)
        tb_multiplicand <= "00001010"; -- Assuming the left-most bits are the most significant
        tb_multiplier <= "00001111";
        wait for 10 ns; 
        wait;
    end process;
end architecture Behavioral;
