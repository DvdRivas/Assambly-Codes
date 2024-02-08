; PLANTILLA DE PROGRAMA PARA TRABAJAR CON LA TARJETA MIUVA 18F45K50
; CON OSCILADOR EXTERNO TRABAJANDO A 12 MHz
LIST p=18F45K50
#include <P18F45K50.inc>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------- BITS DE CONFIGURACION --------------;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; CONFIG1L
  CONFIG  PLLSEL = PLL3X        ; PLL Selection (4x clock multiplier)
  CONFIG  CFGPLLEN = OFF        ; PLL Enable Configuration bit (PLL Disabled (firmware controlled))
  CONFIG  CPUDIV = NOCLKDIV     ; CPU System Clock Postscaler (CPU uses system clock (no divide))
  CONFIG  LS48MHZ = SYS24X4     ; Low Speed USB mode with 48 MHz system clock (System clock at 24 MHz, USB clock divider is set to 4)

; CONFIG1H
  CONFIG  FOSC = HSM     ; Oscillator Selection (Internal oscillator, clock output on OSC2)
  CONFIG  PCLKEN = ON           ; Primary Oscillator Shutdown (Primary oscillator enabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  nPWRTEN = ON         ; Power-up Timer Enable (Power up timer disabled)
  CONFIG  BOREN = OFF           ; Brown-out Reset Enable (BOR disabled in hardware (SBOREN is ignored))
  CONFIG  BORV = 190            ; Brown-out Reset Voltage (BOR set to 1.9V nominal)
  CONFIG  nLPBOR = OFF          ; Low-Power Brown-out Reset (Low-Power Brown-out Reset disabled)

; CONFIG2H
  CONFIG  WDTEN = OFF           ; Watchdog Timer Enable bits (WDT disabled in hardware (SWDTEN ignored))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscaler (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = RC1          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<5:0> pins are configured as digital I/O on Reset)
  CONFIG  T3CMX = RC0           ; Timer3 Clock Input MUX bit (T3CKI function is on RC0)
  CONFIG  SDOMX = RC7           ; SDO Output MUX bit (SDO function is on RB3)
  CONFIG  MCLRE = ON           ; Master Clear Reset Pin Enable (RE3 input pin enabled; external MCLR disabled)

; CONFIG4L
  CONFIG  STVREN = ON          ; Stack Full/Underflow Reset (Stack full/underflow will not cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port Enable (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled)

; CONFIG5L
  CONFIG  CP0 = OFF             ; Block 0 Code Protect (Block 0 is not code-protected)
  CONFIG  CP1 = OFF             ; Block 1 Code Protect (Block 1 is not code-protected)
  CONFIG  CP2 = OFF             ; Block 2 Code Protect (Block 2 is not code-protected)
  CONFIG  CP3 = OFF             ; Block 3 Code Protect (Block 3 is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protect (Boot block is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protect (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Block 0 Write Protect (Block 0 (0800-1FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Block 1 Write Protect (Block 1 (2000-3FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Block 2 Write Protect (Block 2 (04000-5FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Block 3 Write Protect (Block 3 (06000-7FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Registers Write Protect (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protect (Boot block (0000-7FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protect (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Block 0 Table Read Protect (Block 0 is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Block 1 Table Read Protect (Block 1 is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Block 2 Table Read Protect (Block 2 is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Block 3 Table Read Protect (Block 3 is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protect (Boot block is not protected from table reads executed in other blocks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------- Declaracion de variables --------;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CBLOCK 0X000
	MILLAR
	CENTENA
	DECENA 
	UNIDAD
	COUNT
	D1
	D2
	D3
	D4
	VA
	VB	
	CARACTER
	COUNTER
	ENDC
	#DEFINE	RS LATD,5
	#DEFINE EN LATD,4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------ INICIO DE PROGRAMA PRINCIPAL ----;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	org	0X0000
	goto	start

;======================================================================================
; SECCION DE CONFIGURACION POR SOFTWARE
start	 
	MOVLW	H'0F'
	MOVWF	ADCON1


;======================================================================================

; CONFIGURACION DE PUERTOS
	MOVLB	0XF
	CLRF	LATA
	CLRF	ANSELA
	BSF		ANSELA,0
	BSF		ANSELA,1
	CLRF	TRISA
	BSF		TRISA,0
	BSF		TRISA,1
	MOVLB	0XF
	CLRF	ADCON0	;CONFIGURACION DEL PRIMER SENSOR
	BSF		ADCON0,0 ;SE SELCCIONA EL AN0 Y SE HABILITA EL ADC
	MOVLW	0X05
	MOVWF	ADCON0
	CLRF	ADCON1	;SE DEJAN LAS REFERENCIAS INTERNAS
	CLRF	ADCON2	;SE DEJA UN TAD DE 0
	BSF		ADCON2,7	;JUSTIFICADO A LA DERECHA
	BCF		ADCON2,2
	BSF		ADCON2,1
	BCF		ADCON2,0	;FOSC/32

	
	CLRF	LATD
	CLRF	ANSELD
	CLRF	TRISD


;INICIALIZACION DE LAS INTERRUPCIONES
	BCF INTCON,TMR0IE
	BCF	INTCON,TMR0IF
	BSF	T0CON,TMR0ON	;HABILITAR EL TIMER 0
	BCF	T0CON,T08BIT	;ACTIVAR EL MODO DE 16 BITS
	BSF	T0CON,T0CS		;INHABILITA EL RELOJ INTERNO COMO CONTADOR
	BCF	T0CON,T0SE		;SE SELECCIONA UN FILO DE SUBIDA 
	BSF	T0CON,PSA		;SE INHABILITA EL PREESCALADOR
;fin de configuacion
	
;======================================================================================
; PROGRAMA PRINCIPAL
	CALL	LCD_SETUP
LOOP

	CALL 	SENSOR1
	CALL 	B2BCD
	CALL	LCD_RETURN_HOME
	RLNCF	MILLAR,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	RLNCF	CENTENA,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	RLNCF	DECENA,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	RLNCF	UNIDAD,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	MOVLW	' '
	CALL	LCD_CARACTER
	CALL 	SENSOR2
	CALL 	B2BCD
	RLNCF	MILLAR,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	RLNCF	CENTENA,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	RLNCF	DECENA,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	RLNCF	UNIDAD,W
	CALL	NUMEROS
	CALL	LCD_CARACTER
	CALL	Delay
	GOTO	LOOP
NUMEROS		
	ADDWF	PCL,F
	RETLW	'0'
	RETLW	'1'
	RETLW	'2'
	RETLW	'3'
	RETLW	'4'
	RETLW	'5'
	RETLW	'6'
	RETLW	'7'
	RETLW	'8'
	RETLW	'9'

#include<LCD_4.inc>
#include<B2BCD.inc>
#include<SENSOR1.inc>
#include<SENSOR2.inc>
	END
