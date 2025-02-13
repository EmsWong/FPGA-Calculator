--Group 15: Lily Wang and Emily Wong
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0); -- The push button inputs
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content 
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
	
	-- Inverts pb from low to high
	component PB_Inverters port(
		pb_n : in std_logic_vector(3 downto 0);			-- pbutton inputs
		pb : OUT std_logic_vector(3 downto 0) 				-- pbutton outputs
	);
	end component;
	
	-- Multiplexer for selecting between two 4-bit inputs based on a 2-bit select signal
	component logic_processor_mux port(
		logic_in0 							: in std_logic_vector(3 downto 0); -- 4 bit input data
		logic_in1 							: in std_logic_vector(3 downto 0); -- 4 bit input data
		mux_select 							: in std_logic_vector(1 downto 0); -- 00,01,10,11
		logic_processor_out 				: out std_logic_vector(3 downto 0) -- 4 bit data to be displayed
	
	);
	end component;
	
	-- 4-bit full adder with carry output
	component full_adder_4bit port(
			INPUT_A							: in std_logic_vector(3 downto 0); 	-- 4 bit input data
			INPUT_B							: in std_logic_vector(3 downto 0); 	-- 4 bit input data
			SUM								: out std_logic_vector(3 downto 0);	-- 4 bit sum 
			FULL_ADDER_4					: out std_logic		      			-- carry
		);
	end component;
	
	--  2-to-1 multiplexer for selecting between two 4-bit inputs
	component mux_2to1 port(
		logic_in0 							: in std_logic_vector(3 downto 0);  -- 4 bit input
		logic_in1 							: in std_logic_vector(3 downto 0);	-- 4 bit input
		mux_select 							: in std_logic;							-- 0 or 1
		logic_out			 				: out std_logic_vector(3 downto 0)	-- 4 bit output
	
	);
	end component;
	
	-- Decoder for converting 4-bit input to 7-segment display
	component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	-- Mux for selecting between two 7-segment outputs and controlling which segment to display
	component segment7_mux port(
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0);
		DIN1		: in std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;								
		DIG1		: out std_logic
	);
	end component;	
	
-- Create any signals, or temporary variables to be used
--
-- Temporary signals to be used in instances and assignments, act as instance inputs and outputs
--
	signal hex_A						: std_logic_vector(3 downto 0);		
	signal hex_B						: std_logic_vector(3 downto 0);
	
	signal seg7_A						: std_logic_vector(6 downto 0);
	signal seg7_B						: std_logic_vector(6 downto 0);
	
	signal pb							: std_logic_vector(3 downto 0);
	
	signal sum 							: std_logic_vector(3 downto 0);
	signal carry 						: std_logic;
	signal signal_concat 			: std_logic_vector(3 downto 0);
	
	signal mux_outA					: std_logic_vector(3 downto 0);
	signal mux_outB					: std_logic_vector(3 downto 0);
		

-- Here the circuit begins

begin

	hex_A <= sw(3 downto 0);  -- hex_A correspond to switches 0-3
	hex_B <= sw(7 downto 4);  -- hex_B correspond to switches 4-7
	
	
	
--COMPONENT HOOKUP
	
	INST1: PB_Inverters port map(pb_n, pb); --invert all push buttons to active high
	
	INST2: logic_processor_mux port map(hex_B, hex_A, pb(1 downto 0), leds(3 downto 0)); -- takes in switches and process logic operators to display on leds 0-3
	
	INST3: full_adder_4bit port map(hex_A, hex_B, sum, carry); -- takes in switches and produces 4 bit sum and carry
	
	signal_concat <= "000" & carry; -- concatenation of 0s and carry -> 0001 or 0000
	
	INST4: mux_2to1 port map(hex_A, sum, pb(2), mux_outA); -- mux_outA equals hex_A when pb[2] is 0, and sum when pb[2] is 1
	
	INST5: mux_2to1 port map(hex_B, signal_concat, pb(2), mux_outB);	-- mux_outB equals hex_B when pb[2] is 0, and signal_concat when pb[2] is 1
	
	INST6: SevenSegment port map(mux_outA, seg7_A); --turns 4 bit mux_outA into 7seg for display
	
	INST7: SevenSegment port map(mux_outB, seg7_B); --turns 4 bit mux_outB into 7seg for display
	
	INST8: segment7_mux port map(clkin_50, seg7_B, seg7_A, seg7_data, seg7_char1, seg7_char2); --produces display for FPGA
	
 
end SimpleCircuit;















