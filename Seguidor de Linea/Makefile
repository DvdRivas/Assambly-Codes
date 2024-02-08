# MPLAB IDE generated this makefile for use with GNU make.
# Project: SENSORES.mcp
# Date: Mon Jan 02 14:30:14 2023

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

SENSORES.cof : SENSORES.o
	$(CC) /p18F45K50 "SENSORES.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"SENSORES.cof" /M"SENSORES.map" /W

SENSORES.o : SENSORES.asm ../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F45K50.inc LCD_4.inc B2BCD.inc SENSOR1.inc SENSOR2.inc
	$(AS) /q /p18F45K50 "SENSORES.asm" /l"SENSORES.lst" /e"SENSORES.err" /o"SENSORES.o" /d__DEBUG=1

clean : 
	$(CC) "SENSORES.o" "SENSORES.err" "SENSORES.lst" "SENSORES.cof" "SENSORES.hex"

