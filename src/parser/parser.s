# Copyright (c) 2024, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global parser

.macro checkIfPtrIsNull
cmp    qword ptr [rdi], 0
je     parser.loop.end
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
# rsi void  *struct ast {}

parser.loop:
parser.loop.switch:
	checkIfPtrIsNull
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
	je   parser.NotImplemented
	cmp  r15, 64 # struct
	je   parser.NotImplemented
	cmp  r15, 128 # union
	je   parser.NotImplemented
	cmp  r15, 256 # void
	je   parser.NotImplemented
	jmp  parser.NotImplemented

parser.loop.end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

parser.NotImplemented:
	mov  rdi, 1
	mov  rsi, OFFSET notImplemented
	mov  rdx, OFFSET notImplemented.len
	call writeFd
	mov  rdi, 10
	call quit

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
