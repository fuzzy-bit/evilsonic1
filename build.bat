@echo off

:: AMPS STUFF
"AMPS\Includer.exe" ASM68K AMPS AMPS\.Data

:: ASSEMBLY + LOGS
.build\asm68k /m /p /o ae- sonic.asm, s1built.bin, , Build.lst>Build.log
type Build.log
if not exist s1built.bin pause & exit

:: POST-ASSEMBLY
"AMPS\Dual PCM Compress.exe" AMPS\.z80 AMPS\.z80.dat s1built.bin .build\koscmp.exe
ErrorHandler\convsym .lst s1built.bin -input asm68k_lst -inopt "/localSign=. /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
.build\fixheadr.exe s1built.bin

:: REMOVE AMPS DATA
del AMPS\.Data