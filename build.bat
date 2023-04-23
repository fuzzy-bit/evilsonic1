@echo off

:: ASSEMBLY + LOGS
.build\asm68k /m /p /o ae- sonic.asm, s1built.bin, , Build.lst>Build.log
type Build.log
if not exist s1built.bin pause & exit

:: POST-ASSEMBLY
ErrorHandler\convsym Build.lst s1built.bin -input asm68k_lst -inopt "/localSign=. /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
.build\fixheadr.exe s1built.bin
@pause
