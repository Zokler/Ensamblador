	ORG 00H

	MOV 	P1, #33H
AQUI:	JNB 	P3.7, AQUI
	MOV 	A, P3
	CLR 	A.7
	MOV 	R0, A
	MOV 	P1, A
	MOV 	R7, #100D
ACA:	DJNZ 	R7, ACA

AQUI2:	JB 	P3.7, AQUI2
	MOV 	A, P3
	CLR 	A.7
	MOV 	R1, A
	MOV 	P1, A
	MOV 	R7, #100D
ACA2:	DJNZ 	R7, ACA2

AQUI3:	JNB 	P3.7, AQUI3
	MOV 	A, P3
	CLR 	A.7
	MOV 	R2, A
	MOV 	P1, A
	MOV 	R7, #100D
ACA3:	DJNZ 	R7, ACA3

INICIO:	JB 	P3.7, INICIO
	MOV	A, R0	;X
	SUBB	A, R1	;x-Y
	JC	MAY_YX	;C=1 -> X < Y
	
			;C=0 -> X > Y
	MOV A, R0	;X		
	SUBB A, R2	;X-Z
	JC	MAY_Z
	
	MOV A, R0
	MOV P1, A	;X ES EL MAYOR
	LJMP FIN
	;------------------------------------

MAY_YX:	
	MOV A, R1
	SUBB A, R2	;Y - Z	
	JC 	MAY_Z
	
	MOV A, R1
	MOV P1, A	;Y MAYOR
	LJMP FIN
	;-----------------------------------

MAY_Z:	
	MOV A, R2
	MOV P1, A
	LJMP FIN


FIN:	
	END
