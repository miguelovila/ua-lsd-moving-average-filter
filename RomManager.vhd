LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RomManager IS
	PORT (
		clock : IN STD_LOGIC;
		inAddress : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		dataReady : OUT STD_LOGIC;
		currData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		nextData : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END RomManager;

ARCHITECTURE Behavioral OF RomManager IS
	TYPE stateType IS (
		t_IDLE,
		t_NEXTADDRESS,
		t_CURRADDRESS,
		t_DATAREADY
	);
	SIGNAL currState : stateType := t_IDLE;
	SIGNAL s_SearchAddress, s_SearchData : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_OldSearchAddress : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111";
	SIGNAL s_DataReady : STD_LOGIC := '0';
BEGIN
	dataReady <= s_DataReady;

	StateFlow : PROCESS (clock) BEGIN
		IF (rising_edge(clock)) THEN
			CASE (currState) IS
				WHEN t_IDLE =>
					s_DataReady <= '0';
					IF (inAddress = s_OldSearchAddress) THEN
						currState <= t_IDLE;
					ELSE
						s_OldSearchAddress <= inAddress;
						currState <= t_CURRADDRESS;
					END IF;
				WHEN t_CURRADDRESS =>
					s_SearchAddress <= inAddress;
					s_DataReady <= '0';
					currState <= t_NEXTADDRESS;
					
				WHEN t_NEXTADDRESS =>
					currData <= s_SearchData;
					s_SearchAddress <= STD_LOGIC_VECTOR(UNSIGNED(inAddress) + "00000001");
					s_DataReady <= '0';
					currState <= t_DATAREADY;
					
				WHEN t_DATAREADY =>
					nextData <= s_SearchData;
					s_DataReady <= '1';
					currState <= t_IDLE;
					
				WHEN OTHERS =>
					NULL;
			END CASE;
		END IF;
	END PROCESS;

	NoisyROM : ENTITY work.NoisyTriangSignalROM256x8(Behavioral)
		PORT MAP(
			address => s_SearchAddress,
			dataOut => s_SearchData
		);

END Behavioral;