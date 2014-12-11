* A partir de los valores de sus lados proporcionados en posiciones de memoria
* en 8 bits cada uno, enteros sin signo, determinar el tipo de triangulo.
* Indicar en ASCII si es "E"quilatero, "I"sosceles o "K" (Escaleno y Cristinista)

		ORG 		$0000		;Determinar el tipo de triangulo
L1		RMB  		1			;Longitud de lado 1
L2 		RMB  		1			;Idem lado 2
L3		RMB  		1			;Idem lado 3
TT		RMB  		1			
	
		ORG  		$8000		
		LDAA		L1
		CMPA 		L2			;Comparamos lado1 y lado2
		BEQ  		IsoEq1		;Si son iguales, asumimos que es Isosceles o Equilatero
		LDAA 		L2			;Sino, ahora comparo lado2 y lado3
		CMPA 		L3
		BEQ  		Isos		;Si son iguales es isosceles 
		LDAA		L1
		CMPA 		L3			;Faltaria comparar lado1 y lado3
		BEQ  		Isos		;Si son iguales ya confirmo que es isosceles
		LDAA 		#'K'		  ;Si tampoco son iguales, entonces es escaleno
Guardar	STAA 		TT			;Resultado confirmado!
FIN		BRA  		FIN
IsoEq1	CMPA 		L3			;Si lado1 y lado2 son iguales, comparo con lado3
		BNE  		Isos		;Si no son iguales ya se que es isosceles
		LDAA 		#'E'		;Si son iguales, es equilatero!
		BRA  		Guardar		
Isos	LDAA 		#'I'		;Observar el uso de modo inmediato
		BRA		    Guardar		;El tipo de triangulo lo indique con un caracter ASCII
