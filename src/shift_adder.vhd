
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_adder is
    Port (
          clk : in STD_LOGIC;
          load : in STD_LOGIC;
          multiplicand: in STD_LOGIC_VECTOR (7 downto 0);
          partial_product_in: in STD_LOGIC_VECTOR (7 downto 0);
          partial_product_out: out STD_LOGIC_VECTOR (7 downto 0);
          carry_out : out STD_LOGIC
         );
end shift_adder;

architecture Behavioral of shift_adder is

    component shift_reg_left
        Port (
              clk : in STD_LOGIC;
              load : in STD_LOGIC;
              d : in STD_LOGIC_VECTOR (7 downto 0);
              q : out STD_LOGIC_VECTOR (7 downto 0)
             );
    end component;

    component ripple_carry_adder_8bit
        Port (
              A : in STD_LOGIC_VECTOR (7 downto 0);
              B : in STD_LOGIC_VECTOR (7 downto 0);
              Cin : in std_logic;
              Sum : out STD_LOGIC_VECTOR (7 downto 0);
              Cout : out STD_LOGIC
             );
    end component;

    signal partial_product_reg : STD_LOGIC_VECTOR (7 downto 0);
    signal carry_in : std_logic := '0';

begin

    shift_left_inst : shift_reg_left
    port map (
              clk => clk,
              load => load,
              d => multiplicand,
              q => partial_product_reg
             );

    adder_inst : ripple_carry_adder_8bit
    port map (
              A => partial_product_reg,
              B => partial_product_in,  
              Cin => carry_in,
              Sum => partial_product_out,
              Cout => carry_out
             );

end Behavioral;