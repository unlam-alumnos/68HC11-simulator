			ORG $0000			; S = P + Q / (P Y Q SON DE 16 BITS) / DATOS: MSB DE P, Q Y S
S			RMB	1				; LOAD 508.S19 | PC 8000 | MEM 0 | 	A0,B0,C0,2
P			RMB 1				; MEM B0B1 | 1,0 | MEM C0C1 | 0,1
Q			RMB	1				; VALOR ESPERADO EN "S" ($A0A1):  1,1
LONG		RMB 1

			ORG $9000
SET_CARRY	SEC
			RTS
			
			ORG $8000
			LDAA	S		;;; +----------+
			INC		S		;;; | BLOQUE A |
			LDAB	S		;;;	+----------+
			LDX		#0		;;;
			XGDX			;;;
			LDA		LONG	;;;
REC_S		INX				;;; --> RECORRO EL VECTOR S HASTA LA ULTIMA POSICION
			DECA			;;; Y ALMACENO LA POSICION DE MEMORIA EN LA STACK POINTER
			BNE		REC_S	;;; PARA TENERLA DE REFERENCIA LUEGO.
			TXS				;;; --> 
			
			LDAA	P		;;; +----------+
			INC		P		;;; | BLOQUE B |
			LDAB	P		;;;	+----------+
			XGDX			;;;
			LDA		LONG	;;;
			DECA			;;;	-->RECORRO EL VECTOR P HASTA LA ULTIMA POSICION
REC_P		INX				;;; Y ALMACENO LA POSICION DE MEMORIA EN EL REGISTRO X
			DECA			;;; PARA TENERLA DE REFERENCIA LUEGO.
			BNE		REC_P	;;; -->
			
			LDAA	Q		;;; +----------+
			INC		Q		;;; | BLOQUE C |
			LDAB	Q		;;;	+----------+
			LDY		#0		;;;
			XGDY			;;;
			LDA		LONG	;;;
			DECA			;;; -->RECORRO EL VECTOR P HASTA LA ULTIMA POSICION
REC_Q		INY				;;; Y ALMACENO LA POSICION DE MEMORIA EN EL REGISTRO Y
			DECA			;;; PARA TENERLA DE REFERENCIA LUEGO.
			BNE		REC_Q	;;; -->
			
SUMA		LDA		0,X		;;; +----------+
			ADDA	0,Y		;;; | BLOQUE D |
			PSHA			;;;	+----------+
			DEX				;;;
			DEY				;;;
			DEC		LONG	;;;
			BNE		SUMA	;;;
			
			LDAB    #1
			CMPB	#1
			BNE		SET_CARRY
			
FIN			BRA		FIN