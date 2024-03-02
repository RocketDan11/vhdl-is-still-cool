
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_adder_tb is
end shift_adder_tb;

architecture Behavioral of shift_adder_tb is
    component shift_adder
        Port (
        clk : in STD_LOGIC;
        load : in STD_LOGIC;
        multiplicand : in STD_LOGIC_VECTOR (7 downto 0);
        partial_product_in : in STD_LOGIC_VECTOR (7 downto 0);
        partial_product_out : out STD_LOGIC_VECTOR (7 downto 0);
        carry_out : out STD_LOGIC);
    end component;

    -- Signals for the test bench
    signal clk : STD_LOGIC := '0';
    signal load : STD_LOGIC := '0';
    signal multiplicand : STD_LOGIC_VECTOR (7 downto 0) := "00001010"; 
    signal partial_product_in : STD_LOGIC_VECTOR (7 downto 0) := "00000000"; 
    signal partial_product_out : STD_LOGIC_VECTOR (7 downto 0);
    signal carry_out : STD_LOGIC;
    
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut : shift_adder
    port map (
        clk => clk,
        load => load,
        multiplicand => multiplicand,
        partial_product_in => partial_product_in,
        partial_product_out => partial_product_out,
        carry_out => carry_out);

    
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    
    stim_proc : process
    begin
        -- Load the initial partial product and multiplicand
        load <= '1';
        partial_product_in <= "00000101";   
        multiplicand <= "00001100";    
        wait for clk_period;

        -- Disable load and start shifting
        load <= '0';
        wait for clk_period * 8; 

        -- Load a new partial product and change multiplicand
        load <= '1';
        partial_product_in <= "00001010"; 
        multiplicand <= "00000101"; 
        wait for clk_period;

        -- Disable load and continue the shifting process
        load <= '0';
        wait for clk_period * 8;
        wait;
    end process;
end Behavioral;
