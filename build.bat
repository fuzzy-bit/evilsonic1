@echo off
"AMPS\Includer.exe" ASM68K AMPS AMPS\.Data
asm68k /m /p /o ae- sonic.asm, s1built.md, , .lst>.log
type .log
if not exist s1built.md pause & exit
"AMPS\Dual PCM Compress.exe" AMPS\.z80 AMPS\.z80.dat s1built.md _dlls\koscmp.exe
error\convsym .lst s1built.md -input asm68k_lst -inopt "/localSign=. /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
fixheadr.exe s1built.md
del AMPS\.Data
