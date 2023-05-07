@echo off

:: ASSEMBLY + LOGS
.build\asm68k /k /m /o ws+ /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- /o v+ sonic.asm, s1built.bin, , Build.lst>Build.log
type Build.log
if not exist s1built.bin pause & exit

.build\asm68k /e _DEBUG_ /k /m /o ws+ /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- /o v+ sonic.asm, s1built.debug.bin, s1built.debug.sym, Build.debug.lst>Build.debug.log
type Build.debug.log
if not exist s1built.debug.bin pause & exit

:: POST-ASSEMBLY
ErrorHandler\convsym Build.lst s1built.bin -input asm68k_lst -inopt "/localSign=@ /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
ErrorHandler\convsym s1built.debug.sym s1built.debug.bin -a
.build\fixheadr.exe s1built.bin
.build\fixheadr.exe s1built.debug.bin
@pause
