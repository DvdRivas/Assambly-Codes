# MPLAB IDE generated this makefile for use with GNU make.
# Project: PRACTICA1.mcp
# Date: Wed Sep 07 18:03:07 2022

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

PRACTICA1.cof : PRACTICA1.o
	$(CC) /p18F45K50 "PRACTICA1.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"PRACTICA1.cof" /M"PRACTICA1.map" /W

PRACTICA1.o : PRACTICA1.asm ../../../../../../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F45K50.inc
	$(AS) /q /p18F45K50 "PRACTICA1.asm" /l"PRACTICA1.lst" /e"PRACTICA1.err" /o"PRACTICA1.o" /d__DEBUG=1

clean : 
	$(CC) "PRACTICA1.o" "PRACTICA1.err" "PRACTICA1.lst" "PRACTICA1.cof" "PRACTICA1.hex"

