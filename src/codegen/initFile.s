# Copyright (c) 2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global initFile

# rdi char *
# rax FILE *
initFile:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

	mov r15, rdi

b:
	mov  rdi, [r15+32]
	call strdup
	mov  rdi, rax
	mov  rdi, r14
	call strlen

	mov  rdi, r14
	mov  rsi, rax
	add  rsi, 2
	call realloc

	mov  rdi, rax
	mov  rsi, 0x2E73
	call strcat

	mov rdi, rax

	xor  rsi, rsi
	mov  rsi, 1 # O_WRONLY
	add  rsi, 64 # O_CREAT
	mov  rdx, 420 # mode 0644
	call openFile
	mov  r14, rax

	mov  rdi, r14
	mov  rsi, OFFSET code.intel.str
	mov  rdx, OFFSET code.intel.str.len
	call writeFd

	mov rax, r14

	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

code.intel.str:
	.ascii ".intel_syntax noprefix\n"
	.equ   code.intel.str.len, . - code.intel.str

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
