ORG 00H
	MOV P1, #00H	;TODOS LOS LEDS DE P1 APAGADOS
	MOV TMOD, #51H	;TIMER 1 16 BITS CONTADOR PULSOS EXTERNOS / TEMPORIZADOR TIMER 0 16 BITS 
	LCALL FILLT1	;Llena el TH1 Y TL1
	SETB TR1	;INICIA CONTEO TIMER1 	
MAIN:	MOV R7, #5CH	;6 SEGUNDOS PARA USAR DESPUES
	MOV R6, #0FH	;1 SEGUNDO PARA USAR DESPUES
	CLR P1.7	;APAGA EL LED DEL CONTEO, SE USA PARA DESPUÉS
	SETB P1.0	;ENCIENDE LED P1.0	
	LCALL SEIS_SEG	;PASAN 6 SEGUNDOS
	CLR P1.0	;APAGA LED P1.0
	LCALL UN_SEG	;PASA 1 SEGUNDO
	LJMP MAIN
;;;;;;;;;;;;;;;;;;;;FUNCIONES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SEIS_SEG:
OFF:
	MOV TL0, #00H	;INICIALIZACION
	MOV TH0, #00H
	SETB TR0	;INICIA TIMER0
REPETIR:MOV A, TCON
	JNB A.7, CONT_AQUI	;si no hay bit en la bandera TF1 continua a la siguiente instrucción / si hay haz lo que sigue en la siguiente linea
	LCALL ON_TF1	;HUBO BANDERA TF1
CONT_AQUI:ANL A, #20H		;limpia el acumulador con 0010-0000 (bandera TF0)	
	JZ REPETIR
	CLR TR0 ;SE APAGA EL TIMER 0
	CLR TF0	;LIMPIO BANDERA
	DJNZ R7, OFF
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UN_SEG:
OFF1:
	MOV TL0, #00H
	MOV TH0, #00H
	SETB TR0
REPETIR1:MOV A, TCON
	JNB A.7, CONT_AQUI1	;si no hay bit en la bandera TF1 continua a la siguiente instrucción / si hay haz lo que sigue en la siguiente linea
	LCALL ON_TF1	;;;;;;;;;;;;;;;;;;
CONT_AQUI1:ANL A, #20H		;limpia el acumulador con 0010-0000 (bandera TF0)	
	JZ REPETIR1
	CLR TR0 ;SE APAGA EL TIMER 0
	CLR TF0	;LIMPIO BANDERA	
	DJNZ R6, OFF1
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ON_TF1:
	SETB P1.7	;ENCIENDE EL LED EN P1.7
	CLR TF1		;BORRA BANDERA
	LCALL FILLT1	;RELLENA TH1 Y TL1
	LCALL DELAY	;DELAY PARA MOSTRAR EL LED
	CLR P1.7
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FILLT1:	MOV TL1, #0FAH
	MOV TH1, #0FFH
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY:
	MOV	R2, #004h
	MOV	R1, #0FAh
	MOV	R0, #0F8h
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	RET	
	END 
 
