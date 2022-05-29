LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegisterBank IS
	PORT (
		clock, writeEnable : STD_LOGIC;
		currDataIn, nextDataIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
		dataOut0, dataOut1, dataOut2, dataOut3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END RegisterBank;

ARCHITECTURE Behavioral OF RegisterBank IS
	SIGNAL s_Data0, s_Data1, s_Data2, s_Data3 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS (clock, writeEnable)
	BEGIN
		IF (RISING_EDGE(clock)) THEN
			IF (writeEnable = '1') THEN
				s_Data2 <= s_Data1;
				s_Data1 <= s_Data0;
				s_Data0 <= currDataIn;
			
				s_Data3 <= nextDataIn;
			END IF;
		END IF;
	END PROCESS;

	dataOut0 <= s_Data0;
	dataOut1 <= s_Data1;
	dataOut2 <= s_Data2;
	dataOut3 <= s_Data3;
END Behavioral;