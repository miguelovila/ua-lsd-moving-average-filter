LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ArithmeticUnitTb IS
END ArithmeticUnitTb;

ARCHITECTURE Stimulus OF ArithmeticUnitTb IS
		SIGNAL s_Op0, s_Op1, s_Op2, s_Op3, s_Result, s_Address : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	UUT : ENTITY work.ArithmeticUnit(Behavioral)
		PORT MAP(
			op0 => s_Op0,
			op1 => s_Op1,
			op2 => s_Op2,
			op3 => s_Op3,
			filterOn => '1',
			address => s_Address,
			result => s_Result
		);

	STIMULUSPROC : PROCESS BEGIN
		s_Address <= "10010000";
		s_Op0 <= "00001010";
		s_Op1 <= "00001010";
		s_Op2 <= "00001010";
		s_Op3 <= "00001010";
		WAIT FOR 100 ns;
		s_Address <= "10010001";
		s_Op0 <= "00001010";
		s_Op1 <= "00000101";
		s_Op2 <= "00000100";
		s_Op3 <= "11111001";
		WAIT FOR 100 ns;
		s_Address <= "10010010";
		s_Op0 <= "11111011";
		s_Op1 <= "11111001";
		s_Op2 <= "11110110";
		s_Op3 <= "00000001";
		WAIT FOR 100 ns;
		s_Address <= "11111111";
		s_Op0 <= "11111011";
		s_Op1 <= "11111001";
		s_Op2 <= "11110110";
		s_Op3 <= "00000001";
		WAIT FOR 100 ns;
		s_Address <= "00000000";
		s_Op0 <= "11111111";
		s_Op1 <= "11111001";
		s_Op2 <= "11110110";
		s_Op3 <= "00000001";
		WAIT FOR 100 ns;
		s_Address <= "00000001";
		s_Op0 <= "11111111";
		s_Op1 <= "11111001";
		s_Op2 <= "11110110";
		s_Op3 <= "00000001";
		WAIT FOR 100 ns;
		s_Address <= "10010010";
		s_Op0 <= "11111110";
		s_Op1 <= "11111110";
		s_Op2 <= "11111110";
		s_Op3 <= "00000000";
	END PROCESS;
END Stimulus;