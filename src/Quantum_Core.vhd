library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.Types.all;

entity Quantum_Core is
	port
		(i_StatesRe	:	in		t_States
		;i_StatesIm	:	in		t_States
		;i_xRe		:	in		t_Coefficients
		;i_xIm		:	in		t_Coefficients
		;i_Wi			:	in		std_logic
		;i_Wo			:	in		std_logic
		;i_Clk		:	in		std_logic
		;o_StatesRe	:	out	t_States
		;o_StatesIm	:	out	t_States
		);
end entity;

Architecture rtl of Quantum_Core is

	component QS is
		port
			(i_StatesRe	:	in	t_states
			;i_StatesIm	:	in	t_states
			;i_xRe		:	in	t_states
			;i_xIm		:	in	t_states
			;o_StateRe	:	out	std_logic_vector(c_bits-1 downto 0)
			;o_StateIm	:	out	std_logic_vector(c_bits-1 downto 0)
			);
	end component;
	
	signal s_itRegRe	:	t_States;
	signal s_itRegIm	:	t_States;
	signal s_otRegRe	:	t_States;
	signal s_otRegIm	:	t_States;

begin
	A:	for i in 0 to 2**c_Order-1 generate
			process(i_StatesRe(i),i_StatesIm(i),i_Clk,i_Wi)
				variable	v_TempRe	:	std_logic_vector(c_bits-1 downto 0);
				variable	v_TempIm	:	std_logic_vector(c_bits-1 downto 0);
			begin
				if(rising_edge(i_Clk)) then
					if(i_Wi = '1') then
						v_TempRe	:=	i_StatesRe(i);
						v_TempIm	:=	i_StatesIm(i);
					end if;
				end if;
				s_itRegRe(i)	<=	v_TempRe;
				s_itRegIm(i)	<=	v_TempIm;
			end process;
			
			process(s_otRegRe(i),s_otRegIm(i),i_Clk,i_Wo)
				variable	v_TempRe	:	std_logic_vector(c_bits-1 downto 0);
				variable	v_TempIm	:	std_logic_vector(c_bits-1 downto 0);
			begin
				if(rising_edge(i_Clk)) then
					if(i_Wo = '1') then
						v_TempRe	:=	s_otRegRe(i);
						v_TempIm	:=	s_otRegIm(i);
					end if;
				end if;
				o_StatesRe(i)	<=	v_TempRe;
				o_StatesIm(i)	<=	v_TempIm;
			end process;
		end generate;
	
	B:	for i in 0 to 2**c_Order-1 generate
			BA:	QS	port map	(s_itRegRe,s_itRegIm,i_xRe(i),i_xIm(i),s_otRegRe(i),s_otRegIm(i));
		end generate;
end rtl;