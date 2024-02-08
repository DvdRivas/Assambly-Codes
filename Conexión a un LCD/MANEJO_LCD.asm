; ********************************************************
; Uso de pantalla LCD
; Fecha 27/10/2016
; 
;
; ************************************************************
	LIST P = 18F4550
	INCLUDE <P18F4550.INC>
;************************************************************
	CONFIG	FOSC=INTOSCIO_EC			;OSCILADOR INTERNO
	CONFIG PWRT = ON
	CONFIG BOR = OFF
	CONFIG WDT = OFF
	CONFIG MCLRE = ON
	CONFIG PBADEN = OFF
	CONFIG LVP = OFF
	CONFIG DEBUG = OFF
	CONFIG XINST = OFF
; Codigo principal ******************************************************
	CBLOCK 0x0C
	ENDC
 
	#define LCD_RS PORTE,0
	#define LCD_RW PORTE,1
	#define LCD_E PORTE,2
 
	ORG 0x00
	
;-------------------------------------------------------------------------------------------
		movlw	b'01100010'			;VALORES A CARGAR EN REGISTRO OSSCON PARA RELOJ INTERNO DE 4 MHZ 
		movwf	OSCCON,.0			
		movlw	b'00001111'			;VALORES PARA CONFIGURAR EL PUERTO A COMO DIGITAL
		movwf	ADCON1,.0
		movlw	b'00000111'
		movwf	CMCON,.0
		bcf		UCON,3				;DESACTIVA USBEN (MOD. USB DESACTIVADO)
		bsf		UCFG,3
		clrf	INTCON2

;-----------------------------------------------------------------------------------------------
	clrf PORTB
    clrf PORTD
 
    clrf TRISE
    clrf TRISD
 
    call LCD_Inicializa
    bcf  LCD_E
 	call   LCD_Borrar
Inicio
   call Delay ;Esperar un tiempo antes de comenzar a escribir
   movlw  'P'
   call   LCD_Caracter
   movlw  'r'
   call   LCD_Caracter
   movlw  'U'
   call   LCD_Caracter
   movlw  'e'
   call   LCD_Caracter
   movlw  'B'
   call   LCD_Caracter
   movlw  'a'
   call   LCD_Caracter
   movlw  ' '
   call   LCD_Caracter
   movlw  'U'
   call   LCD_Caracter
   movlw  'n'
   call   LCD_Caracter
   movlw  'O'
   call   LCD_Caracter
   movlw  '!'
   call   LCD_Caracter
   call   Delay
   call   Delay
 
   
aqui 
  goto   aqui
 
LCD_Inicializa
   call   Retardo_20ms ;Esperar 20 ms
   movlw  b'00110000' ;Mandar 0x30 -> W
   movwf  PORTD ;Enviar W -> PORTD
 
   call   Retardo_5ms ;Esperar 5ms
   movlw  b'00110000' ;Enviar 0x30 -> W
   movwf  PORTD
 
   call   Retardo_50us ;Acumular 100us
   call   Retardo_50us ;Acumular 100us
   movlw  b'00110000'
   movwf  PORTD
 
   movlw  0x0F			;Display habilitado,Muestra cursor
   movwf  PORTD			;parpadeo de cursor habilitado
 
   bsf    LCD_E
   bcf    LCD_E
   return
 
LCD_Caracter
   bsf    LCD_RS ;Modo Caracter RS = 1
   movwf  PORTD ;Lo que se cargó previamente en W -> PORTB
   bsf    LCD_E ;Activar Enable
   call   Retardo_50us ;Esperar 50us para enviar información
   bcf    LCD_E ;Transición del Enable a 0
  ; call   Delay ;Esperar a poner la siguiente llamada
   return
 
LCD_Borrar
   movlw  b'00000001' ;Comando para Borrar
   call   LCD_Comando ;Enviar un comando
 
LCD_Comando
   bcf    LCD_RS ;Modo Comando RS = 0
   movwf  PORTD ;Envia W -> PORTB
   bsf    LCD_E ;Activa Enable
   call   Retardo_50us ;Espera que se envie la información
   bcf    LCD_E ;Transición del Enable
   return
 
  	INCLUDE <LCD_Retardo.inc>
 
	END ;Fin de Programa
