# Copyright (c) 2024, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global _start

.section .text

_start:
	mov rbp, rsp

	cmp DWORD PTR [rbp], 2
	jne end_error

	mov  rdi, [rbp + 16]
	call openFile
	mov  r12, rax

	mov  rdi, 1024
	call malloc
	mov  r13, rax

	mov  rdi, r12
	mov  rsi, r13
	mov  rdx, 1024
	call readFd

	mov rdi, r13

checkChar.loop:
	cmp  byte ptr [rdi], 0
	je   checkChar.loop.end
	call checkChar
	cmp  rax, 0
	jne  checkChar.loop.error
	inc  rdi
	jmp  checkChar.loop

checkChar.loop.end:
lexer:
	mov  rdi, 1024
	call malloc
	mov  r15, rax
	mov  rsi, rax
	mov  rdi, r13
	call lexer

parser:
	call createnode
	mov  r14, rax

	mov  rdi, r15
	mov  rsi, r14
	call parser

freeAll:
	mov  rdi, r14
	call free

	mov  rdi, r15
	call freeArrayOfString

	mov  rdi, r15
	call free

	mov  rdi, 1
	mov  rsi, r13
	mov  rdx, 1024
	call writeFd

	mov  rdi, r13
	call free

	mov  rdi, r12
	call closeFile

	jmp end

checkChar.loop.error:
	mov  rdi, 1
	lea  rsi, [rip + checkChar.error.message]
	mov  rdx, OFFSET checkChar.error.message.len
	call writeFd
	jmp  end_error

end_error:
	mov  rdi, r13
	call free
	mov  rdi, r12
	call closeFile
	mov  rdi, 1
	call quit

end:
	xor  rdi, rdi
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
