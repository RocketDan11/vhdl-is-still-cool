library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- For to_unsigned

entity Clock_24h is
port(
    clk: in std_logic;
    second_7seg_1: out std_logic_Vector(6 downto 0);
    second_7seg_2: out std_logic_Vector(6 downto 0);
    minute_7seg_1: out std_logic_Vector(6 downto 0);
    minute_7seg_2: out std_logic_Vector(6 downto 0);
    hour_7seg_1: out std_logic_Vector(6 downto 0);
    hour_7seg_2: out std_logic_Vector(6 downto 0)
    ); --1hz
end Clock_24h;

architecture Behavioral of Clock_24h is
    signal seconds, minutes: integer range 0 to 59 := 0;
    signal hours: integer range 0 to 23 := 0;
    signal an: std_logic_vector (5 downto 0);
    signal time_display : std_logic_vector(23 downto 0); -- Intermediate signal for disp6 input

    component disp_6 is
        Port (
            clk : in std_logic;
            disp_in : in std_logic_vector(23 downto 0);
            an : out std_logic_vector (5 downto 0);
            CA, CB, CC, CD, CE, CF, CG : out std_logic
        );
    end component;

signal inter: std_logic_vector(6 downto 0);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            seconds <= seconds + 1;
            if seconds = 59 then
                seconds <= 0;
                minutes <= minutes + 1;
                if minutes = 59 then
                    minutes <= 0;
                    hours <= hours + 1;
                    if hours = 23 then
                        hours <= 0;
                    end if;
                end if;
            end if;
        end if;
    end process;

    process (seconds, minutes, hours)
    variable sec_1 : integer := 0;
    variable sec_2 : integer := 0;
    variable min_1 : integer := 0;
    variable min_2 : integer := 0;
    variable hr_1 : integer := 0;
    variable hr_2 : integer := 0;
    begin
        sec_1 := seconds mod 10;
        sec_2 := seconds mod 10;
        min_1 := minutes mod 10;
        min_2 := minutes mod 10;
        hr_1 := hours mod 10;
        hr_2 := hours mod 10;
    end process;
    
    disp6_instance: disp_6
        port map (
            clk => clk,
            disp_in => time_display,
            an => an,
            CA => inter(0), CB => inter(1), CC => inter(2), CD => inter(3), CE => inter(4), CF => inter(5), CG => inter(6)
        );
        
second_7seg_1(0) <= inter(0) or an(0); 
second_7seg_1(1) <= inter(1) or an(0); 
second_7seg_1(2) <= inter(2) or an(0); 
second_7seg_1(3) <= inter(3) or an(0); 
second_7seg_1(4) <= inter(4) or an(0); 
second_7seg_1(5) <= inter(5) or an(0); 
second_7seg_1(6) <= inter(6) or an(0); 

second_7seg_2(0) <= inter(0) or an(1); 
second_7seg_2(1) <= inter(1) or an(1); 
second_7seg_2(2) <= inter(2) or an(1); 
second_7seg_2(3) <= inter(3) or an(1); 
second_7seg_2(4) <= inter(4) or an(1); 
second_7seg_2(5) <= inter(5) or an(1); 
second_7seg_2(6) <= inter(6) or an(1); 

minute_7seg_1(0) <= inter(0) or an(2); 
minute_7seg_1(1) <= inter(1) or an(2); 
minute_7seg_1(2) <= inter(2) or an(2); 
minute_7seg_1(3) <= inter(3) or an(2); 
minute_7seg_1(4) <= inter(4) or an(2); 
minute_7seg_1(5) <= inter(5) or an(2); 
minute_7seg_1(6) <= inter(6) or an(2); 

minute_7seg_2(0) <= inter(0) or an(3); 
minute_7seg_2(1) <= inter(1) or an(3); 
minute_7seg_2(2) <= inter(2) or an(3); 
minute_7seg_2(3) <= inter(3) or an(3); 
minute_7seg_2(4) <= inter(4) or an(3); 
minute_7seg_2(5) <= inter(5) or an(3); 
minute_7seg_2(6) <= inter(6) or an(3); 

hour_7seg_1(0) <= inter(0) or an(4); 
hour_7seg_1(1) <= inter(1) or an(4); 
hour_7seg_1(2) <= inter(2) or an(4); 
hour_7seg_1(3) <= inter(3) or an(4); 
hour_7seg_1(4) <= inter(4) or an(4); 
hour_7seg_1(5) <= inter(5) or an(4); 
hour_7seg_1(6) <= inter(6) or an(4); 

hour_7seg_2(0) <= inter(0) or an(5); 
hour_7seg_2(1) <= inter(1) or an(5); 
hour_7seg_2(2) <= inter(2) or an(5); 
hour_7seg_2(3) <= inter(3) or an(5); 
hour_7seg_2(4) <= inter(4) or an(5); 
hour_7seg_2(5) <= inter(5) or an(5); 
hour_7seg_2(6) <= inter(6) or an(5); 
      
end Behavioral;
