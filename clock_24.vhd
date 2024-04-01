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
    signal seconds_count, minutes_count: integer range 0 to 59 := 0;
    signal hours_count: integer range 0 to 23 := 0;
    signal an: std_logic_vector (5 downto 0);
    signal B_h_2, B_h_1, B_m_2, B_m_1, B_s_2, B_s_1: std_logic_vector (3 downto 0);
    signal t_disp : std_logic_vector(23 downto 0);

    component disp6 is
        Port (
            clk : in std_logic;
            disp_in : in std_logic_vector(23 downto 0);
            an : out std_logic_vector (5 downto 0);
            CA, CB, CC, CD, CE, CF, CG : out std_logic
        );
    end component;

signal intermediate_signal: std_logic_vector(6 downto 0);

begin
    process(clk)
    variable count: integer := 0;
    begin
        if rising_edge(clk) then
            count := count +1;
            if count = 10000000 then
                count := 0;
                seconds_count <= seconds_count + 1;
                if seconds_count = 59 then
                    seconds_count <= 0;
                    minutes_count <= minutes_count + 1;
                    if minutes_count = 59 then
                        minutes_count <= 0;
                        hours_count <= hours_count + 1;
                        if hours_count = 23 then
                            hours_count <= 0;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    process (seconds_count, minutes_count, hours_count)
    variable s_1 : integer := 0;
    variable s_2 : integer := 0;
    variable m_1 : integer := 0;
    variable m_2 : integer := 0;
    variable h_1 : integer := 0;
    variable h_2 : integer := 0;
    begin
        s_1 := seconds_count mod 10;
        s_2 := seconds_count mod 10;
        m_1 := minutes_count mod 10;
        m_2 := minutes_count mod 10;
        h_1 := hours_count mod 10;
        h_2 := hours_count mod 10;

        B_s_1 <= std_logic_vector(to_unsigned(s_1, 4));
        B_s_2 <= std_logic_vector(to_unsigned(s_2, 4));
        B_m_1 <= std_logic_vector(to_unsigned(m_1, 4));
        B_m_2 <= std_logic_vector(to_unsigned(m_2, 4));
        B_h_1 <= std_logic_vector(to_unsigned(h_1, 4));
        B_h_2 <= std_logic_vector(to_unsigned(h_2, 4));
    end process;
    
    disp6_instance: disp6
        port map (
            clk => clk,
            disp_in => t_disp,
            an => an,
            CA => intermediate_signal(0), 
            CB => intermediate_signal(1), 
            CC => intermediate_signal(2), 
            CD => intermediate_signal(3), 
            CE => intermediate_signal(4), 
            CF => intermediate_signal(5), 
            CG => intermediate_signal(6)
        );
        
second_7seg_1(0) <= intermediate_signal(0) or an(0); 
second_7seg_1(1) <= intermediate_signal(1) or an(0); 
second_7seg_1(2) <= intermediate_signal(2) or an(0); 
second_7seg_1(3) <= intermediate_signal(3) or an(0); 
second_7seg_1(4) <= intermediate_signal(4) or an(0); 
second_7seg_1(5) <= intermediate_signal(5) or an(0); 
second_7seg_1(6) <= intermediate_signal(6) or an(0); 

second_7seg_2(0) <= intermediate_signal(0) or an(1); 
second_7seg_2(1) <= intermediate_signal(1) or an(1); 
second_7seg_2(2) <= intermediate_signal(2) or an(1); 
second_7seg_2(3) <= intermediate_signal(3) or an(1); 
second_7seg_2(4) <= intermediate_signal(4) or an(1); 
second_7seg_2(5) <= intermediate_signal(5) or an(1); 
second_7seg_2(6) <= intermediate_signal(6) or an(1); 

minute_7seg_1(0) <= intermediate_signal(0) or an(2); 
minute_7seg_1(1) <= intermediate_signal(1) or an(2); 
minute_7seg_1(2) <= intermediate_signal(2) or an(2); 
minute_7seg_1(3) <= intermediate_signal(3) or an(2); 
minute_7seg_1(4) <= intermediate_signal(4) or an(2); 
minute_7seg_1(5) <= intermediate_signal(5) or an(2); 
minute_7seg_1(6) <= intermediate_signal(6) or an(2); 

minute_7seg_2(0) <= intermediate_signal(0) or an(3); 
minute_7seg_2(1) <= intermediate_signal(1) or an(3); 
minute_7seg_2(2) <= intermediate_signal(2) or an(3); 
minute_7seg_2(3) <= intermediate_signal(3) or an(3); 
minute_7seg_2(4) <= intermediate_signal(4) or an(3); 
minute_7seg_2(5) <= intermediate_signal(5) or an(3); 
minute_7seg_2(6) <= intermediate_signal(6) or an(3); 

hour_7seg_1(0) <= intermediate_signal(0) or an(4); 
hour_7seg_1(1) <= intermediate_signal(1) or an(4); 
hour_7seg_1(2) <= intermediate_signal(2) or an(4); 
hour_7seg_1(3) <= intermediate_signal(3) or an(4); 
hour_7seg_1(4) <= intermediate_signal(4) or an(4); 
hour_7seg_1(5) <= intermediate_signal(5) or an(4); 
hour_7seg_1(6) <= intermediate_signal(6) or an(4); 

hour_7seg_2(0) <= intermediate_signal(0) or an(5); 
hour_7seg_2(1) <= intermediate_signal(1) or an(5); 
hour_7seg_2(2) <= intermediate_signal(2) or an(5); 
hour_7seg_2(3) <= intermediate_signal(3) or an(5); 
hour_7seg_2(4) <= intermediate_signal(4) or an(5); 
hour_7seg_2(5) <= intermediate_signal(5) or an(5); 
hour_7seg_2(6) <= intermediate_signal(6) or an(5); 
      
t_disp <= B_h_2 & B_h_1 & B_m_2 & B_m_1 & B_s_2 & B_s_1;

end Behavioral;