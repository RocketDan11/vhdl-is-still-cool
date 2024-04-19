----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2024 11:48:12 AM
-- Design Name: 
-- Module Name: cpu_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu_top_tb is
--  Port ( );
end cpu_top_tb;

architecture Behavioral of cpu_top_tb is

component cpu_top is
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
end component;

signal clk : std_logic := '0';
signal reset : std_logic;
signal  wr_en : std_logic;
signal  dr : std_logic_vector(7 downto 0); -- Data from the memory
signal  dw : std_logic_vector(7 downto 0); -- Data to the memory
signal  addr : std_logic_vector(7 downto 0); -- Memory address
signal pc_out : std_logic_vector(7 downto 0); -- Program counter value
signal accu_out : std_logic_vector(7 downto 0);

begin

    uut: cpu_top port map (
        clk => clk,
        reset => reset,
        wr_en => wr_en,
        dr => dr,
        dw => dw,
        addr => addr,
        pc_out => pc_out,
        accu_out => accu_out);
    
    clk_process: process
    begin 
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50ns;
    end process;  
   


end Behavioral;
