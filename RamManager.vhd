LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RamManager IS
	PORT (
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		inWriteEnable : IN STD_LOGIC;
		inAddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		inData : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		outData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END RamManager;

ARCHITECTURE Behavioral OF RamManager IS
	SIGNAL s_AddressReset : unsigned(7 DOWNTO 0) := "00000000";
	SIGNAL s_Address, s_DataIn : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_WriteEnable : STD_LOGIC;
BEGIN
	PROCESS (clock)
	BEGIN
		IF (rising_edge(clock)) THEN
			IF (reset = '1') THEN
				s_WriteEnable <= '1';
				s_Address <= STD_LOGIC_VECTOR(s_AddressReset);
				s_DataIn <= "00000000";
				s_AddressReset <= s_AddressReset + 1;
			ELSE
				s_WriteEnable <= inWriteEnable;
				s_Address <= inAddress;
				s_DataIn <= inData;
			END IF;
		END IF;
	END PROCESS;
	
	CleanRAM : ENTITY work.CleanTriangSignalRAM256x8(Behavioral)
		PORT MAP(
			clock => clock,
			writeEnable => s_WriteEnable,
			writeData => s_DataIn,
			address => s_Address,
			dataOut => outData
		);

END Behavioral;
