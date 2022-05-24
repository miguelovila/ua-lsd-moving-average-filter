LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY AddressGeneratorTb IS
END AddressGeneratorTb;

ARCHITECTURE Stimulus OF AddressGeneratorTb IS
	SIGNAL s_clock, s_reset, s_enable : STD_LOGIC;
	SIGNAL s_address : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	UUT : ENTITY work.AddressGenerator(Behavioral)
		PORT MAP(
			clock => s_clock,
			reset => s_reset,
			enable => s_enable,
			address => s_address
		);

clock_proc : PROCESS BEGIN
		s_clock <= '0';
		WAIT FOR 10 ns;
		s_clock <= '1';
		WAIT FOR 10 ns;
	END PROCESS;

stim_proc : PROCESS BEGIN
		s_enable <= '1';
		s_reset <= '1';
		WAIT FOR 20 ns;
		s_enable <= '1';
		s_reset <= '0';
		WAIT;
	END PROCESS;
END Stimulus;