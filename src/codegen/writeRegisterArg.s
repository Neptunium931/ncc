# Copyright (c) 2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global writeRegisterArg

# rdi fd *
# rsi number of args
writeRegisterArg:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

	mov r15, rdi
	mov r14, rsi

	cmp r14, 0
	je  arg0
	cmp r14, 1
	je  arg1
	cmp r14, 2
	je  arg2
	cmp r14, 3
	je  arg3
	cmp r14, 4
	je  arg4
	cmp r14, 5
	jne NotImplemented

arg5:
	mov rsi, OFFSET r9.str
	mov rdx, OFFSET r9.len
	jmp writeRegisterArg.write

arg4:
	mov rsi, OFFSET r8.str
	mov rdx, OFFSET r8.len
	jmp writeRegisterArg.write

arg3:
	mov rsi, OFFSET rcx.str
	mov rdx, OFFSET rcx.len
	jmp writeRegisterArg.write

arg2:
	mov rsi, OFFSET rdx.str
	mov rdx, OFFSET rdx.len
	jmp writeRegisterArg.write

arg1:
	mov rsi, OFFSET rsi.str
	mov rdx, OFFSET rsi.len
	jmp writeRegisterArg.write

arg0:
	mov rsi, OFFSET rdi.str
	mov rdx, OFFSET rdi.len

writeRegisterArg.write:
	mov  rdi, r15
	call writeFd

	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

NotImplemented:
	mov  rdi, 2
	mov  rsi, OFFSET notImplemented
	mov  rdx, OFFSET notImplemented.len
	call writeFd
	mov  rdi, 10
	call quit

# ARG0 (rdi) 	ARG1 (rsi) 	ARG2 (rdx) 	ARG3 (rcx) 	ARG4 (r8) 	ARG5 (r9)
rdi.str:
	.ascii "rdi"
	.equ   rdi.len, . - rdi.str

rsi.str:
	.ascii "rsi"
	.equ   rsi.len, . - rsi.str

rdx.str:
	.ascii "rdx"
	.equ   rdx.len, . - rdx.str

rcx.str:
	.ascii "rcx"
	.equ   rcx.len, . - rcx.str

r8.str:
	.ascii "r8"
	.equ   r8.len, . - r8.str

r9.str:
	.ascii "r9"
	.equ   r9.len, . - r9.str

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
