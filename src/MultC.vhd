library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MultC is
	generic(g_bits:integer:=8);
	port
		(i_ReA:	in std_logic_vector(g_bits-1 downto 0)--Parte real de la entrada A
		;i_ImA:	in std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la entrada A
		;i_ReB:	in std_logic_vector(g_bits-1 downto 0)--Parte real de la entrada B
		;i_ImB:	in	std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la entrada B
		;o_Re:	out	std_logic_vector(g_bits-1 downto 0)--Parte real de la salida
		;o_Im:	out	std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la salida
		);
end entity;

architecture rtl of MultC is

	signal s_Temp0,s_Temp1,s_Temp2,s_Temp3:std_logic_vector(2*g_bits-1 downto 0);

begin

	s_Temp0	<=	std_logic_vector(signed(i_ReA)*signed(i_ReB));
	s_Temp1	<=	std_logic_vector(signed(i_ImA)*signed(i_ImB));
	s_Temp2	<=	std_logic_vector(signed(i_ReA)*signed(i_ImB));
	s_Temp3	<=	std_logic_vector(signed(i_ImA)*signed(i_ReB));
	
	o_Re	<=	std_logic_vector(signed(s_Temp0(2*g_bits-2 downto g_bits-1)) - signed(s_Temp1(2*g_bits-2 downto g_bits-1)));
	o_Im	<=	std_logic_vector(signed(s_Temp2(2*g_bits-2 downto g_bits-1)) + signed(s_Temp3(2*g_bits-2 downto g_bits-1)));

end rtl;