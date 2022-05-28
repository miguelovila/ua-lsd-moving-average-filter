LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY FiltroMediaMovel IS
	PORT (
		CLOCK_50 : IN  STD_LOGIC;
		KEY : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		SW : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END FiltroMediaMovel;

ARCHITECTURE Structural OF FiltroMediaMovel IS
	-- Pulse signals
	SIGNAL s_2HzLane : STD_LOGIC;
	--SIGNAL s_WritePulse : STD_LOGIC;
	
	-- Clean and syncronized inputs
	SIGNAL s_Key0, s_Key1, s_Key2, s_Swi0 : STD_LOGIC;
	
	-- Control signals
	SIGNAL s_GlobalReset, s_RamReset, s_Running, s_FilterOn, s_DataReady : STD_LOGIC;
	
	-- Data signals
	SIGNAL s_Address : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_NoisyData, s_NextNoisyData : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_NoisyData0, s_NoisyData1, s_NoisyData2, s_NoisyData3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL s_CleanData, s_CleanDataDisplay : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	-- Pulse generation
	Hz2Lane : ENTITY work.PulseGenerator(Behavioral)
		GENERIC MAP (
			MAX => 25000000
		)
		PORT MAP(
			clock => CLOCK_50,
			startStop => s_Running,
			reset => s_GlobalReset,
			pulse => s_2HzLane
		);
		
	-- Write pulse generation
	--WritePulse : ENTITY work.Timer(Behavioral)
		--GENERIC MAP (
			--K => 500
		--)
		--PORT MAP(
			--clock => CLOCK_50,
			--reset => s_GlobalReset,
			--start => s_2HzLane,
			--timerOut => s_WritePulse
		--);
	
	-- Input syncronization and cleaning
	InputCleaner : ENTITY work.CleanInputManager(Structural)
		PORT MAP(
			clock => CLOCK_50,
			switch => SW(0),
			key0 => KEY(0),
			key1 => KEY(1),
			key2 => KEY(2),
			cleanSwitch => s_Swi0,
			cleanKey0 => s_Key0,
			cleanKey1 => s_Key1,
			cleanKey2 => s_Key2
		);
	
	-- Address generation
	AddressGenerator : ENTITY work.AddressGenerator(Behavioral)
		PORT MAP(
			clock => CLOCK_50,
			enable => s_2HzLane,
			reset => s_GlobalReset,
			address => s_Address
		);
		
	-- ROM reading
	RomManagment : ENTITY work.RomManager(Behavioral)
		PORT MAP(
			clock => CLOCK_50, 
			inAddress => s_Address,
			currData => s_NoisyData,
			nextData => s_NextNoisyData,
			dataReady => s_DataReady
		);
		
	RomDisplay : ENTITY work.DataDisplayManager(Structural)
		PORT MAP(
			dataIn => s_NoisyData,
			signalDisplay => HEX3,
			hundredsDisplay => HEX2,
			dozensDisplay => HEX1,
			unitsDisplay => HEX0
		);

	-- RAM reading and writing
	RamManagment : ENTITY work.RamManager(Behavioral)
		PORT MAP(
			clock => CLOCK_50,
			reset => s_RamReset,
			--inWriteEnable => s_WritePulse,
			inWriteEnable => '1',
			inAddress => s_Address,
			inData => s_CleanData,
			outData => s_CleanDataDisplay
		);

	RamDisplay : ENTITY work.DataDisplayManager(Structural)
		PORT MAP(
			dataIn => s_CleanDataDisplay,
			signalDisplay => HEX7,
			hundredsDisplay => HEX6,
			dozensDisplay => HEX5,
			unitsDisplay => HEX4
		);
		
	-- Data handling and calculation
	DataBank : ENTITY work.RegisterBank(Behavioral)
		PORT MAP(
			clock => CLOCK_50,
			writeEnable => s_DataReady,
			currDataIn => s_NoisyData,
			nextDataIn => s_NextNoisyData,
			dataOut0 => s_NoisyData0,
			dataOut1 => s_NoisyData1,
			dataOut2 => s_NoisyData2,
			dataOut3 => s_NoisyData3
		);
		
	Calculation : ENTITY work.ArithmeticUnit(Behavioral)
		PORT MAP(
			address => s_Address,
			filterOn => s_FilterOn,
			op0 => s_NoisyData0,
			op1 => s_NoisyData1,
			op2 => s_NoisyData2,
			op3 => s_NoisyData3,
			result => s_CleanData
		);

	-- State controller
	StateController : ENTITY work.ControlUnit(Behavioral)
		PORT MAP(
			clock => CLOCK_50,
			globalReset => s_Key2,
			ramReset => s_Key1,
			startStop => s_Key0,
			toggleFilter => s_Swi0,
			callGlobalReset => s_GlobalReset,
			callRamReset => s_RamReset,
			callSTartStop => s_Running,
			callToggleFilter => s_FilterOn
		);
END Structural;