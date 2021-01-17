# TestROMs
Test ROMs to verify emulator functionality written in assembly using rgbds

rgbds needs to be available in the path to build or put in the project folder. Binaries are built using the following commands:

rgbasm -o MAIN.o .\PROGRAMNAME.asm && 
rgblink -o outputromname.gb MAIN.o && 
rgbfix -v -p 0 .\OUTPUTNAME.gb
