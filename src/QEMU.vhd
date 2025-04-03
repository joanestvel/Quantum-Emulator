library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.ALL;
use work.Types.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity QEMU is

	port
		(i_Clk		:	in		std_logic										--Clock Signal
		;i_rst		:	in		std_logic										--Reset Signal
		;i_Sta		:	in		std_logic_vector(1 downto 0)				--Start Signal
		
		;i_M			:	in		std_logic
		;i_Select	:	in		std_logic_vector(3 downto 0)
		;i_Q			:	in		t_QubitArray
		;i_Next		:	in		std_logic
		;i_Wc0		:	in		std_logic
		;i_Wc1		:	in		std_logic
		
		;i_StatesRe	:	in		t_StatesCores
		;i_StatesIm	:	in		t_StatesCores
		;i_C			:	in		std_logic_vector(c_Qubits-1 downto 0)
		;o_StatesRe	:	out	t_StatesCores
		;o_StatesIm	:	out	t_StatesCOres
		
		;o_Addr		:	out	t_AddrArray
		
		;o_NeedDat	:	out	std_logic
		;i_DReady	:	in		std_logic
		
		;o_Busy		:	out	std_logic
		;o_DReady	:	out	std_logic
		);

end entity;


architecture rtl of QEMU is

	Component Quantum_Processor is
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
	end component;
	
	component Quantum_Gates is
		port
			(i_Select			:	in		std_logic_vector(3	downto	0)
			;o_CoefficientsRe	:	out	t_Coefficients
			;o_CoefficientsIm	:	out	t_Coefficients
			);
	end component;
	
	component ADDRGen is
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
	end component;
	
	Component FSM is
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
	end component;
	
	--Moore Finite State Machine COntrol Signals
	signal s_Wi,s_Wo,s_WInst	:	std_logic;
	signal s_M						:	std_logic;
	signal s_Next					:	std_logic;
	signal s_End					:	std_logic;
	signal s_rst					:	std_logic;
	signal s_Statei				:	std_logic_vector(c_Qubits-1	downto	0);
	
	--Signals that connects all the components
	signal s_xRe,s_xIm	:	t_Coefficients;
	signal s_Select		:	std_logic_vector(3 downto 0);
	signal s_NClk			:	std_logic;
	signal s_Addr			:	t_AddrArray;
	

begin

	s_NClk	<=	not(i_Clk);
	o_Addr	<=	s_Addr;
	
	A:	Quantum_Processor	port map (i_StatesRe,i_StatesIm,s_xRe,s_xIm,s_Wi,s_Wo,s_NClk,o_StatesRe,o_StatesIm);
	
	B:	Quantum_Gates		port map (s_Select,s_xRe,s_xIm);
	
	C:	ADDRGen				port map (i_Q,i_C,s_WInst,i_Wc0,i_Wc1,s_Next,s_NClk,s_rst,i_rst,s_Addr);
	
	D:	FSM					port map (i_Clk,i_Sta,i_Next,s_M,s_End,i_DReady,i_rst,s_Wi,s_Wo,s_WInst,s_Next,o_NeedDat,o_DReady,s_rst,o_Busy);
	
	--End logic
	process(s_NClk,s_rst)
	begin
		if(s_rst = '1') then
			s_Statei	<=	(others => '0');
		else
			if(rising_edge(s_NClk)) then
				if(s_WInst = '1') then
					s_Statei	<=	s_Addr(0);
				end if;
			end if;
		end if;
	end process;
	s_End	<=	'1' when s_Statei = s_Addr(0) else
				'0';
	
	--Instruction Register (The objective Qubits register is in the ADDRGen component)
	process(s_NClk,i_rst,s_WInst)
	begin
		if(i_rst = '1') then
			s_Select	<=	(others => '0');
			s_M		<=	'0';
		else
			if(rising_edge(s_NClk)) then
				if(s_WInst = '1') then
					s_Select	<=	i_Select;
					s_M		<=	i_M;
				end if;
			end if;
		end if;
	end process;
	
end rtl;