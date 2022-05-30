LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CleanInputManager IS
	PORT (
		clock : IN STD_LOGIC;
		switch : IN STD_LOGIC;
		key0, key1, key2 : IN STD_LOGIC;
		cleanSwitch : OUT STD_LOGIC;
		cleanKey0, cleanKey1, cleanKey2 : OUT STD_LOGIC
	);
END CleanInputManager;

ARCHITECTURE Structural OF CleanInputManager IS
BEGIN
	-- Switch syncronization
	SwitchSync : PROCESS (clock) BEGIN
		IF (rising_edge(clock)) THEN
			cleanSwitch <= switch;
		END IF;
	END PROCESS;

	-- Keys debouncing
	DebounceKey0 : ENTITY work.DebounceUnit(Behavioral)
		GENERIC MAP(
			kHzClkFreq => 50000,
			mSecMinInWidth => 100,
			inPolarity => '0',
			outPolarity => '1'
		)
		PORT MAP(
			refClk => clock,
			dirtyIn => key0,
			pulsedOut => cleanKey0
		);

	DebounceKey1 : ENTITY work.DebounceUnit(Behavioral)
		GENERIC MAP(
			kHzClkFreq => 50000,
			mSecMinInWidth => 100,
			inPolarity => '0',
			outPolarity => '1'
		)
		PORT MAP(
			refClk => clock,
			dirtyIn => key1,
			pulsedOut => cleanKey1
		);

	DebounceKey2 : ENTITY work.DebounceUnit(Behavioral)
		GENERIC MAP(
			kHzClkFreq => 50000,
			mSecMinInWidth => 100,
			inPolarity => '0',
			outPolarity => '1'
		)
		PORT MAP(
			refClk => clock,
			dirtyIn => key2,
			pulsedOut => cleanKey2
		);
END Structural;