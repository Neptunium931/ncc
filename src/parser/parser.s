# Copyright (c) 2024-2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global parser

.macro checkIfPtrIsNull
cmp    qword ptr [rdi], 0
je     parser.end
.endm

parser:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

# rdi void *[char *buf]
# rsi struct node *

mov r12, rsi

parser.loop:
	mov r11, rdi
	checkIfPtrIsNull

parser.loop.switch.type:
	call isType
	mov  r15, rax
	cmp  r15, 1 # auto
	je   parser.NotImplemented
	cmp  r15, 2 # char
	je   parser.NotImplemented
	cmp  r15, 4 # double
	je   parser.NotImplemented
	cmp  r15, 8 # enum
	je   parser.NotImplemented
	cmp  r15, 16 # float
	je   parser.NotImplemented
	cmp  r15, 32 # int
	je   parser.switch.int
	cmp  r15, 64 # struct
	je   parser.NotImplemented
	cmp  r15, 128 # union
	je   parser.NotImplemented
	cmp  r15, 256 # void
	je   parser.NotImplemented

parser.loop.switch.keyword:
	mov  rdi, r11
	call isKeyWord
	mov  r15, rax

	jmp parser.NotImplemented

parser.switch.int:
	mov  rdi, r11
	add  rdi, 8
	mov  r14, rdi
	call isfunction
	cmp  rax, 0
	je   parser.variable.int
	jmp  parser.function.int

parser.loop.end:

parser.end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

parser.loop.next:
	add r11, 8
	mov rdi, r11
	jmp parser.loop

parser.NotImplemented:
	mov  rdi, 1
	mov  rsi, OFFSET notImplemented
	mov  rdx, OFFSET notImplemented.len
	call writeFd
	mov  rdi, 10
	call quit

parser.variable.int:
	jmp parser.NotImplemented

# r12 struct node *
parser.function.int:
	mov  rdi, r12
	call addleft

	mov rdi, [r12]
	mov qword ptr [rdi + 16], 1 # nodeType = function

	mov  rdi, r14
	call getFunctionName

	mov rdi, [r12]
	mov qword ptr [rdi + 24], rax # value = name of function

	add r12, 8
	jmp parser.loop.next

# This file is part of ncc.
#
# BSD 3-Clause License
#
# Copyright (c) 2024-2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
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
