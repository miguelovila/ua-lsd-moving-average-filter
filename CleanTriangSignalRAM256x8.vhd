LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CleanTriangSignalRAM256x8 IS
	PORT (
		writeEnable : IN STD_LOGIC;
		clock : IN STD_LOGIC;
		writeData : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		dataOut : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END CleanTriangSignalRAM256x8;

ARCHITECTURE Behavioral OF CleanTriangSignalRAM256x8 IS
	CONSTANT NUM_WORDS : INTEGER := 256;
	CONSTANT WORD_SIZE : INTEGER := 8;

	SUBTYPE TDataWord IS STD_LOGIC_VECTOR(WORD_SIZE - 1 DOWNTO 0);
	TYPE TMemory IS ARRAY (0 TO NUM_WORDS - 1) OF TDataWord;
	SIGNAL s_Memory : TMemory;

BEGIN
	PROCESS (clock)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (writeEnable = '1') THEN
				s_Memory(to_integer(unsigned(address))) <= writeData;
			END IF;
		END IF;
	END PROCESS;
	dataOut <= s_Memory(to_integer(unsigned(address)));
END Behavioral;