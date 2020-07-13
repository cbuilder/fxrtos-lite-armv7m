LED blinking demo for Keil uVision
===================================

Demo description
----------------

This simple demo application creates three LED-blinking threads. Each thread toggles the LED with different frequency.

Files listing
-------------

| File name           | Description
|---------------------|------------------------------------------------------
| build.bat           | build script
| FXRTOS.h            | FX-RTOS interface header
| fxrtos_demo.elf     | application image (ELF format)
| fxrtos_demo.hex     | application binary for UART loader
| libfxrtos.a         | FX-RTOS kernel
| main.c              | User application
| startup_MDR32F9Qx.S | MCU startup initialization
| core_cm3.h          | ARM cortex-m3 core description
| system_MDR32F9Q.h   | PLL/clocks functions
| system_MDR32F9Q.c   | PLL/clocks interface
| MDR32F9Qx.h         | MCU peripheral registers definitions
| MDR32F9Qx_config.h  | MCU clock definitions
| MDR32F9Qx_lib.h     | MCU peripheral library definitions

Building
--------
Prerequisites: Install software pack for Keil MDK 5 for MCU 1986ВЕ9x.
1. Open Keil uVision, add project "fxrtos_demo.uvprojx" to current workspace.
2. Run "Rebuild all target files"

ELF and HEX files containing application image and binary should appear in demo folder.

Hardware setup
--------------
The board LDM-K1986BE192QI can be powered over USB connected to the host PC.
Connect board to XS1 connector (USB-A, USB-UART), JP8 should select power from USB-A.
SW[2:0] switch should have binary value 101.
This approach transfers firmware via MCU UART2 port. This port is connected virtual COM port adapter on board.
Set SW11 (ON/OFF) button to "ON" position.

Downloading to target
---------------------
1. Compiled HEX binary could loaded to MCU flash memory by 1986WSD.exe utility (Windows).
User should select firmware file path, appropriate COM port, and press Start/Start+Run button.
2. User can do specific debbugger configuration in project options and use "Download" button in IDE