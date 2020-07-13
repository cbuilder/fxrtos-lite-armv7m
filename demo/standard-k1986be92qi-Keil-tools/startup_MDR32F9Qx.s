;
;  FX-RTOS demo application startup code for Keil toolchain.
;
;  Copyright (C) JSC EREMEX, 2008-2020.
;  Redistribution and use in source and binary forms, with or without 
;  modification, are permitted provided that the following conditions are met:
;  1. Redistributions of source code must retain the above copyright notice,
;     this list of conditions and the following disclaimer.
;  2. Redistributions in binary form must reproduce the above copyright 
;     notice, this list of conditions and the following disclaimer in the 
;     documentation and/or other materials provided with the distribution.
;  3. Neither the name of the copyright holder nor the names of its 
;     contributors may be used to endorse or promote products derived from 
;     this software without specific prior written permission.
;  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
;  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
;  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
;  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
;  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
;  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
;  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;  POSSIBILITY OF SUCH DAMAGE. 
;

; Amount of memory (in bytes) allocated for Stack

Stack_Size      EQU     0x00000400
                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp

Heap_Size       EQU     0x00000000
                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit

                PRESERVE8
                THUMB

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
                EXPORT  __Vectors_End
                EXPORT  __Vectors_Size
				
				IMPORT hal_intr_entry
				IMPORT hal_swi_entry
				IMPORT hal_tick_entry
				IMPORT system_stop

__Vectors       DCD     __initial_sp         ; Top of Stack
                DCD     Reset_Handler        ; Reset Handler
                DCD     system_stop          ; NMI Handler
                DCD     system_stop          ; Hard Fault Handler
                DCD     system_stop          ; MPU Fault Handler
                DCD     system_stop          ; Bus Fault Handler
                DCD     system_stop          ; Usage Fault Handler
                DCD     0                    ; Reserved
                DCD     0                    ; Reserved
                DCD     0                    ; Reserved
                DCD     0                    ; Reserved
                DCD     system_stop          ; SVCall Handler
                DCD     system_stop          ; Debug Monitor Handler
                DCD     0                    ; Reserved
                DCD     hal_swi_entry        ; PendSV Handler
                DCD     hal_tick_entry       ; SysTick Handler

                DCD     hal_intr_entry       ; 16: Watchdog Timer
                DCD     hal_intr_entry       ; 17: Timer0
                DCD     hal_intr_entry       ; 18: Timer1
                DCD     hal_intr_entry       ; 19: Timer2
                DCD     hal_intr_entry       ; 20: Timer3
                DCD     hal_intr_entry       ; 21: UART0
                DCD     hal_intr_entry       ; 22: UART1
                DCD     hal_intr_entry       ; 23: UART2
                DCD     hal_intr_entry       ; 24: UART3
                DCD     hal_intr_entry       ; 25: PWM1
                DCD     hal_intr_entry       ; 26: I2C0
                DCD     hal_intr_entry       ; 27: I2C1
                DCD     hal_intr_entry       ; 28: I2C2
                DCD     hal_intr_entry       ; 29: SPI
                DCD     hal_intr_entry       ; 30: SSP0
                DCD     hal_intr_entry       ; 31: SSP1
                DCD     hal_intr_entry       ; 32: PLL0 Lock (Main PLL)
                DCD     hal_intr_entry       ; 33: Real Time Clock
                DCD     hal_intr_entry       ; 34: External Interrupt 0
                DCD     hal_intr_entry       ; 35: External Interrupt 1
                DCD     hal_intr_entry       ; 36: External Interrupt 2
                DCD     hal_intr_entry       ; 37: External Interrupt 3
                DCD     hal_intr_entry       ; 38: A/D Converter
                DCD     hal_intr_entry       ; 39: Brown-Out Detect
                DCD     hal_intr_entry       ; 40: USB
                DCD     hal_intr_entry       ; 41: CAN
                DCD     hal_intr_entry       ; 42: General Purpose DMA
                DCD     hal_intr_entry       ; 43: I2S
                DCD     hal_intr_entry       ; 44: Ethernet
                DCD     hal_intr_entry       ; 45: Repetitive Interrupt Timer
                DCD     hal_intr_entry       ; 46: Motor Control PWM
                DCD     hal_intr_entry       ; 47: Quadrature Encoder Interface
				DCD     hal_intr_entry       ; 48: PLL1 Lock (USB PLL)
                DCD     hal_intr_entry       ; 49: USB Activity interrupt
                DCD     hal_intr_entry       ; 50: CAN Activity interrupt 
__Vectors_End

__Vectors_Size  EQU  __Vectors_End - __Vectors

                AREA    |.text|, CODE, READONLY

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                IMPORT  __main

                LDR     R0, =__main
                BX      R0
                ENDP

                ALIGN

;*******************************************************************************
; User Stack and Heap initialization
;*******************************************************************************
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
