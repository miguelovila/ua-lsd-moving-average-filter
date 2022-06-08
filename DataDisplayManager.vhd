LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DataDisplayManager IS
	PORT (
		dataIn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		unitsDisplay, dozensDisplay, hundredsDisplay, signalDisplay : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END DataDisplayManager;

ARCHITECTURE Structural OF DataDisplayManager IS
	SIGNAL s_DataIn : unsigned(7 DOWNTO 0);
	SIGNAL s_UnitsBCD, s_DozensBCD, s_HundredsBCD, s_SIGNAL : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	s_DataIn <= unsigned(STD_LOGIC_VECTOR(ABS(signed(dataIn))));
	DigitSeparation : PROCESS (s_DataIn, dataIn) BEGIN
		IF (dataIn(7) = '1') THEN
			s_SIGNAL <= "1010";
		ELSE
			s_SIGNAL <= "1011";
		END IF;
		s_HundredsBCD <= STD_LOGIC_VECTOR(s_DataIn/100)(3 DOWNTO 0);
		s_DozensBCD <= STD_LOGIC_VECTOR((s_DataIn REM 100)/10)(3 DOWNTO 0);
		s_UnitsBCD <= STD_LOGIC_VECTOR((s_DataIn REM 100) REM 10)(3 DOWNTO 0);
	END PROCESS;

	signalDisplayProc : ENTITY work.Bin7SegDec(Behavioral)
		PORT MAP(
			dataIn => s_Signal,
			dataOut => signalDisplay
		);

	unitsDisplayProc : ENTITY work.Bin7SegDec(Behavioral)
		PORT MAP(
			dataIn => s_UnitsBCD,
			dataOut => unitsDisplay
		);

	dozensDisplayProc : ENTITY work.Bin7SegDec(Behavioral)
		PORT MAP(
			dataIn => s_DozensBCD,
			dataOut => dozensDisplay
		);

	hundredsDisplayProc : ENTITY work.Bin7SegDec(Behavioral)
		PORT MAP(
			dataIn => s_HundredsBCD,
			dataOut => hundredsDisplay
		);
END Structural;