# Copyright (c) 2024-2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global lexer

lexer:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

# rdi char *buf
# rsi void *[char **buf]
mov r11, rdi
mov r12, rsi
mov r15, rdi
xor r14, r14

lexer.loop:
	cmp  byte ptr [r11], 0
	je   lexer.loop.end
	mov  rdi, r11
	call simpleToken
	cmp  rax, 0
	je   lexer.loop.simpleToken
	mov  rdi, r11
	call endWord
	cmp  rax, 0
	je   lexer.loop.inWord

lexer.loop.endWord:
	cmp  r14, 0
	je   lexer.loop.notStartWord
	inc  r11
	mov  rdi, r15
	mov  rsi, r14
	call strndup
	mov  qword ptr [r12], rax
	add  r12, 8
	xor  r14, r14
	mov  r15, r11
	jmp  lexer.loop

lexer.loop.simpleToken:
	cmp  r14, 0
	je   lexer.loop.notStartWord
	inc  r11
	mov  rdi, r15
	mov  rsi, r14
	call strndup
	mov  qword ptr [r12], rax
	add  r12, 8
	xor  r14, r14
	mov  r15, r11

lexer.loop.notStartWord:
	inc r11
	mov r15, r11
	jmp lexer.loop

lexer.loop.inWord:
	inc r11
	inc r14
	jmp lexer.loop

lexer.loop.end:
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
