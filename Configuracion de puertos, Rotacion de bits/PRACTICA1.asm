LIST p=18F45K50
#include <P18F45K50.inc>

; CONFIG1L
  CONFIG  PLLSEL = PLL4X        ; PLL Selection (4x clock multiplier)
  CONFIG  CFGPLLEN = OFF        ; PLL Enable Configuration bit (PLL Disabled (firmware controlled))
  CONFIG  CPUDIV = NOCLKDIV     ; CPU System Clock Postscaler (CPU uses system clock (no divide))
  CONFIG  LS48MHZ = SYS24X4     ; Low Speed USB mode with 48 MHz system clock (System clock at 24 MHz, USB clock divider is set to 4)

; CONFIG1H
  CONFIG  FOSC = INTOSCIO;CLKO     ; Oscillator Selection (Internal oscillator, clock output on OSC2)
  CONFIG  PCLKEN = ON           ; Primary Oscillator Shutdown (Primary oscillator enabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  nPWRTEN = OFF         ; Power-up Timer Enable (Power up timer disabled)
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
  CONFIG  SDOMX = RB3           ; SDO Output MUX bit (SDO function is on RB3)
  CONFIG  MCLRE = OFF           ; Master Clear Reset Pin Enable (RE3 input pin enabled; external MCLR disabled)

; CONFIG4L
  CONFIG  STVREN = OFF          ; Stack Full/Underflow Reset (Stack full/underflow will not cause Reset)
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


; Configuracion de variables
	CBLOCK 0X000
	TEMP0
	TEMP1
	TEMP2
	TEMP3
	TEMP4
	TEMP5
	TEMP6
	TEMP7	
	ENDC

	org	00
	goto	start
;======================================================================================
start	 
	movlw	b'01100010';VALORES A CARGAR EN REGISTRO OSSCON PARA RELOJ INTERNO DE 4 MHZ 
	movwf	OSCCON		
		
	bcf		UCON,3				;DESACTIVA USBEN (MOD. USB DESACTIVADO)
	bsf		UCFG,3
	
;======================================================================================

; CONFIGURACION DE PUERTOS

	CLRF	LATA
	CLRF	ANSELA
	MOVLW	H'FF'
	MOVWF	TRISA

	CLRF	LATB
	CLRF	ANSELB
	CLRF	TRISB

	CLRF	LATC
	CLRF	ANSELC
	CLRF	TRISC

	CLRF	LATD
	CLRF	ANSELD
	CLRF	TRISD

	CLRF	LATE
	CLRF	ANSELE
	CLRF	TRISE
	
	MOVLW	H'00'
	MOVWF	TEMP0 ; COMPARACION CON 0
;fin de configuacion

	



CICLO 
;	DEFINICION DE LOS VALORES INICIALES
	MOVLW	B'00000001'
	MOVWF	TEMP1	;VALOR INICIAL PARA LA ROTACION A LA DERECHA PARA NUMEROS PARES
	MOVLW	H'00'
	MOVLW	B'10000000'	
	MOVWF	TEMP2	;VALOR INICIAL PARA LA ROTACION A LA IZQUIERDA PARA NUMEROS IMPARES

	MOVF	TEMP0,W
	CPFSEQ	PORTA,W
	GOTO INDIVIDUAL

AMBOS
	RLNCF	TEMP2
	RRNCF	TEMP1
	MOVF	TEMP2,W
	ADDWF	TEMP1
	MOVF	TEMP1
	MOVWF	PORTB
		
	MOVF	TEMP0,W	;REALIZA LA COMPARACION Y LECTURA DEL PUERTO A PARA DEFINIR QUE HACER
	CPFSEQ	PORTA,W
	GOTO CICLO
	GOTO AMBOS

INDIVIDUAL

	BTFSS	PORTA,0
	GOTO DERECHA

IZQUIERDA ;IMPAR
	RLNCF	TEMP2
	MOVF	TEMP2,W
	MOVWF	PORTB	
	MOVF	TEMP0,W
	CPFSEQ	PORTA,W
	GOTO C1
	GOTO CICLO
C1
	BTFSS	PORTA,0
	GOTO CICLO
	GOTO IZQUIERDA


DERECHA ;PAR
	RRNCF	TEMP1
	MOVF	TEMP1,W
	MOVWF	PORTB
	MOVF	TEMP0,W
	CPFSEQ	PORTA,W
	GOTO C2
	GOTO CICLO
C2
	BTFSS	PORTA,0
	GOTO DERECHA
	GOTO CICLO

	END