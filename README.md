# Reprogrammable on-board computer for CubeSats

Source code for the main MCU is found inside: AAUSAT6-OBC/Core/Src

Source code for the communication module that  interfaces between the PC and the CAN bus is found inside: CanReceiver/Core/Src

Source code for the watchdog MCU is found inside: Watchdog-Nucleo/Core/Src

Source code for the FPGA is found inside: FPGAgatherer/
The main source code is ImageCapture.vhd, which uses content from SevenSegDigit.vhd and SevenSegDisplay.vhd.
