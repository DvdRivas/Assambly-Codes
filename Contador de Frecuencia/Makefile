# MPLAB IDE generated this makefile for use with GNU make.
# Project: COUNTF.mcp
# Date: Mon Oct 17 20:51:43 2022

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

COUNTF.cof : FREQCOUNTER.o
	$(CC) /p18F45K50 "FREQCOUNTER.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"COUNTF.cof" /M"COUNTF.map" /W

FREQCOUNTER.o : FREQCOUNTER.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F45K50.inc LCD_4.inc B2BCD.inc
	$(AS) /q /p18F45K50 "FREQCOUNTER.asm" /l"FREQCOUNTER.lst" /e"FREQCOUNTER.err" /o"FREQCOUNTER.o" /d__DEBUG=1

clean : 
	$(CC) "FREQCOUNTER.o" "FREQCOUNTER.err" "FREQCOUNTER.lst" "COUNTF.cof" "COUNTF.hex"

