#!/usr/bin/env python3
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

def convertOperand(operand: str) -> str:
	# Replace %d0, %a0, ... with d0, a0, ...
	operand = operand.replace('%', '')

	# Replace ".Lx" with "@Lx"
	if operand.startswith('.'):
		operand = '@' + operand[1:]

	return operand


with open(input_file, 'r') as input_stream:
	with open(output_file, 'w') as output_stream:
		for raw_line in input_stream:
			# Filter out GCC comments
			line = raw_line.split('|')[0]

			# If line is a directive
			if line.startswith(' ') or line.startswith('\t') and line.strip().startswith('.'):
				# Ignore directives, e.g. ".text", ".globl"
				continue

			# Line is an assembly command
			elif line.startswith(' ') or line.startswith('\t'):
				tokens = list(map(str.strip, line.strip().split(' ')))
				opcode = tokens[0]
				operands = []

				if len(tokens) >= 2:
					operands = list(map(str.strip, tokens[1].split(',')))

				# Replace JEQ, JNE, ... with BEQ, BNE, ...
				if opcode not in ('jmp', 'jsr') and opcode.startswith('j'):
					opcode = 'b' + opcode[1:]

				# Replace %d0, %a0, ... with d0, a0, ...
				operands = list(map(convertOperand, operands))

				output_stream.write(f'\t{opcode}\t{", ".join(operands)}\n')

			# Line is a label
			elif line.strip().endswith(':'):
				line = line.strip()
				if line.startswith('.'):
					line = '@' + line[1:]

				output_stream.write(f'{line}\n')

