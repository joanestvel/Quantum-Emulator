-- Quartus Prime VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity FSM is

	port(
		clk			:	in		std_logic;
		i_Sta			:	in		std_logic;
		i_Next		:	in		std_logic;
		i_M			:	in		std_logic;
		i_End			:	in		std_logic;
		i_DReady		:	in		std_logic;
		reset			:	in		std_logic;
		o_Wi			:	out	std_logic;
		o_Wo			:	out	std_logic;
		o_WInst		:	out	std_logic;
		o_Next		:	out	std_logic;
		o_NeedDat	:	out	std_logic;
		o_DReady		:	out	std_logic;
		o_rst			:	out	std_logic;
		o_Busy		:	out	std_logic
	);

end entity;

architecture rtl of FSM is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5, s6);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0 =>
					if i_Sta = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1 =>
					state	<=	s2;
				when s2 =>
					if i_DReady = '1' then
						state <= s3;
					else
						state <= s2;
					end if;
				when s3 =>
					state	<=	s4;
				when s4 =>
					if i_M = '0' then
						state	<=	s5;
					else
						if i_Next = '1' then
							state	<=	s6;
						else
							state	<=	s4;
						end if;
					end if;
				when s5 =>
					if i_DReady = '1' then
						state	<=	s6;
					else
						state	<=	s5;
					end if;
				when s6 =>
					if i_End = '1' then
						state	<=	s0;
					else
						state	<=	s2;
					end if;
				when others =>
					Null;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				o_Wi			<=	'0';
				o_Wo			<=	'0';
				o_WInst		<=	'0';
				o_Next		<=	'0';
				o_NeedDat	<=	'0';
				o_DReady		<=	'0';
				o_rst			<=	'1';
				o_Busy		<=	'0';
			when s1 =>
				o_Wi			<=	'0';
				o_Wo			<=	'0';
				o_WInst		<=	'1';
				o_Next		<=	'0';
				o_NeedDat	<=	'0';
				o_DReady		<=	'0';
				o_rst			<=	'0';
				o_Busy		<=	'1';
			when s2 =>
				o_Wi			<=	'0';
				o_Wo			<=	'0';
				o_WInst		<=	'0';
				o_Next		<=	'0';
				o_NeedDat	<=	'1';
				o_DReady		<=	'0';
				o_rst			<=	'0';
				o_Busy		<=	'1';
			when s3 =>
				o_Wi			<=	'1';
				o_Wo			<=	'0';
				o_WInst		<=	'0';
				o_Next		<=	'0';
				o_NeedDat	<=	'0';
				o_DReady		<=	'0';
				o_rst			<=	'0';
				o_Busy		<=	'1';
			when s4 =>
				o_Wi			<=	'0';
				o_Wo			<=	'1';
				o_WInst		<=	'0';
				o_Next		<=	'0';
				o_NeedDat	<=	'0';
				o_DReady		<=	'0';
				o_rst			<=	'0';
				o_Busy		<=	'1';
			when s5 =>
				o_Wi			<=	'0';
				o_Wo			<=	'0';
				o_WInst		<=	'0';
				o_Next		<=	'0';
				o_NeedDat	<=	'0';
				o_DReady		<=	'1';
				o_rst			<=	'0';
				o_Busy		<=	'1';
			when s6 =>
				o_Wi			<=	'0';
				o_Wo			<=	'0';
				o_WInst		<=	'0';
				o_Next		<=	'1';
				o_NeedDat	<=	'0';
				o_DReady		<=	'0';
				o_rst			<=	'0';
				o_Busy		<=	'1';
			when others =>
				NULL;
		end case;
	end process;

end rtl;
