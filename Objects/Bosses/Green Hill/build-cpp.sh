#!/usr/bin/bash
set -eu

MARSDEV=~/Projects/sega/tools/marsdev
MARSBIN="$MARSDEV/m68k-elf/bin"

CXX="$MARSBIN/m68k-elf-g++"
GCC_VER="$($CXX -dumpversion)"

INCS="-I$MARSDEV/m68k-elf/lib/gcc/m68k-elf/$GCC_VER/include"

LDFLAGS="-T md.ld -nostdlib"
CXXFLAGS="-m68000 -mno-sep-data -Wall -Wextra -std=c++20 -ffreestanding -mshort -fno-exceptions -fno-rtti"
OPTIONS="-O3 -fno-web -fno-gcse -fno-unit-at-a-time -fomit-frame-pointer"

for i in "EggmanShip.cpp" "SpikedBall.cpp" "EggmanMonitor.cpp" ; do 
	$CXX $CXXFLAGS $OPTIONS $INCS $i -S -fverbose-asm -o `basename $i .cpp`.s
	./gas-to-asm68k.py `basename $i .cpp`.s `basename $i .cpp`.asm
done

