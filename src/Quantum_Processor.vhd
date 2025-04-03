library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.Types.all;

entity Quantum_Processor is
	port
		(i_StatesRe	:	in		t_StatesCores
		;i_StatesIm	:	in		t_StatesCores
		;i_xRe		:	in		t_Coefficients
		;i_xIm		:	in		t_Coefficients
		;i_Wi			:	in		std_logic
		;i_Wo			:	in		std_logic
		;i_Clk		:	in		std_logic
		;o_StatesRe	:	out	t_StatesCores
		;o_StatesIm	:	out	t_StatesCOres
		);
end entity;

Architecture rtl of Quantum_Processor is
	
	component Quantum_Core is
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
	end component;
	
begin
	A:	for i in 0 to c_Cores-1 generate
			AA:	Quantum_Core	port map (i_StatesRe(i)	,i_StatesIm(i)	,i_xRe	,i_xIm	,i_Wi	,i_Wo	,i_Clk	,o_StatesRe(i)	,o_StatesIm(i));
		end generate;
end rtl;