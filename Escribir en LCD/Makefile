# MPLAB IDE generated this makefile for use with GNU make.
# Project: LCD.mcp
# Date: Fri Oct 07 18:48:55 2022

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

LCD.cof : LCD.o
	$(CC) /p18F45K50 "LCD.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"LCD.cof" /M"LCD.map" /W

LCD.o : LCD.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F45K50.inc LCD_4.inc BARRIDO.inc
	$(AS) /q /p18F45K50 "LCD.asm" /l"LCD.lst" /e"LCD.err" /o"LCD.o" /d__DEBUG=1

clean : 
	$(CC) "LCD.o" "LCD.err" "LCD.lst" "LCD.cof" "LCD.hex"

