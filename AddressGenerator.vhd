LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY AddressGenerator IS
	PORT (
		clock : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		address : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END AddressGenerator;

ARCHITECTURE Behavioral OF AddressGenerator IS
	SIGNAL s_address : unsigned(7 DOWNTO 0) := "00000000";
BEGIN
	PROCESS (clock)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN
				s_address <= "00000000";
			ELSE
				IF (enable = '1') THEN
					s_address <= s_address + 1;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	address <= STD_LOGIC_VECTOR(s_address);
END Behavioral;