library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.ALL;
use work.Types.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity ADDRGen	is
	port
		(i_Qubits	:	in		t_QubitArray
		;i_C			:	in		std_logic_vector(c_Qubits-1	downto	0)
		;i_W			:	in		std_logic
		;i_Wc0		:	in		std_logic
		;i_Wc1		:	in		std_logic
		;i_Next		:	in		std_logic
		;i_Clk		:	in		std_logic
		;i_rst		:	in		std_logic
		;i_rc			:	in		std_logic
		;o_Addrs		:	out	t_AddrArray
		);
end entity;

architecture rtl of ADDRGen is

	type	t_State	is array (0 to c_Order-1)	of	std_logic_vector(c_Qubits-1	downto	0);

	signal	s_Qubits	:	t_QubitArray;
	signal	s_State	:	t_State;
	signal	s_Count	:	std_logic_vector(c_Qubits-1	downto	0);
	signal	s_Or		:	std_logic_vector(c_Qubits-1	downto	0);
	signal	s_Add		:	std_logic_vector(c_Qubits-1	downto	0);
	signal	s_C0		:	std_logic_vector(c_Qubits-1	downto	0);
	signal	s_C1		:	std_logic_vector(c_Qubits-1	downto	0);
begin
	A:	for i in 0 to c_Order-1	generate
			process(i_W,i_Clk)
				variable	v_Temp	:	std_logic_vector(c_log2Qubits-1	downto	0);
			begin
				if(rising_edge(i_Clk)) then
					if(i_W = '1') then
						v_Temp	:=	i_Qubits(i);
					end if;
				end if;
				s_Qubits(i)	<=	v_Temp;
			end process;
			
			process(s_Qubits(i))
				variable	v_Temp	:	integer;
				variable v_Temp2	:	std_logic_vector(c_Qubits-1	downto	0);
			begin
				v_Temp	:=	to_integer(unsigned(s_Qubits(i)));
				v_Temp2	:=	(others=>'0');
				v_TEmp2(v_Temp)	:=	'1';
				s_State(i)	<=	v_Temp2;
			end process;
		end generate;
	
	process(i_Clk,i_rc)
	begin
		if(i_rc = '1') then
			s_C0	<=	(others => '0');
			s_C1	<=	(others => '0');
		else
			if(rising_edge(i_Clk)) then
				if(i_Wc0 = '1') then
					s_C0	<=	i_C;
				end if;
				if(i_Wc1 = '1') then
					s_C1	<=	i_C;
				end if;
			end if;
		end if;
	end process;
		
	process(i_Next,i_Clk,i_rst)
		variable	v_Temp	:	std_logic_vector(c_Qubits-1	downto	0);
	begin
		if(i_rst	= '1') then
			v_Temp	:=	(others => '0');
		else
			if(rising_edge(i_Clk)) then
				if(i_Next = '1') then
					v_Temp	:=	s_Add;
				end if;
			end if;
		end if;
		s_Count	<=	v_Temp;
	end process;
	
	process(s_Count,s_State,s_C0)
		variable	v_Temp	:	std_logic_vector(c_Qubits-1	downto	0);
	begin
		v_Temp	:=	s_Count;
		for i in 0 to c_Order-1	loop
			v_Temp	:=	v_Temp	or	s_State(i);
		end loop;
		v_Temp	:=	v_Temp or s_C0;
		s_Or	<=	v_Temp;
	end process;
	
	s_Add	<=	std_logic_vector(unsigned(s_Or) + "1");
	
	process(s_Or,s_State,s_C1)
		variable	v_Temp	:	std_logic_vector(c_Qubits-1	downto	0);
	begin
		for i in 0 to 2**c_Order-1	loop
			v_Temp	:=	s_Or;
			for j in 0 to c_Order-1	loop
				if(to_unsigned(i,c_Order)(j) = '0')	then
					v_Temp	:=	v_Temp	and not(s_State(j));
				end if;
			end loop;
			o_Addrs(i)	<=	v_Temp xor s_C1;
		end loop;
	end process;
	
end rtl;