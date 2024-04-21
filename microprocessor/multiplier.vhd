library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- For conversions and arithmetic operations

entity multiplier is
    port (
        clk, reset : in std_logic;
        multiplicand, multiplier : in std_logic_vector(7 downto 0); -- 4-bit inputs
        product : out std_logic_vector(7 downto 0) -- 8-bit output
    );
end entity multiplier;

architecture mixed of multiplier is
    
    signal multiplicand_vec, multiplicand_vec_sr : std_logic_vector(7 downto 0);
    signal multiplier_vec : std_logic_vector(7 downto 0);   
    signal partial_product_vec, full_product_vec : std_logic_vector(7 downto 0); -- For holding partial and full products
    signal arith_control, resset, mult_load : std_logic;
    signal carry_out_bit : std_logic;
    signal carry_in : std_logic := '0';
    signal product_v : std_logic_vector(7 downto 0);
    signal counter : integer range 0 to 7 := 0; -- Counter range adjusted for 4-bit multiplier

begin
    multiplicand_vec <= multiplicand; 
    multiplier_vec <= multiplier; 

    
    arith_unit : entity work.shift_adder
    port map (
        clk => clk,
        load => arith_control,
        multiplicand => multiplicand_vec_sr,
        partial_product_in => partial_product_vec,
        partial_product_out => partial_product_vec, -- No need for adjustment signal
        carry_out => open -- Assuming carry_out is not used
    );

    
    result_reg : entity work.reg4
    port map (
        clk => clk,
        reset => reset,
        d => full_product_vec,--partial_product_vec(7 downto 0), 
        q => full_product_vec 
        );

    -- Shift Register for processing multiplier bits
    multiplier_sr : entity work.shift_reg_right
    port map (
        clk => clk,
        load => mult_load,
        d =>  multiplicand_vec,--multiplicand_vec,
        q =>  multiplicand_vec_sr --multiplicand_vec_sr -- Adjusted for 4-bit signals
        );

    -- Ripple Carry Adder for addition
    adder : entity work.ripple_carry_adder_8bit
    port map (
        A => multiplicand_vec_sr,
        B => full_product_vec, -- Connecting only necessary bits
        Cin => carry_in,
        SUM => partial_product_vec,
        Cout => carry_out_bit
    );

    -- Control Unit
    control_unit : process(clk, reset)
begin
    if reset = '1' then
        -- Initialization on reset
        arith_control <= '0';
        result_en <= '0';
        mult_load <= '1';
        counter <= 0;
        full_product_vec <= (others => '0');  -- Ensure the full product is initialized to zero
        partial_product_vec <= (others => '0'); -- Initialize the partial product as well
        
    elsif rising_edge(clk) then
        if mult_load = '1' then
            -- Load the multiplicand and multiplier once
            multiplicand_vec_sr <= multiplicand_vec;
            multiplier_vec <= multiplier;
            mult_load <= '0';
        elsif counter < 8 then
            -- Perform the multiplication process
            if multiplier_vec(0) = '1' then
                arith_control <= '1'; -- Addition is required
            end if;
            -- Shift multiplier right
            multiplier_vec <= std_logic_vector(shift_right(unsigned(multiplier_vec), 1));
            -- Shift multiplicand left
            multiplicand_vec_sr <= std_logic_vector(shift_left(unsigned(multiplicand_vec_sr), 1));
            result_en <= '1';  -- Enable storing the result
            counter <= counter + 1;
        else
            -- End of multiplication process
            product <= full_product_vec;  -- Assign the accumulated product
            result_en <= '0'; -- Disable result storage
            counter <= 0; -- Reset counter for next operation
        end if;
    end if;
end process control_unit;
end architecture mixed;
