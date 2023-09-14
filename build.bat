@echo off

:: INIT
goto :Assemble

:: MESSAGE
:Message
	echo ===========================================================================
	echo ^| %*
	echo ===========================================================================
	exit /b

:: ASSEMBLY + LOGS
:Assemble
	call :Message RELEASE build: Assembling and linking...
		.build\asm68k /g /l /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ sonic.asm, .build\log\sonic.obj, , .build\log\sonic.lst>.build\log\sonic.log
		type .build\log\sonic.log

		if not exist .build\log\sonic.obj pause & exit

		.build\psylink.exe /p .build\log\sonic.obj Libs/veps.obj,s1built.bin,.build\log\s1built.sym
		if not exist s1built.bin pause & exit

		.build\convsym.exe .build\log\s1built.debug.sym s1built.bin -a
		.build\fixheadr.exe s1built.bin
		if not exist s1built.bin pause & exit
	echo.

	call :Message DEBUG build: Assembling and linking...
		.build\asm68k /g /e __DEBUG__=1 /l /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ sonic.asm, .build\log\sonic.debug.obj, , .build\log\sonic.debug.lst>.build\log\sonic.debug.log
		type .build\log\sonic.debug.log

		if not exist .build\log\sonic.debug.obj pause & exit

		.build\psylink.exe /p .build\log\sonic.debug.obj Libs/veps.debug.obj,s1built.debug.bin,.build\log\s1built.debug.sym
		if not exist s1built.debug.bin pause & exit

		.build\convsym.exe .build\log\s1built.debug.sym s1built.debug.bin -a
		.build\fixheadr.exe s1built.debug.bin
	echo.

:: POST-ASSEMBLY
@pause