LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RegisterBankTb IS
END RegisterBankTb;

ARCHITECTURE Stimulus OF RegisterBankTb IS
	SIGNAL s_WriteEnable, s_Clock : STD_LOGIC;
	SIGNAL s_CurrDataIn, s_NextDataIn, s_DataOut0, s_DataOut1, s_DataOut2, s_DataOut3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	UUT : ENTITY work.RegisterBank(Behavioral)
		PORT MAP(
			clock => s_Clock,
			writeEnable => s_WriteEnable,
			currDataIn => s_CurrDataIn,
			nextDataIn => s_NextDataIn,
			dataOut0 => s_DataOut0,
			dataOut1 => s_DataOut1,
			dataOut2 => s_DataOut2,
			dataOut3 => s_DataOut3
		);
	
	ClockProc : PROCESS BEGIN
		s_Clock <= '0'; WAIT FOR 10 ns;
		s_Clock <= '1'; WAIT FOR 10 ns; 
	END PROCESS;
	
	WriteProc : PROCESS BEGIN
		s_WriteEnable <= '0'; WAIT FOR 30 ns;
		s_WriteEnable <= '1'; WAIT FOR 30 ns; 
	END PROCESS;
	
	STIMULUSPROC : PROCESS BEGIN
		s_NextDataIn <= "00000001";
		s_CurrDataIn <= "00001100"; WAIT FOR 40 ns;
		s_NextDataIn <= "01000001";
		s_CurrDataIn <= "00000000"; WAIT FOR 40 ns;
		s_NextDataIn <= "00111001";
		s_CurrDataIn <= "00000001"; WAIT FOR 40 ns;
		s_NextDataIn <= "00001001";
		s_CurrDataIn <= "11111111"; WAIT FOR 40 ns;
		s_NextDataIn <= "10000001";
		s_CurrDataIn <= "01001100"; WAIT FOR 40 ns;
		s_CurrDataIn <= "01101100"; WAIT FOR 40 ns;
		s_NextDataIn <= "11110001";
		s_CurrDataIn <= "01001111"; WAIT FOR 40 ns;
		s_CurrDataIn <= "00001100"; WAIT FOR 40 ns;
		s_CurrDataIn <= "11111110"; WAIT FOR 40 ns;
		s_NextDataIn <= "11111101";
		s_CurrDataIn <= "11111111"; WAIT FOR 40 ns;
	END PROCESS;
END Stimulus;