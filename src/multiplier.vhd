library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
    port (
        clk, reset : in STD_LOGIC;
        multiplicand, mult : in STD_LOGIC_VECTOR(7 downto 0);
        product : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity multiplier;

architecture mixed of multiplier is
    signal partial_product, full_product : STD_LOGIC_VECTOR(7 downto 0);
    signal arith_control, result_en, mult_load : STD_LOGIC;
    signal mult_bit : STD_LOGIC; -- Assuming 8-bit right shift register
    signal product_integer : STD_LOGIC_VECTOR(7 downto 0); -- To hold the converted product

    component shift_adder
        port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            multiplicand : in STD_LOGIC_VECTOR(7 downto 0);
            add_enable : in STD_LOGIC;
            sum_out : out STD_LOGIC_VECTOR (7 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    component shift_reg_right
        port (
            clk : in STD_LOGIC;
            load : in STD_LOGIC;
            integer_in : in STD_LOGIC_VECTOR(7 downto 0); 
            data_out : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    component _reg -- Assuming this is the component name for the 8-bit register
        port (        
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR(7 downto 0);
            data_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
begin
    arith_unit: entity work.shift_adder
        port map (
            clk => clk,
            load => reset,
            multiplicand => multiplicand,
            muliplier_in => arith_control,
            sum_out => partial_product,
            Cout => open  -- If carry out is not used
        );

    result: entity work.reg
        port map (
            clk => clk,
            rst => reset,
            d => partial_product,
            q => full_product -- Port to output the integer value
        );

    multiplier_sr: entity work.shift_reg_right
        port map (
            clk => clk,
            load => mult_load,
            d => mult,
            q => mult_bit
        );

    product <= product_integer;  -- Assigning the converted integer product

    control_section: process
    begin
        -- Initialization or reset logic for control signals
        if reset = '1' then
            arith_control <= '1';
            result_en <= '0';
            mult_load <= '1';  -- Load the multiplier initially
        else
            mult_load <= '0';  -- Stop loading after the initial load
            -- Other control logic as per the multiplier algorithm
            -- For example:
            -- If the least significant bit of mult_bit is '1', enable addition
            arith_control <= mult_bit;
            -- Enable storing the result in the register
            result_en <= '1';
        end if;

        wait until rising_edge(clk);
    end process control_section;
end architecture mixed;
