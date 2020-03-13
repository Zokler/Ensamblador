ORG 00H
LJMP INICIO
ORG  0023H
LJMP RUT
;
;-------------------------------------------------------------------------
;	Inicialización
	ORG 200H
INICIO:
B0200:	MOV IE, #90H 
	MOV SCON, #10H 
	LCALL RETARDO
	SJMP B0200
;
;------------------------------------------------------------------------
;	Rutina de RETARDO
	ORG 300H
RETARDO: MOV R0, #02
B0302:	 MOV R1, #0FFH
B0304:	 MOV R2, #0FFH
B0306:	 DJNZ R2, B0306
	 DJNZ R1, B0304
	 DJNZ R0, B0302
	 RET	
;
;-----------------------------------------------------------------------
;	Rutina de Interrupción

; Realiza las siguientes tareas:
;	1) Sale del modo de recepción.
;	2) Salva registros en el slack.
;	3) Carga el contenido de SBUF en el ACC.
;	4) Visualiza el dato en paralelo en el Pulerlo P0
;	5) Temporiza su visualizaci6n.
;	6) Repone los registros del slack. .
;
ORG	400H
RUT:
MOV	SCON, #00H 
MOV	A,R0 
PUSH ACC

MOV	A, R1
PUSH ACC
 
MOV	A, R2 
PUSH ACC

MOV	A, SBUF 
MOV	P1, A
LCALL RETARDO

POP	ACC
MOV	R2, A
POP	ACC
MOV	R1, A
POP	ACC
MOV	R0, A 
RETI

END
