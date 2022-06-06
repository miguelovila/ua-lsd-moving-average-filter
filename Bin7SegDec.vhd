LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Bin7SegDec IS
	PORT (
		dataIn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		dataOut : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Bin7SegDec;

ARCHITECTURE Behavioral OF Bin7SegDec IS
BEGIN
	dataOut <= "1111001" WHEN (dataIn = "0001") ELSE -- 1
		"0100100" WHEN (dataIn = "0010") ELSE -- 2
		"0110000" WHEN (dataIn = "0011") ELSE -- 3
		"0011001" WHEN (dataIn = "0100") ELSE -- 4
		"0010010" WHEN (dataIn = "0101") ELSE -- 5
		"0000010" WHEN (dataIn = "0110") ELSE -- 6
		"1111000" WHEN (dataIn = "0111") ELSE -- 7
		"0000000" WHEN (dataIn = "1000") ELSE -- 8
		"0010000" WHEN (dataIn = "1001") ELSE -- 9
		"0111111" WHEN (dataIn = "1010") ELSE -- -
		"1111111" WHEN (dataIn = "1011") ELSE -- OFF
		"1000000"; -- 0
END Behavioral;