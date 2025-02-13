--Group 15: Lily Wang and Emily Wong
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--performs the full adder 1 bit circuit in the lab2 pg.23 schematic form
--used as a component for the full adder 4 bit 

ENTITY full_adder_1bit IS
	PORT
	(
		INPUT_A, INPUT_B, CARRY_IN									: in std_logic;	
		FULL_ADDER_SUM, FULL_ADDER_CARRY							: out std_logic
	);
END full_adder_1bit;

ARCHITECTURE adder OF full_adder_1bit IS

signal HALF_ADDER_CARRY			: std_logic;
signal HALF_ADDER_SUM 			: std_logic;

BEGIN

HALF_ADDER_SUM <= (INPUT_A XOR INPUT_B) ;	
HALF_ADDER_CARRY <= (INPUT_A AND INPUT_B);
FULL_ADDER_SUM <= (HALF_ADDER_SUM XOR CARRY_IN); 
FULL_ADDER_CARRY <= HALF_ADDER_CARRY OR (HALF_ADDER_SUM AND CARRY_IN);

END adder;