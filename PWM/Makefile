# MPLAB IDE generated this makefile for use with GNU make.
# Project: PWM.mcp
# Date: Mon Nov 28 16:41:34 2022

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

PWM.cof : PWM.o
	$(CC) /p18F45K50 "PWM.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"PWM.cof" /M"PWM.map" /W

PWM.o : PWM.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F45K50.inc LCD_4.inc BARRIDO.inc
	$(AS) /q /p18F45K50 "PWM.asm" /l"PWM.lst" /e"PWM.err" /o"PWM.o" /d__DEBUG=1

clean : 
	$(CC) "PWM.o" "PWM.err" "PWM.lst" "PWM.cof" "PWM.hex"

