#!/bin/sh
set -eu

./.build/make-cpp.py

echo RELEASE build: Assembling and linking...
wine .build/asm68k.exe /g /l /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ sonic.asm, .build/log/sonic.obj, , .build/log/sonic.lst
wine .build/psylink.exe /p .build/log/sonic.obj Libs/veps.obj Libs/megapcm.obj Libs/debugger.obj,s1built.bin,.build/log/s1built.sym
wine .build/convsym.exe .build/log/s1built.debug.sym s1built.bin -a -ref 200
wine .build/fixheadr.exe s1built.bin

echo DEBUG build: Assembling and linking...

wine .build/asm68k.exe /g /e __DEBUG__=1 /l /k /m /o ws+,op+,os+,ow+,oz+,oaq+,osq+,omq+,ae-,v+ sonic.asm, .build/log/sonic.debug.obj, , .build/log/sonic.debug.lst>.build/log/sonic.debug.log
wine .build/psylink.exe /p .build/log/sonic.debug.obj Libs/veps.debug.obj Libs/megapcm.debug.obj Libs/debugger.obj,s1built.debug.bin,.build/log/s1built.debug.sym
wine .build/convsym.exe .build/log/s1built.debug.sym s1built.debug.bin -a -ref 200
wine .build/fixheadr.exe s1built.debug.bin
