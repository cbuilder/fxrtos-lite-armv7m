Description
-----------

This repository contains preconfigured version of FX-RTOS Lite for ARM.

Note that the kernel has limitations which are listed in [main repository](https://github.com/Eremex/fxrtos-lite).

Getting started
---------------

All popular toolchains are supported including GNU GCC, Keil MDK and IAR EWARM.
GNU toolchain installation instructions:

Windows:

https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

Linux:

	sudo apt install binutils-arm-none-eabi gcc-arm-none-eabi

### How to build the library from sources

- Ensure supported compiler is available via PATH
- Set GCC_PREFIX as compiler prefix if you use GCC (i.e. 'arm-none-eabi-')
- Enter directory where build.bat is located
- Run 'build.bat' on Windows or 'make lib' on Linux/Mac

For those who do not want to mess with toolchains and source code we provide prebuilt binaries. 
ARM version is compatible with any Cortex-M3+ chip and may be used as just two files: header and library.
While binary version may be sufficient for most users it lacks configuration and optimization options. 
The OS may be either rebuilt as a binary or it can be added as set of files in IDE.
