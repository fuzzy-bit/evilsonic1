#!/usr/bin/env python3
import os
import subprocess
from pathlib import Path

MARSDEV = Path(os.environ.get('MARSDEV', '~/Projects/sega/tools/marsdev')).expanduser()
MARSBIN = MARSDEV / 'm68k-elf/bin'

CXX = MARSBIN / 'm68k-elf-g++'
GCC_VER = subprocess.run([CXX, '-dumpversion'], capture_output=True, text=True).stdout.strip()

INCS = [f'-I{MARSDEV}/m68k-elf/lib/gcc/m68k-elf/{GCC_VER}/include', '-ILibs']

LDFLAGS = ['-T', 'md.ld', '-nostdlib']
CXXFLAGS = "-m68000 -mno-sep-data -Wall -Wextra -std=c++20 -ffreestanding -mshort -fno-exceptions -fno-rtti".split(' ')
OPTIONS = "-O3 -fno-web -fno-gcse -fno-unit-at-a-time -fomit-frame-pointer".split(' ')

for cppFile in Path('.').glob('**/*.cpp'):
	if not cppFile.is_file():
		continue

	subprocess.run(
		[CXX] + CXXFLAGS + OPTIONS + INCS + [cppFile, '-S', '-fverbose-asm', '-o', cppFile.with_suffix('.s')],
		check=True,
	)
	subprocess.run(
		['./.build/gas-to-asm68k.py', cppFile.with_suffix('.s'), cppFile.with_suffix('.asm')],
		check=True
	)
