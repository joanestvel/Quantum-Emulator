library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.Types.all;

entity QS is
	port
		(i_StatesRe	:	in	t_states
		;i_StatesIm	:	in	t_states
		;i_xRe		:	in	t_states
		;i_xIm		:	in	t_states
		;o_StateRe	:	out	std_logic_vector(c_bits-1 downto 0)
		;o_StateIm	:	out	std_logic_vector(c_bits-1 downto 0)
		);
end entity;

Architecture rtl of QS is

	component MultC is
		generic(g_bits:integer:=8);
		port
			(i_ReA:	in std_logic_vector(g_bits-1 downto 0)--Parte real de la entrada A
			;i_ImA:	in std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la entrada A
			;i_ReB:	in std_logic_vector(g_bits-1 downto 0)--Parte real de la entrada B
			;i_ImB:	in	std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la entrada B
			;o_Re:	out	std_logic_vector(g_bits-1 downto 0)--Parte real de la salida
			;o_Im:	out	std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la salida
			);
	end component;
	
	signal	s_TempRe		:	t_States;
	signal	s_TempIm		:	t_States;

begin
	A:	for i in 0 to 2**c_Order-1 generate
			AA:	MultC	port map (i_StatesRe(i),i_StatesIm(i),i_xRe(i),i_xIm(i),s_TempRe(i),s_TempIm(i));
		end generate;
	
	process(s_TempRe,s_TempIm)
		variable	v_TempRe	:	integer;
		variable v_TempIm	:	integer;
	begin
		v_TempRe	:=	0;
		v_TempIm	:=	0;
		for i in 0 to 2**c_Order-1 loop
			v_TempRe	:=	v_TempRe + to_integer(unsigned(s_TempRe(i)));
			v_TempIm	:=	v_TempIm	+ to_integer(unsigned(s_TempIm(i)));
		end loop;
		o_StateRe	<=	std_logic_vector(to_unsigned(v_TempRe,c_bits));
		o_StateIm	<=	std_logic_vector(to_unsigned(v_TempIm,c_bits));
	end process;
end rtl;