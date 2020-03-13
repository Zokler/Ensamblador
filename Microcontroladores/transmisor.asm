	ORG 00H

	MOV SCON, #00H ;puerto serio en modo 0 transmision
		;bit de aviso de transmision en 0
B0205:	MOV A, P0	;dato a transmitir
	MOV P1, A	;inicia la transmision
	MOV SBUF, A	;avisa que inicia la transmision
AQUI:	LCALL SUB1
	JNB P0.0, AQUI
B020B:	MOV A, SCON	
	JZ B020B	;hace el ciclo hasta que haga la transmision
	
	LCALL SUB1	;retardo
	;CLR TI	;borra la bandera para que pueda haber otra transmisión


AQUI2:	JB P0.0, AQUI2
	SJMP B0205
;retardoooooooo---------------------------------
SUB1:	MOV R0, #02
B0302:	 MOV R1, #03H
B0304:	 MOV R2, #05H
B0306:	 DJNZ R2, B0306
	 DJNZ R1, B0304
	 DJNZ R0, B0302
	 RET	
	 
	END
