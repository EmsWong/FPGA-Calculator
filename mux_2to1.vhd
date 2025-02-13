--Group 15: Lily Wang and Emily Wong
library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1 is
port ( 
	logic_in0, logic_in1							: in std_logic_vector(3 downto 0); --4 bit input
	mux_select									   : in std_logic;						  --0 or 1
	logic_out					    				: out std_logic_vector(3 downto 0) --4 bit output
);	
end mux_2to1;

architecture mux_logic of mux_2to1 is

begin 

 with mux_select select
 logic_out <= logic_in0 when '0',	--logic_out equals logic_in0 when mux is 0
				  logic_in1 when '1';	--logic_out equals logic_in1 when mux is 1
				
end mux_logic;