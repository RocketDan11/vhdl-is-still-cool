 library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_left_tb is
end shift_reg_left_tb;

architecture Behavioral of shift_reg_left_tb is
    component shift_reg_left
        Port ( clk   : in STD_LOGIC;
               load  : in STD_LOGIC;
               d     : in STD_LOGIC_VECTOR (7 downto 0);
               q     : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- Inputs
    signal clk  : STD_LOGIC := '0';
    signal load : STD_LOGIC := '0';
    signal d    : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

    -- Outputs
    signal q_temp : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

    -- Clock period definitions
    constant clk_period : time := 20 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: shift_reg_left
        port map ( clk   => clk,
                   load  => load,
                   d     => d,
                   q     => q_temp
                 );

    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Load the initial value
        load <= '1';
        d    <= "00001111";
        wait for clk_period;
        

       
        load <= '0';
        wait for clk_period * 8;
        

       
        --load <= '1';
        --d    <= "00001010";
        --wait for clk_period;
        

        
        --load <= '0';
        --wait for clk_period * 8;
        

        -- End the simulation
        wait;
    end process;
end Behavioral;