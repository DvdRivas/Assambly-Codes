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
	NUMERO
	UNIDAD
	DECENA
	CENTENA					
	D1
	D2
	D3	
	ENDC
	
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

	CLRF	LATB
	CLRF	ANSELB
	CLRF	TRISB

	CLRF	LATA
	CLRF	ANSELA
	CLRF	TRISA
;fin de configuacion
;======================================================================================
; PROGRAMA PRINCIPAL
;SUB RUTINA DEL CONVERSOR A DECIMAL
	CLRF	WREG
	CLRF	PORTA
	CLRF 	PORTB
	CLRF	UNIDAD
	CLRF	DECENA
	CLRF	CENTENA
	MOVLW	D'21'
	MOVWF	NUMERO
	MOVWF	UNIDAD
SL1	
	MOVLW	D'10'
	SUBWF	UNIDAD,W
	BNC		SL2
	INCF	DECENA
	MOVWF	UNIDAD
	GOTO	SL1
	
SL2	MOVLW	D'10'
	SUBWF	DECENA,W
	BNC		LOOP
	INCF	CENTENA
	MOVWF	DECENA
	GOTO	SL2

LOOP

	MOVF	DECENA,W
	CALL	DISPLAYS
;////////////////////////////////////////////////////////
	MOVWF	PORTB
	BSF		PORTA,RA3
	BCF		PORTA,RA4
	CALL	Delay
;////////////////////////////////////////////////////////
	MOVF	UNIDAD,W
	CALL	DISPLAYS
;////////////////////////////////////////////////////////
	MOVWF	PORTB
	BCF		PORTA,RA3
	BSF		PORTA,RA4
	CALL	Delay
	BCF		PORTA,RA4
	GOTO 	LOOP
;////////////////////////////////////////////////////////
;==========================================================
; SUBRUTINA DE RETARDO DE 0.5 SEGUNDOS		
; Delay = 0.02 seconds
; Clock frequency = 12 MHz
; Actual delay = 0.02 seconds = 60000 cycles
; Error = 0 %
			;59998 cycles
Delay
	movlw	0x0D
	movwf	D1
	movlw	0x46
	movwf	D2
	movlw	0x04
	movwf	D3
Delay_0
	decfsz	D1, f
	goto	SALTO1
	decfsz	D2, f
SALTO1	goto	SALTO2

	decfsz	D3, f
SALTO2	goto	Delay_0

	RETURN

DISPLAYS	ADDWF	PCL,F
	RETLW	B'00111111'
	RETLW	B'00000110'
	RETLW	B'01011011'
	RETLW	B'01001111'
	RETLW	B'01100110'
	RETLW	B'01101101'
	RETLW	B'01111101'
	RETLW	B'00000111'
	RETLW	B'01111111'
	RETLW	B'01100111'

	END