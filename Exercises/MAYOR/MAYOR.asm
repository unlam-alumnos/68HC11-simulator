* De un vector: Datos -> Primer elemento y ultimo. Encontrar el mayor, 
* cantidad de repeticiones y primer posicion de memoria donde se encontro.
* ---------------------------
* Lote de prueba:
* LOAD MAYOR.S19 | PC 8000 | MEM 0 | 20,00,20,05,0,0,0,EXIT | MEM 2000 | 2,2,9,2,4,5,EXIT | RUN
* ---------------------------
* Resultado:
* $0004: 09 | $0005: 01 | $0006: 20 | $0007: 02
* ---------------------------

		ORG		$0000
P		RMB		2
U		RMB		2
MAY		RMB		1
CANT	RMB		1	
POS		RMB		2

		ORG 	$8000
		CLRA
		CLRB
		LDX		P		; CARGO LA POSICION DE P EN X
		LDAB	0,X		; CARGO EN B EL VALOR
		BRA		MAYOR
		
RECO	LDAB	0,X		; CARGO EL DATO DEL VECTOR EN B
		CBA				; COMPARO A CON B --> A - B
		BMI		MAYOR	; SI B > A ==> MAYOR
		BEQ		AGAIN	; SI B == A ==> AGAIN

MAYOR	TBA				; AHORA EL MAYOR ESTA EN A
		STAA	MAY		; GUARDO EL MAYOR
		CLR		CANT
		INC		CANT	; INCREMENTO LA CANTIDAD DE REPETICIONES
		STX		POS		; GUARDO LA POSICION DONDE SE ENCONTRO POR PRIMERA VEZ

MOVER	CPX		U		; SE TERMINO EL VECTOR?
		BEQ		FIN		; ENTONCES FIN
		INX				; SINO ME MUEVO EN EL VECTOR
		BRA		RECO
		
AGAIN	INC		CANT	; INCREMENTO CANTIDAD DE APARICIONES
		BRA		MOVER
		
FIN		BRA		FIN		