	CBLOCK 
	UNIDAD
	DECENA
	CENTENA
	ENDC

;SUBRUTINA
B2BCD
	CLRF	DECENA
	CLRF	CENTENA
SL1	
	MOVLW	D'10'
	SUBWF	UNIDAD,W
	BNC	SL2
	INCF	DECENA
	MOVWF	UNIDAD
	GOTO	SL1
	
SL2	MOVLW	D'10'
	SUBWF	DECENA,W
	BNC	ENDB2BCD
	INCF	CENTENA
	MOVWF	DECENA
	GOTO	SL2
ENDB2BCD
	RETURN