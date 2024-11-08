#!/usr/bin/env python3
import sys
import re

input_file = sys.argv[1]
output_file = sys.argv[2]

def convertLabel(label: str) -> str:
    # Special treatment for constants (.LCx)
    if label.startswith('.LC'):
        label = input_file.replace('.', '_').replace(' ', '').replace('/', '') + '__' + label[1:]

    # Replace ".Lx" with "@Lx"
    if label.startswith('.'):
        label = '@' + label[1:]

    return label


def convertExpression(expr: str) -> str:
    # Expression is likely "label1-label2"
    if len(expr.split('-')) == 2:
        label1, label2 = expr.split('-')
        return f'{convertLabel(label1)}-{convertLabel(label2)}'

    return expr

def convertStringExpression(str_expr: str) -> str:
    pattern = r'\\(\d+)'

    char_table = {
        "\\b": 8,
        "\\t": 9,
        "\\n": 10,
        "\\r": 13,
    }
    for (key, value) in char_table.items():
        str_expr = str_expr.replace(key, f'", ${value:x}, "');

    def replace_hex(match):
        octal_value = match.group(1)
        return f'", ${int(octal_value, 8):x}, "'

    str_expr_converted = re.sub(pattern, replace_hex, str_expr)
    if str_expr_converted.endswith(', ""'):
        str_expr_converted = str_expr_converted[:-len(', ""')]
    if str_expr_converted.startswith('"", '):
        str_expr_converted = str_expr_converted[len('"", '):]
    str_expr_converted = str_expr_converted.replace(', "", ', ', ')

    return str_expr_converted


def convertOperand(operand: str) -> str:
    # Replace %d0, %a0, ... with d0, a0, ...
    operand = operand.replace('%', '')

    # Convert auto-labels
    if operand.startswith('.'):
        operand = convertLabel(operand)

    # Convert jump tables (e.g. jmp %pc@(2,%d0:w))
    if operand.startswith('pc@('):
        operand = '*+2+' + operand.replace('pc@(', '').replace(':', '.').replace(',', '(pc,')

    return operand


def convertMovemOperands(operands: list[str]) -> list[str]:
    sregs = [
        'd0','d1','d2','d3','d4','d5','d6','d7',
        'a0','a1','a2','a3','a4','a5','a6','a7',
    ]

    if operands[1].startswith('#'):
        regVal = int(operands[1][1:])
        regs = []
        for i in range(0, 16):
            if (regVal >> i) & 1:
                regs.append(sregs[i])
        operands[1] = '/'.join(regs)

    if operands[0].startswith('#'):
        regVal = int(operands[0][1:])
        regs = []
        for i in range(15, -1, -1):
            if (regVal >> i) & 1:
                regs.append(sregs[15-i])
        operands[0] = '/'.join(regs)

    return operands;


with open(input_file, 'r') as input_stream:
    with open(output_file, 'w') as output_stream:
        for raw_line in input_stream:
            # Filter out GCC comments
            split_line = raw_line.split('|')
            line = split_line[0]
            comment = None if len(split_line) == 1 else split_line[1]

            # If line is a directive
            if line.startswith(' ') or line.startswith('\t') and line.strip().startswith('.'):
                line = line.strip()
                if line.startswith('.word ') or line.startswith('.long '):
                    line = line.replace(' ', '\t', 1)

                tokens = line.strip().split('\t')
                directive = tokens[0]
                args = tokens[1] if len(tokens) > 1 else None

                if directive == '.align' and args == '2':
                    output_stream.write(f'\teven\n')

                if directive == '.string' and args:
                    str_op = convertStringExpression(args)
                    output_stream.write(f'\tdc.b\t{str_op}, 0\n')

                if directive == '.ascii' and args:
                    str_op = convertStringExpression(args)
                    output_stream.write(f'\tdc.b\t{str_op}\n')

                elif directive == '.byte' and args:
                    output_stream.write(f'\tdc.b\t{convertExpression(args)}\n')

                elif directive == '.word' and args:
                    output_stream.write(f'\tdc.w\t{convertExpression(args)}\n')

                elif directive == '.long' and args:
                    output_stream.write(f'\tdc.l\t{convertExpression(args)}\n')

                else:
                    # Ignore directives, e.g. ".text", ".globl"
                    continue

            # Line is an assembly command
            elif line.startswith(' ') or line.startswith('\t'):
                tokens = list(map(str.strip, line.strip().split(' ')))
                opcode = tokens[0]
                operands = []

                if len(tokens) >= 2:
                    if tokens[1].startswith("%pc@("):
                        operands = [tokens[1]]
                    else:
                        operands = list(map(str.strip, tokens[1].split(',')))

                # Replace JEQ, JNE, ... with BEQ, BNE, ...
                if opcode not in ('jmp', 'jsr') and opcode.startswith('j'):
                    opcode = 'b' + opcode[1:]

                # Replace assembly calls using "BRA" and "BSR" to "JMP" and "JSR"
                if opcode in ('bra', 'bsr') and operands[0].endswith('__cdecl'):
                    opcode = 'jmp' if opcode == 'bra' else 'jsr'

                # Convert MOVEM.L/.W
                if opcode.startswith('movem'):
                    operands = convertMovemOperands(operands)

                # Replace %d0, %a0, ... with d0, a0, ...
                operands = list(map(convertOperand, operands))

                output_stream.write(f'\t{opcode}\t{", ".join(operands)}\n')

            # Line is a label
            elif line.strip().endswith(':'):
                line = line.strip()
                if line.startswith('.'):
                    line = convertLabel(line)

                output_stream.write(f'{line}\n')

