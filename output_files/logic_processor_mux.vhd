--Group 15: Lily Wang and Emily Wong
library ieee;
use ieee.std_logic_1164.all;

entity logic_processor_mux is
port ( 
	logic_in0, logic_in1							: in std_logic_vector(3 downto 0);		-- 4 bit input data
	mux_select 										: in std_logic_vector(1 downto 0); 		-- 00,01,10,11
	logic_processor_out 							: out std_logic_vector(3 downto 0) 		-- 4 bit data to be displayed
);
end logic_processor_mux;

architecture mux_logic of logic_processor_mux is

begin 

 -- for multiplexing of four hex input busses
 with mux_select(1 downto 0) select
 logic_processor_out <= (logic_in0 AND logic_in1) when "00",
								(logic_in0 OR logic_in1) when "01",
								(logic_in0 XOR logic_in1) when "10",
								(logic_in0 XNOR logic_in1) when "11";
				
end mux_logic;