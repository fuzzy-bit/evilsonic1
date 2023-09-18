#!/usr/bin/bash
set -eu

MARSDEV=~/Projects/sega/tools/marsdev
MARSBIN="$MARSDEV/m68k-elf/bin"

CXX="$MARSBIN/m68k-elf-g++"
GCC_VER="$($CXX -dumpversion)"

INCS="-I$MARSDEV/m68k-elf/lib/gcc/m68k-elf/$GCC_VER/include"

LDFLAGS="-T md.ld -nostdlib"
CXXFLAGS="-m68000 -mpcrel -mno-sep-data -Wall -Wextra -std=c++20 -ffreestanding -mshort -fno-exceptions -fno-rtti"
OPTIONS="-O3 -fno-web -fno-gcse -fno-unit-at-a-time -fomit-frame-pointer"

$CXX $CXXFLAGS $OPTIONS $INCS "EggmanShip.cpp" -S -fverbose-asm -o "EggmanShip.s"
./gas-to-asm68k.py "EggmanShip.s" "EggmanShip.asm"
