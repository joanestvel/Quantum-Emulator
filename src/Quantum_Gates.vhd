library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use IEEE.math_real.all;
use work.Types.all;

entity Quantum_Gates is
	port
		(i_Select			:	in		std_logic_vector(3	downto	0)
		;o_CoefficientsRe	:	out	t_Coefficients
		;o_CoefficientsIm	:	out	t_Coefficients
		);
end entity;

Architecture rtl of Quantum_Gates is

begin
	process(i_Select)
		variable	v_Select	:	integer;
	begin
		v_Select	:=	to_integer(unsigned(i_Select));
		for i in 0 to 2**c_Order-1 loop
			for j in 0 to 2**c_Order-1 loop
				o_CoefficientsRe(i)(j)	<=	std_logic_vector(to_signed(c_Gates(v_Select,0)(i,j),c_bits));
				o_CoefficientsIm(i)(j)	<=	std_logic_vector(to_signed(c_Gates(v_Select,1)(i,j),c_bits));
			end loop;
		end loop;
	end process;
end rtl;