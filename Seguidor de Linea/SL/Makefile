# MPLAB IDE generated this makefile for use with GNU make.
# Project: PROTOTIPO.mcp
# Date: Fri Jan 27 10:44:56 2023

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

PROTOTIPO.cof : PROTOTIPO.o
	$(CC) /p18F45K50 "PROTOTIPO.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"PROTOTIPO.cof" /M"PROTOTIPO.map" /W

PROTOTIPO.o : PROTOTIPO.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F45K50.inc LCD_4.inc B2BCD.inc B2BCD2.inc SENSOR1.inc SENSOR2.inc PWMT.inc SOR.inc BARRIDO.inc
	$(AS) /q /p18F45K50 "PROTOTIPO.asm" /l"PROTOTIPO.lst" /e"PROTOTIPO.err" /o"PROTOTIPO.o" /d__DEBUG=1

clean : 
	$(CC) "PROTOTIPO.o" "PROTOTIPO.err" "PROTOTIPO.lst" "PROTOTIPO.cof" "PROTOTIPO.hex"

