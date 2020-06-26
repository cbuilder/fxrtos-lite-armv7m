/**************************************************
 *
 * Part one of the system initialization code, contains low-level
 * initialization, plain thumb variant.
 *
 * Copyright 2009 IAR Systems. All rights reserved.
 *
 * $Revision: 33529 $
 *
 **************************************************/
;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;
        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        EXTERN  hal_intr_entry
        EXTERN  hal_tick_entry
        EXTERN  hal_swi_entry
        EXTERN  system_stop
        EXTERN  main

        PUBLIC  __vector_table
        PUBLIC  __vector_table_0x1c

        DATA
__vector_table
        DCD     0x10008000                  ; Top of Stack
        DCD     __iar_program_start         ; Reset Handler
        DC32    system_stop                 ; NMI
        DC32    system_stop                 ; HardFault
        DCD     system_stop                 ; MPU Fault Handler
        DCD     system_stop                 ; Bus Fault Handler
        DCD     system_stop                 ; Usage Fault Handler
__vector_table_0x1c
        DCD     0                           ; Reserved
        DCD     0                           ; Reserved
        DCD     0                           ; Reserved
        DCD     0                           ; Reserved
        DCD     system_stop                 ; SVCall Handler
        DCD     system_stop                 ; Debug Monitor Handler
        DCD     0                           ; Reserved
        DCD     hal_swi_entry               ; PendSV Handler
        DCD     hal_tick_entry              ; SysTick Handler
        DCD     hal_intr_entry              ; Watchdog Handler
        DCD     hal_intr_entry              ; TIMER0 Handler
        DCD     hal_intr_entry              ; TIMER1 Handler
        DCD     hal_intr_entry              ; TIMER2 Handler
        DCD     hal_intr_entry              ; TIMER3 Handler
        DCD     hal_intr_entry              ; UART0 Handler
        DCD     hal_intr_entry              ; UART1 Handler
        DCD     hal_intr_entry              ; UART2 Handler
        DCD     hal_intr_entry              ; UART3 Handler
        DCD     hal_intr_entry              ; PWM1 Handler
        DCD     hal_intr_entry              ; I2C0 Handler
        DCD     hal_intr_entry              ; I2C1 Handler
        DCD     hal_intr_entry              ; I2C2 Handler
        DCD     hal_intr_entry              ; SPI Handler
        DCD     hal_intr_entry              ; SSP0 Handler
        DCD     hal_intr_entry              ; SSP1 Handler
        DCD     hal_intr_entry              ; PLL0 Handler
        DCD     hal_intr_entry              ; RTC Handler
        DCD     hal_intr_entry              ; EXT Interupt 0 Handler
        DCD     hal_intr_entry              ; EXT Interupt 1 Handler
        DCD     hal_intr_entry              ; EXT Interupt 2 Handler
        DCD     hal_intr_entry              ; EXT Interupt 3 Handler
        DCD     hal_intr_entry              ; ADC Handler
        DCD     hal_intr_entry              ; BOD Handler
        DCD     hal_intr_entry              ; USB Handler
        DCD     hal_intr_entry              ; CAN Handler
        DCD     hal_intr_entry              ; General Purpose DMA Handler
        DCD     hal_intr_entry              ; I2S Handler
        DCD     hal_intr_entry              ; Ethernet Handler
        DCD     hal_intr_entry              ; Repetitive Interrupt Timer Handler
        DCD     hal_intr_entry              ; Motor Control PWM Handler
        DCD     hal_intr_entry              ; Quadrature Encoder Handler
        DCD     hal_intr_entry              ; PLL1 Handler

;
; IAR runtime transfers control to main function on MAIN stack.
; Since FX-RTOS uses PROCESS stack for applications, SP should be
; switched before C code gets control.
;
      SECTION .text:CODE:REORDER(2)
      THUMB
      PUBLIC main_startup
main_startup:
      MOV R0, #2
      MSR CONTROL, R0
      ISB
      LDR R0, =(0x10007C00)
      MSR PSP, R0
      B main

 SECTION .text:CODE:ROOT(2)

        END
