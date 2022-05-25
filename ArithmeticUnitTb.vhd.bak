LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ArithmeticUnit_Tb IS
END ArithmeticUnit_Tb;

ARCHITECTURE Stimulus OF ArithmeticUnit_Tb IS
	SIGNAL s_operand0, s_operand1, s_operand2, s_operand3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_Result : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	uut : ENTITY work.ArithmeticUnit(Behavioral)
		PORT MAP(
			operand0 => s_operand0,
			operand1 => s_operand1,
			operand2 => s_operand2,
			operand3 => s_operand3,
			Result => s_Result);
	Result => s_Result);

stim_proc : PROCESS
		BEGIN
		WAIT FOR 100 ns;
		s_operand0 <= "00001010";
		s_operand1 <= "00001010";
		s_operand2 <= "00001010";
		s_operand3 <= "00001010";
		WAIT FOR 100 ns;
		s_operand0 <= "00001010";
		s_operand1 <= "00000101";
		s_operand2 <= "00000100";
		s_operand3 <= "11111001";
		WAIT FOR 100 ns;
		s_operand0 <= "11111011";
		s_operand1 <= "11111001";
		s_operand2 <= "11110110";
	s_operand3 <= "00000001";
		END PROCESS;