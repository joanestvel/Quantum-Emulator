library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.ALL;

package types is
	constant	c_Order			:	integer		:=	2;
	constant	c_Qubits			:	integer		:=	32;
	constant	c_bits			:	integer		:=	8;
	constant	c_Cores			:	integer		:=	1;
	constant	c_log2Qubits	:	integer	:=	integer(ceil(log2(real(c_Qubits))));
	
	type	t_QubitArray	is array (0 to c_Order-1) 								of std_logic_vector(c_log2Qubits-1	downto	0);
	type	t_AddrArray		is array (0 to 2**c_Order-1)							of std_logic_vector(c_Qubits-1		downto	0);
	type	t_States			is array (0 to 2**c_Order-1)							of	std_logic_vector(c_bits-1			downto	0);
	type	t_Coefficients	is array (0 to 2**c_Order-1)							of t_States;
	type	t_StatesCores	is array (0 to c_Cores-1)								of t_States;
	type	t_Gates			is array (0 to 2**c_Order-1,0 to 2**c_Order-1)	of integer;
	type	t_LUT				is array (0 to 15,0 to 1) of t_Gates;
	
	--I Gate
	constant	c_IIRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,127	,0		,0		)
													,(0	,0		,127	,0		)
													,(0	,0		,0		,127	)
													);
	constant	c_IIIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--X(Q0) Gate
	constant	c_IXRe	:	t_Gates	:=	
													((0	,127	,0		,0		)
													,(127	,0		,0		,0		)
													,(0	,0		,0		,127	)
													,(0	,0		,127	,0		)
													);
	constant	c_IXIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--X(Q1) Gate	
	constant	c_XIRe	:	t_Gates	:=	
													((0	,0		,127	,0		)
													,(0	,0		,0		,127	)
													,(127	,0		,0		,0		)
													,(0	,127	,0		,0		)
													);
	constant	c_XIIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--X(Q1,Q0) Gate
	constant	c_XXRe	:	t_Gates	:=	
													((0	,0		,0		,127	)
													,(0	,0		,127	,0		)
													,(0	,127	,0		,0		)
													,(127	,0		,0		,0		)
													);
	constant	c_XXIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--Z(Q0)	Gate
	constant	c_IZRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,-127	,0		,0		)
													,(0	,0		,127	,0		)
													,(0	,0		,0		,-127	)
													);
	constant	c_IZIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--Z(Q1)	Gate
	constant	c_ZIRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,127	,0		,0		)
													,(0	,0		,-127	,0		)
													,(0	,0		,0		,-127	)
													);
	constant	c_ZIIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--Z(Q1,Q0)	Gate
	constant	c_ZZRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,-127	,0		,0		)
													,(0	,0		,-127	,0		)
													,(0	,0		,0		,127	)
													);
	constant	c_ZZIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--H(Q0)	Gate
	constant	c_IHRe	:	t_Gates	:=	
													((91	,91	,0		,0		)
													,(91	,-91	,0		,0		)
													,(0	,0		,91	,91	)
													,(0	,0		,91	,-91	)
													);
	constant	c_IHIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--H(Q1)	Gate
	constant	c_HIRe	:	t_Gates	:=	
													((91	,0		,91	,0		)
													,(0	,91	,0		,91	)
													,(91	,0		,-91	,0		)
													,(0	,91	,0		,-91	)
													);
	constant	c_HIIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--H(Q1,Q0)	Gate
	constant	c_HHRe	:	t_Gates	:=	
													((64	,64	,64	,64	)
													,(64	,-64	,64	,-64	)
													,(64	,64	,-64	,-64	)
													,(64	,-64	,-64	,64	)
													);
	constant	c_HHIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	--S(Q0)	Gate
	constant	c_ISRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,127	,0		)
													,(0	,0		,0		,0		)
													);
	constant	c_ISIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,127	,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,127	)
													);
	--S(Q1)	Gate
	constant c_SIRe	:	t_Gates	:=
													((127	,0		,0		,0		)
													,(0	,127	,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													);
	constant c_SIIm	:	t_Gates	:=
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,127	,0		)
													,(0	,0		,0		,127	)
													);
	--S(Q1,Q0)	Gate
	constant c_SSRe	:	t_Gates	:=
													((127	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,-127	)
													);
	constant c_SSIm	:	t_Gates	:=
													((0	,0		,0		,0		)
													,(0	,127	,0		,0		)
													,(0	,0		,127	,0		)
													,(0	,0		,0		,0		)
													);
	--T(Q0)	Gate
	constant	c_ITRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,91	,0		,0		)
													,(0	,0		,127	,0		)
													,(0	,0		,0		,91	)
													);
	constant	c_ITIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,91	,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,0		,91	)
													);
	--T(Q1)	Gate
	constant	c_TIRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,127	,0		,0		)
													,(0	,0		,91	,0		)
													,(0	,0		,0		,91	)
													);
	constant	c_TIIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,0		,0		,0		)
													,(0	,0		,91	,0		)
													,(0	,0		,0		,91	)
													);
	--T(Q1,Q0)	Gate
	constant	c_TTRe	:	t_Gates	:=	
													((127	,0		,0		,0		)
													,(0	,91	,0		,0		)
													,(0	,0		,91	,0		)
													,(0	,0		,0		,0		)
													);
	constant	c_TTIm	:	t_Gates	:=	
													((0	,0		,0		,0		)
													,(0	,91	,0		,0		)
													,(0	,0		,91	,0		)
													,(0	,0		,0		,127	)
													);
	
	constant	c_Gates	:	t_LUT		:=	
													((c_IIRe,c_IIIm),(c_IXRe,c_IXIm),(c_XIRe,c_XIIm),(c_XXRe,c_XXIm)
													,(c_IZRe,c_IZIm),(c_ZIRe,c_ZIIm),(c_ZZRe,c_ZZIm),(c_IHRe,c_IHIm)
													,(c_HIRe,c_HIIm),(c_HHRe,c_HHIm),(c_ISRe,c_ISIm),(c_SIRe,c_SIIm)
													,(c_SSRe,c_SSIm),(c_ITRe,c_ITIm),(c_TIRe,c_TIIm),(c_TTRe,c_TTIm)
													);
	
end package;