	CBLOCK
	D1
	D2
	D3
	D4
	ENDC
;=============================================================================
DELAY10US
	movlw	0x6E
	movwf	D1
	movlw	0x18
	movwf	D2
Delay_0
	decfsz	D1, f
	goto	SALTO1
	decfsz	D2, f
SALTO1	goto	Delay_0

	GOTO SALTO2
SALTO2	NOP
	RETURN

