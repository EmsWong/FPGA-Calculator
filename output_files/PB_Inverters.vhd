--Group 15: Lily Wang and Emily Wong
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY PB_Inverters IS
	PORT
	(
		pb_n : IN std_logic_vector(3 downto 0); --button inputs
		pb : OUT std_logic_vector(3 downto 0) --button outputs
	);
END PB_Inverters;

ARCHITECTURE gates OF PB_Inverters IS

BEGIN

pb <= not(pb_n); --convert active low default to active high

END gates;