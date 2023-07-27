@echo off

:: INIT
goto :Assemble

:: MESSAGE
:Message DO (
	echo ===========================================================================
	echo ^| %1 %2 %3 %4 %5 %6 %7 %8 %9
	echo ===========================================================================
	exit /b
)

:: ASSEMBLY + LOGS
:Assemble DO (
	call :Message Assembling...
		.build\asm68k /k /m /o ws+ /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- /o v+ sonic.asm, s1built.bin, , .build\log\Build.lst>.build\log\Build.log
		type .build\log\Build.log

		ErrorHandler\convsym .build\log\Build.lst s1built.bin -input asm68k_lst -inopt "/localSign=@ /localJoin=. /ignoreMacroDefs+ /ignoreMacroExp- /addMacrosAsOpcodes+" -a
		.build\fixheadr.exe s1built.bin
		if not exist s1built.bin pause & exit
	echo.

	call :Message Creating debug build...
		.build\asm68k /e __DEBUG__=1 /k /m /o ws+ /o op+ /o os+ /o ow+ /o oz+ /o oaq+ /o osq+ /o omq+ /p /o ae- /o v+ sonic.asm, s1built.debug.bin, .build\log\s1built.debug.sym, .build\log\Build.debug.lst>.build\log\Build.debug.log
		type .build\log\Build.debug.log
		
		ErrorHandler\convsym .build\log\s1built.debug.sym s1built.debug.bin -a
		.build\fixheadr.exe s1built.debug.bin
		if not exist s1built.debug.bin pause & exit
	echo.
)

:: POST-ASSEMBLY
@pause