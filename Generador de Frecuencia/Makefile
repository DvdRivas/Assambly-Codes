# MPLAB IDE generated this makefile for use with GNU make.
# Project: GENERADOR.mcp
# Date: Wed Oct 26 10:13:58 2022

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

GENERADOR.cof : GENERADOR.o
	$(CC) /p18F45K50 "GENERADOR.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"GENERADOR.cof" /M"GENERADOR.map" /W

GENERADOR.o : GENERADOR.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F45K50.inc LCD_4.inc BARRIDO.inc
	$(AS) /q /p18F45K50 "GENERADOR.asm" /l"GENERADOR.lst" /e"GENERADOR.err" /o"GENERADOR.o" /d__DEBUG=1

clean : 
	$(CC) "GENERADOR.o" "GENERADOR.err" "GENERADOR.lst" "GENERADOR.cof" "GENERADOR.hex"

