# Copyright (c) 2024, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global parser

parser:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15
	jmp  parser.loop.end

# rdi char *buf
# rsi void *[char *buf]
# rdx void  *struct ast {}
#
# enum {
# INVALID = -1
# AUTO = 0
# BREAK = 1
# CASE = 2
# CHAR = 3
# CONST = 4
# CONTINUE = 5
# DEFAULT = 6
# DO = 7
# DOUBLE = 8
# ELSE = 9
# ENUM = 10
# EXTERN = 11
# FLOAT = 12
# FOR = 13
# GOTO = 14
# IF = 15
# INT = 16
# LONG = 17
# REGISTER = 18
# RETURN = 19
# SHORT = 20
# SIGNED = 21
# SIZEOF = 22
# STATIC = 23
# STRUCT = 24
# SWITCH = 25
# TYPEDEF = 26
# UNION = 27
# UNSIGNED = 28
# VOID = 29
# VOLATILE = 30
# WHILE = 31
#} word

xor r15, r15

# 2^0 => if 1 type is in struct else type not in struct

parser.loop:
parser.loop.switch:
	cmp byte ptr [rsi], 0
	je  parser.loop.end

# call isWord
cmp rax, -1
je  parser.loop.switch.notWord

	mov r14b, r15b
	xor r14b, 0xFE
	cmp r14b, 0
	je  parser.loop.switch.isType
	jmp parser.loop.switch.end

parser.loop.switch.isType:
# call isType
	cmp rax, -1
	je  parser.loop.switch.end
	or  r15b, 0x01
	jmp parser.loop.switch.end

parser.loop.switch.notWord:
	jmp parser.loop.switch.end

parser.loop.switch.end:
	jmp parser.loop

parser.loop.end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

# This file is part of ncc.
#
# BSD 3-Clause License
#
# Copyright (c) 2024, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice
# this
# list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
