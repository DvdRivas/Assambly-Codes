	CBLOCK
  	D1
	D2
	D3
	D4
	ENDC
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
