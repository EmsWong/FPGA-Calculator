--Group 15: Lily Wang and Emily Wong
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;



ENTITY full_adder_4bit IS
	PORT
	(
		INPUT_A, INPUT_B 														: in std_logic_vector(3 downto 0);  -- 4 bit input data
		SUM																		: out std_logic_vector(3 downto 0);	-- 4 bit sum 
		FULL_ADDER_4															: out std_logic		      			-- carry
	);
END full_adder_4bit;

ARCHITECTURE adder OF full_adder_4bit IS

	component full_adder_1bit port(
			INPUT_A							: in std_logic;
			INPUT_B							: in std_logic;
			CARRY_IN							: in std_logic;
			FULL_ADDER_SUM					: out std_logic;
			FULL_ADDER_CARRY				: out std_logic
		);
	end component;

	signal CARRY : std_logic_vector(3 downto 0);

BEGIN
	--takes in one bit of the input_A and input_B to produce 1bit outputs
	--daisy chaining four 1bit adders, each 1bit adder takes in carry of the previous adder, except the first 1bit adder which takes in a 0
	--1bit sum outputs are mapped to one bit of the 4bit adder sum
	INST1: full_adder_1bit port map(INPUT_A(0), INPUT_B(0), '0', SUM(0), CARRY(0));			
	INST2: full_adder_1bit port map(INPUT_A(1), INPUT_B(1), CARRY(0), SUM(1), CARRY(1));
	INST3: full_adder_1bit port map(INPUT_A(2), INPUT_B(2), CARRY(1), SUM(2), CARRY(2));
	INST4: full_adder_1bit port map(INPUT_A(3), INPUT_B(3), CARRY(2), SUM(3), CARRY(3));
	
	FULL_ADDER_4 <= CARRY(3) ; --carry of the 4bit adder is assigned to FULL_ADDER_4

END adder;