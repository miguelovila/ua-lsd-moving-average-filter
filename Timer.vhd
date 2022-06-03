LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Timer IS
    GENERIC (K : POSITIVE := 5);
    PORT (
        clock : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        timerOut : OUT STD_LOGIC);
END Timer;

ARCHITECTURE Behavioral OF Timer IS
    SIGNAL s_count : INTEGER := 0;
BEGIN
    ASSERT(K >= 2);
    PROCESS(clock)
    BEGIN
        IF (rising_edge(clock)) THEN
            IF (reset = '1') THEN
                timerOut <= '1';
                s_count <= 0;
            ELSE
                IF (s_count = 0) THEN
                    IF (start = '1') THEN
                        s_count <= s_count + 1;
                    END IF;
                    timerOut <= '0';
                ELSE
                    IF (s_count = (K - 1)) THEN
                        timerOut <= '1';
                        s_count <= 0;
                    ELSE
                        timerOut <= '0';
                        s_count <= s_count + 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;