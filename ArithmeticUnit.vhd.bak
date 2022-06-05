LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ArithmeticUnit IS
	PORT (
		operand0, operand1, operand2, operand3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ArithmeticUnit;

ARCHITECTURE Behavioral OF ArithmeticUnit IS
	SIGNAL s_Op0, s_Op1, s_Op2, s_Op3, s_Soma, s_Result : signed(7 DOWNTO 0);
BEGIN
	s_Op0 <= signed(operand0);
	s_Op1 <= signed(operand1);
	s_Op2 <= signed(operand2);
	s_Op3 <= signed(operand3);

	s_Soma <= ((s_op0 + s_op1) + (s_op2 + s_op3));

	s_Result <= s_soma / 4;

	result <= STD_LOGIC_VECTOR(s_r);

END Behavioral;