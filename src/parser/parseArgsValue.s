# Copyright (c) 2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global parseArgsValue

# rdi void *[char *buf]
# rsi struct node *
# rax number of args
parseArgsValue:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

	mov r14, rdi
	mov r12, rsi
	xor r13, r13 # number of args

	mov rax, [r14]
	cmp byte ptr [rax], '('
	jne parseArgsValue.error
	add r14, 8

parseArgsValue.loop:
	mov  r11, [r14+8*r13]
	mov  rax, r11
	cmp  byte ptr [rax], ')'
	je   parseArgsValue.end
	mov  rdi, r12
	call addleft
	mov  r12, [r12+8]
	mov  rdi, r11
	call strdup
	mov  qword ptr [r12+32], rax # args value
	mov  qword ptr [r12+24], 0 # noteType
	inc  r13
	jmp  parseArgsValue.loop

parseArgsValue.end:
	mov rax, r13
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

parseArgsValue.error:
	mov  rdi, [r11-8]
	call strlen
	mov  rdi, 2
	mov  rsi, [r11-8]
	mov  rdx, rax
	call writeFd
	mov  rdi, 2
	mov  rsi, OFFSET parseArgsValue.errorMsg
	mov  rdx, OFFSET parseArgsValue.errorMsg.len
	call writeFd
	mov  rdi, 100
	call quit

# This file is part of ncc.
#
# BSD 3-Clause License
#
# Copyright (c) 2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
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
