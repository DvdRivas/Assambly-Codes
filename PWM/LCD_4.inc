
	CBLOCK
	DATO_LCD
	LCD_SAVED
	D1
	D2
	D3
	D4
	ENDC


LCD_SETUP
	BCF		EN
	BCF		RS
	CLRF	TRISD
	CALL	Retardo_5ms
	MOVLW	0X03
	CALL 	LCD_COMANDO
	CALL	Retardo_5ms	
	MOVLW	0X03
	CALL 	LCD_COMANDO
	CALL	Retardo_50us
	CALL	Retardo_50us
	CALL	Retardo_50us
	MOVLW	0X03
	CALL 	LCD_COMANDO
	MOVLW	0X02
	CALL	LCD_COMANDO
	CALL 	LCD_2LINEAS
	CALL	DISPLAY_ON
	CALL 	LCD_BORRA
	RETURN
LCD_RETURN_HOME
	MOVLW	0X02
	GOTO	LCD_SET
LCD_DECR
	MOVLW	0X04
	GOTO	LCD_SET
LCD_LINEA1
	MOVLW	0X10
	GOTO	LCD_SET
LCD_LINEA2
	MOVLW	0XC0
	GOTO	LCD_SET
LCD_CURSORON
	MOVLW	0X0E
	GOTO	LCD_SET
LCD_INCR
	MOVLW	0X06
	GOTO	LCD_SET
LCD_BORRA
	MOVLW	0X01
	GOTO	LCD_SET
DISPLAY_ON
	MOVLW	0X0C
	GOTO	LCD_SET
LCD_2LINEAS	
	MOVLW	0X28
	GOTO	LCD_SET

LCD_SET
	MOVWF	LCD_SAVED
	SWAPF	LCD_SAVED,W
	MOVWF	LCD_SAVED
	MOVF	LCD_SAVED,W
	CALL	LCD_COMANDO
	SWAPF	LCD_SAVED,W
	CALL	LCD_COMANDO
	RETURN
LCD_COMANDO
	ANDLW	B'00001111'	
	MOVWF	DATO_LCD
	MOVF	LATD,W
	ANDLW	B'11110000'
	IORWF	DATO_LCD,W
	MOVWF	LATD
	CALL	ENABLE
	RETURN

ENABLE
	;CALL	Retardo_2ms
	BSF	EN
	CALL	Retardo_2ms
	BCF	EN
	RETURN

LCD_CARACTER
	BSF		RS
	CALL	LCD_SET
	;CALL	Delay
	BCF		RS
	RETURN
Retardo_5ms	;14993 cycles ////////////////////////////////////////////////
	movlw	0xB6
	movwf	D1
	movlw	0x0C
	movwf	D2
Retardo_5ms_0
	decfsz	D1, f
	goto	S15ms
	decfsz	D2, f
S15ms	goto	Retardo_5ms_0
			;3 cycles
	goto	S25ms
	nop
S25ms		;4 cycles (including call)
	return

Retardo_2ms ;5993 cycles //////////////////////////////////////////////
	movlw	0xAE
	movwf	D1
	movlw	0x05
	movwf	D2
Retardo_2ms_0
	decfsz	D1, f
	goto	S12ms
	decfsz	D2, f
S12ms	goto	Retardo_2ms_0

			;3 cycles
	goto	S22ms
	nop
S22ms			;4 cycles (including call)
	return

Delay	;1499993 cycles ////////////////////////////////////////////
	movlw	0x0C
	movwf	D1
	movlw	0x46
	movwf	D2
	movlw	0x04
	movwf	D3
Retardo_500ms_0
	decfsz	D1, f
	goto	S1500ms
	decfsz	D2, f
S1500ms	goto	S2500ms
	decfsz	D3, f
S2500ms	goto	Retardo_500ms_0
			;3 cycles
	goto	S3500ms
	nop
S3500ms			;4 cycles (including call)
	return
Retardo_20ms	;59993 cycles ////////////////////////////////////////////////
	movlw	0xDE
	movwf	D1
	movlw	0x2F
	movwf	D2
Retardo_20ms_0
	decfsz	D1, f
	goto	S120ms
	decfsz	D2, f
S120ms	goto	Retardo_20ms_0
			;3 cycles
	goto	S220ms
	nop
S220ms
    Return
Retardo_50us	;145 cycles /////////////////////////////////////////////////
	movlw	0x30
	movwf	D1
Retardo_50us_0
	decfsz	D1, f
	goto	Retardo_50us_0
			;1 cycle
	nop
			;4 cycles (including call)
	return
