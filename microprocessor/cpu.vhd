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
    constant one : std_logic_vector(7 downto 0) := "00000001";

    -- FSM states
    type state_t is (load_opcode, LDA_1, STA_1, ADD_1, JMP_1, JNC_1); --define custom type named state_t
    -- Signals used for debugging
    signal state_watch : state_t; --declare a signal using this type

    -- CPU registers
    signal CF : std_logic := '0';  -- Carry flag, '0' indicates no carry, '1' indicates carry
    signal accu : std_logic_vector(7 downto 0) := "00000000"; -- Accumulator
    signal op_code : std_logic_vector(3 downto 0) := "0000"; -- Current op-code
    signal pc : std_logic_vector(7 downto 0) := "00000000"; -- Program counter
    signal addr_operand : std_logic_vector(7 downto 0); -- Address operand for STA, ADD, JMP, JNC

begin -- fsm

    -- Accumulator and program counter value outputs
    accu_out <= accu;
    pc_out <= pc;

    fsm_proc : process(clk, reset)
    variable state : state_t;
    begin -- process fsm_proc
        if reset = '1' then -- Asynchronous reset
            -- Output and variable initialization
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
                    addr <= pc + one; -- Memory address pointed to by PC

                    -- Op-code determines the next state
                    case dr(3 downto 0) is
                        when LDA => state := LDA_1;
                        when STA => state := STA_1;
                        when ADD => state := ADD_1;
                        when JMP => state := JMP_1;
                        when JNC => state := JNC_1;
                        when others => state := load_opcode;
                    end case; -- opcode decoder

                -- Op-code behaviors
                when LDA_1 => -- Load accumulator from memory address
                    accu <= dr;
                    pc <= pc + one;
                    addr <= pc + one;
                    state := load_opcode;

                when STA_1 => -- Store accumulator to memory address
                    addr_operand <= dr; -- Assign address operand
                    dw <= accu;
                    wr_en <= '1';
                    pc <= pc + one;
                    addr <= pc + one;
                    state := load_opcode;

                when ADD_1 => -- Add memory value to accumulator
                    accu <= std_logic_vector(unsigned(accu) + unsigned(dr));
                    pc <= pc + one;
                    addr <= pc + one;
                    state := load_opcode;

                when JMP_1 => -- Jump to specified address
                    pc <= dr;
                    addr <= pc + one;
                    state := load_opcode;

                 when JNC_1 => -- Jump if no carry flag is set
                    if CF = '0' then -- Define the condition
                        pc <= dr;
                    else
                        pc <= pc + one;
                    end if;
                    addr <= pc + one;
                   state := load_opcode;

                when others => -- Default case
                    state := load_opcode;
            end case; -- state
        end if; -- rising_edge(clk)
    end process fsm_proc;
end fsm;
