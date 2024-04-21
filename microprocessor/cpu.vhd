
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity cpu is
  port(
    clk : in std_logic;
    reset : in std_logic;
    wr_en : out std_logic;
    dr : in std_logic_vector(7 downto 0); -- Data from the memory
    dw : out std_logic_vector(7 downto 0); -- Data to the memory
    addr : out std_logic_vector(7 downto 0); -- Memory address
    pc_out : out std_logic_vector(7 downto 0); -- Program counter value
    accu_out : out std_logic_vector(7 downto 0) -- Accumulator value
  );
end cpu;

architecture fsm of cpu is
  -- op-codes
  constant LDA : std_logic_vector(3 downto 0) := "0001";
  constant STA : std_logic_vector(3 downto 0) := "0010";
  constant ADD : std_logic_vector(3 downto 0) := "0011";
  constant JNC : std_logic_vector(3 downto 0) := "0100";
  constant JMP : std_logic_vector(3 downto 0) := "0101";
  constant MUL : std_logic_vector(3 downto 0) := "0110";
  constant one : std_logic_vector(7 downto 0) := "00000001";

  -- CPU registers
  signal accu : std_logic_vector(7 downto 0) := "00000000"; -- Accumulator
  signal op_code : std_logic_vector(3 downto 0) := "0000"; -- Current op-code
  signal pc : std_logic_vector(7 downto 0) := "00000000"; -- Program counter
  signal temp_1 : std_logic_vector(8 downto 0) := "000000000";

  -- FSM states
  type state_t is (load_opcode, LDA_1, STA_1, ADD_1, ADD_2, JNC_1, JMP_1,STA_2, JMP_2, MUL_1);
  signal state_watch : state_t;

begin -- fsm
  -- Accumulator, program counter, and carry flag outputs
  accu_out <= accu;
  pc_out <= pc;

  fsm_proc : process (clk, reset)
    variable state : state_t := load_opcode;
  begin -- process fsm_proc
    if (reset = '1') then -- Asynchronous reset
      -- output and variable initialisation
      wr_en <= '0';
      dw <= (others => '0');
      addr <= (others => '0');
      op_code <= (others => '0');
      accu <= (others => '0');
      pc <= (others => '0');
      state := load_opcode;
    elsif rising_edge(clk) then -- Synchronous FSM
      state_watch <= state;
      case state is
        when load_opcode =>
          op_code <= dr(3 downto 0); -- Load the op-code
          pc <= pc + one; -- Increment the program counter
          addr <= pc + one; -- Memory address pointed to PC

          -- Op-code determines the next state:
          case dr (3 downto 0) is
            when LDA => state := LDA_1;
            when STA => state := STA_1;
            when ADD => state := ADD_1;
            when JNC => state := JNC_1;
            when JMP => state := JMP_1;
            when MUL => state := MUL_1;
            when others => state := load_opcode;
          end case; -- opcode decoder

        when LDA_1 => -- Load accumulator from memory address
          accu <= dr;
          pc <= pc + one;
          addr <= pc + one;
          state := load_opcode;

        when ADD_1 => -- Fetch operand from memory
         temp_1 <= '0' & accu;
          addr <= dr;
          state := ADD_2;
          
        when ADD_2 => -- Add operand to accumulator
          temp_1 <= temp_1 +('0' & dr);
          accu <= accu + dr;
          pc <= pc + one;
          addr <= pc + one;
          state := load_opcode;
          
        when STA_1 => -- Store accumulator to memory address
          dw <= accu;
          wr_en <= '1';
          addr <= dr;
          state := STA_2;
          
          when STA_2 => -- Store accumulator to memory address
          
          wr_en <= '0';
          addr <= pc + one;
          pc <= pc + one;
          state := load_opcode;



        when JNC_1 => -- Jump if no carry
         if temp_1(8) > '1' OR temp_1(8) < '1' then
            pc <= dr;
            addr <= dr;
            state := load_opcode;
          elsif temp_1(8) = '1'then
            pc <= pc + 1;
            addr <= pc + 1;
           state := load_opcode;
          end if;


        when JMP_1 => -- Unconditional jump
          accu <= dr;
          state := JMP_2;
          
        when JMP_2 => -- Unconditional jump
         pc <= dr;
         addr <= dr;
          state := load_opcode;
          
        when MUL_1 => -- Unconditional jump
          accu <= dr;
          state := load_opcode;

      end case; -- state
    end if; -- rising_edge(clk)
  end process fsm_proc;
end fsm;
