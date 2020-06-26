;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000400

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit

                PRESERVE8
                THUMB

; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

				IMPORT hal_intr_entry
				IMPORT hal_swi_entry
				IMPORT hal_tick_entry
				IMPORT system_stop
				
__Vectors       DCD     (__initial_sp)              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     system_stop               ; NMI Handler
                DCD     system_stop               ; Hard Fault Handler
                DCD     system_stop               ; MPU Fault Handler
                DCD     system_stop               ; Bus Fault Handler
                DCD		system_stop               ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     system_stop 		      ; SVCall Handler
                DCD     system_stop               ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     hal_swi_entry             ; PendSV Handler
                DCD     hal_tick_entry            ; SysTick Handler

                ; External Interrupts
                DCD     hal_intr_entry            ; 16: Watchdog Timer
                DCD     hal_intr_entry            ; 17: Timer0
                DCD     hal_intr_entry            ; 18: Timer1
                DCD     hal_intr_entry            ; 19: Timer2
                DCD     hal_intr_entry            ; 20: Timer3
                DCD     hal_intr_entry            ; 21: UART0
                DCD     hal_intr_entry            ; 22: UART1
                DCD     hal_intr_entry            ; 23: UART2
                DCD     hal_intr_entry            ; 24: UART3
                DCD     hal_intr_entry            ; 25: PWM1
                DCD     hal_intr_entry            ; 26: I2C0
                DCD     hal_intr_entry            ; 27: I2C1
                DCD     hal_intr_entry            ; 28: I2C2
                DCD     hal_intr_entry            ; 29: SPI
                DCD     hal_intr_entry            ; 30: SSP0
                DCD     hal_intr_entry            ; 31: SSP1
                DCD     hal_intr_entry            ; 32: PLL0 Lock (Main PLL)
                DCD     hal_intr_entry            ; 33: Real Time Clock
                DCD     hal_intr_entry            ; 34: External Interrupt 0
                DCD     hal_intr_entry            ; 35: External Interrupt 1
                DCD     hal_intr_entry            ; 36: External Interrupt 2
                DCD     hal_intr_entry            ; 37: External Interrupt 3
                DCD     hal_intr_entry            ; 38: A/D Converter
                DCD     hal_intr_entry            ; 39: Brown-Out Detect
                DCD     hal_intr_entry            ; 40: USB
                DCD     hal_intr_entry            ; 41: CAN
                DCD     hal_intr_entry            ; 42: General Purpose DMA
                DCD     hal_intr_entry            ; 43: I2S
                DCD     hal_intr_entry            ; 44: Ethernet
                DCD     hal_intr_entry            ; 45: Repetitive Interrupt Timer
                DCD     hal_intr_entry            ; 46: Motor Control PWM
                DCD     hal_intr_entry            ; 47: Quadrature Encoder Interface
                DCD     hal_intr_entry            ; 48: PLL1 Lock (USB PLL)
                DCD     hal_intr_entry            ; 49: USB Activity interrupt to wakeup
                DCD     hal_intr_entry            ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF

                AREA    |.text|, CODE, READONLY

; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                IMPORT  __main
		
                cpsid i
                LDR     R0, =__main 		; Call runtime
                BX      R0
                ENDP

                ALIGN

; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF

                END
