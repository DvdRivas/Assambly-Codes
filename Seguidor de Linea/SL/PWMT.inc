PWM
	CLRF	TEMP
	MOVFF	CENTENA,TEMP
	RRNCF	TEMP	
	CALL	SOR	
	CALL	BARRIDO
	RETURN