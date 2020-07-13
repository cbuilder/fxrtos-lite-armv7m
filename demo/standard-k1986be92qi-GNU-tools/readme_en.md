This simple demo application creates three LED-blinking threads. Each thread toggles the LED with different frequency.

Building:
1) Open the console window and enter the demo directory
2) Type set GCC_PREFIX=arm-none-eabi- (sets proper path for compiler and other GNU binutils to be used). 
3) Type build.bat. HEX-file should appear in current directory.

Brief description of files:
build.bat : Builder script for compiling and linking the demo.
FXRTOS.h, fxrtos.a : FX-RTOS header and library.
*.ld or *.icf file : Linker script for GNU LD or IAR.
main.c : Demo application.
startup*.s : Interrupt vectors and basic initialization code.
core_cm3.h and files prefixed with either MDR32F9Qx or system : Processor core and peripheral devices headers (supplied by the manufacturer).	