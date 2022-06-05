LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ArithmeticUnit IS
	PORT (
		address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		filterOn : IN STD_LOGIC;
		op0, op1, op2, op3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ArithmeticUnit;

ARCHITECTURE Behavioral OF ArithmeticUnit IS
	SIGNAL s_Sum, s_Result : INTEGER;
BEGIN
	s_Sum <= (TO_INTEGER(SIGNED(op0)) + TO_INTEGER(SIGNED(op1))) + (TO_INTEGER(SIGNED(op2)) + TO_INTEGER(SIGNED(op3)));
	s_Result <= s_Sum / 4;
	result <= op0 WHEN ((address = "00000000") or (address = "00000001") or (address = "11111111") or (filterOn = '0')) ELSE STD_LOGIC_VECTOR(TO_SIGNED(s_Result,8));
END Behavioral;