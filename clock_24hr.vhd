library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_24hr is
    port(
        clk: in std_logic; -- Assume this is a fast clock, e.g., 50 MHz
        second_7seg_1: out std_logic_vector(6 downto 0);
        second_7seg_2: out std_logic_vector(6 downto 0);
        minute_7seg_1: out std_logic_vector(6 downto 0);
        minute_7seg_2: out std_logic_vector(6 downto 0);
        hour_7seg_1: out std_logic_vector(6 downto 0);
        hour_7seg_2: out std_logic_vector(6 downto 0)
    );
end clock_24hr;

architecture Behavioral of clock_24hr is
    signal seconds, minutes, hours: integer range 0 to 59;
    signal clk_1hz: std_logic := '0';
    constant clock_frequency: integer := 50000000; -- 50 MHz
    signal counter: integer := 0;

    -- Example function to convert an integer to a 7-segment encoding
    -- This needs to be adapted based on your specific display and wiring
    function int_to_7seg(digit: integer) return std_logic_vector is
    begin
        case digit is
            when 0 => return "0000001"; -- Assuming '0' is encoded as "0000001"
            when 1 => return "1001111";
            -- Add cases for 2 to 9
            when others => return "1111111"; -- Off or error state
        end case;
    end function;
    
begin
    -- Clock divider to generate 1Hz clock from primary clock
    clk_divider: process(clk)
    begin
        if rising_edge(clk) then
            if counter >= (clock_frequency/2 - 1) then
                counter <= 0;
                clk_1hz <= not clk_1hz;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Timekeeping logic
    timekeeper: process(clk_1hz)
    begin
        if rising_edge(clk_1hz) then
            if seconds = 59 then
                seconds <= 0;
                if minutes = 59 then
                    minutes <= 0;
                    if hours = 23 then
                        hours <= 0;
                    else
                        hours <= hours + 1;
                    end if;
                else
                    minutes <= minutes + 1;
                end if;
            else
                seconds <= seconds + 1;
            end if;
        end if;
    end process;

    -- Output logic for 7-segment displays
    display_logic: process(seconds, minutes, hours)
    begin
        -- Splitting digits and converting them to 7-segment encoding
        second_7seg_1 <= int_to_7seg(seconds / 10);
        second_7seg_2 <= int_to_7seg(seconds mod 10);
        minute_7seg_1 <= int_to_7seg(minutes / 10);
        minute_7seg_2 <= int_to_7seg(minutes mod 10);
        hour_7seg_1 <= int_to_7seg(hours / 10);
        hour_7seg_2 <= int_to_7seg(hours mod 10);
    end process display_logic;

end Behavioral;
