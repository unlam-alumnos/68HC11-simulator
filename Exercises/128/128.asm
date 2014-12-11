		ORG 	$0000
DATO	RMB		1
RES		RMB		1

		ORG		$8000
		LDAA	DATO
		CMPA	#128

		BEQ		IGUAL
		BLO		MENOR
		BHI		MAYOR

IGUAL	LDAB	#'='	; "=" = $3D
		STAB	RES
		BRA 	FIN
		
MENOR	LDAB	#'<'	; "<" = $3C
		STAB	RES
		BRA 	FIN

MAYOR	LDAB	#'>'	; ">" = $3E
		STAB	RES
		BRA 	FIN		

FIN		BRA		FIN