			ORG $0000			; S = P + Q / (P Y Q SON DE 16 BITS) / DATOS: MSB DE P, Q Y S
P			RMB 2				; LOAD 508.S19 | PC 8000 | MEM 0 | 	A0,B0,A0,B2
Q			RMB	2				; MEM A0B0 | 2,3,4,5
S			RMB	3				; VALOR ESPERADO EN "S" ($A0A1):  0608


			ORG $8000
SUMAR 		LDX	#0
			LDX P
			LDD 0,X
			LDX	Q
			ADDD 0,X
			STD S+1
			
			BCC CARRY0
			CLR S
			INC S
FIN 		BRA FIN

CARRY0 		CLR S
			BRA FIN
			
FIN			BRA		FIN