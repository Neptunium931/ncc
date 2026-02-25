# Copyright (c) 2025-2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global codegen

# rdi struct node *
codegen:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

	cmp qword ptr [rdi+32], 0
	je  codegen.end.failed

	mov  r15, rdi
	call initFile
	mov  r14, rax

codegen.loop:
	mov rax, [r15+24]
	and rax, 2
	cmp rax, 2
	je  codegen.function
	mov rax, [r15+24]
	and rax, 1
	cmp rax, 1
	je  codegen.return
	mov rax, [r15+24]
	and rax, 8
	cmp rax, 8
	je  codegen.call
	mov rax, [r15+24]
	and rax, 16
	cmp rax, 16
	je  codegen.define.variable
	mov rax, [r15+24]
	and rax, 32
	cmp rax, 32
	je  codegen.assign.variable
	mov rax, [r15+24]
	and rax, 64
	cmp rax, 64
	je  codegen.value.variable
	jmp codegen.loop.next

codegen.loop.next:
	cmp qword ptr [r15+8], 0
	jne codegen.loop.next.left
	cmp qword ptr [r15+16], 0
	jne codegen.loop.next.right
	cmp qword ptr [r15], 0
	je  codegen.end.succes
	mov r15, [r15]
	jmp codegen.loop.next

codegen.loop.next.left:
	mov rax, [r15+8]
	mov qword ptr [r15+8], 0
	mov r15, rax
	jmp codegen.loop

codegen.loop.next.right:
	mov rax, [r15+16]
	mov qword ptr [r15+16], 0
	mov r15, rax
	jmp codegen.loop

codegen.end.failed:
	mov rax, 1
	jmp codegen.end

codegen.end.succes:
	mov  rdi, r14
	call closeFile
	xor  rax, rax

codegen.end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

.macro writeGlobal
mov    rdi, r14
mov    rsi, OFFSET code.global.str
mov    rdx, OFFSET code.global.str.len
call   writeFd
.endm

.macro writeEndOfLine
mov    rdi, r14
mov    rsi, OFFSET endLine
mov    rdx, OFFSET endLine.len
call   writeFd
.endm

.macro writeColon
mov    rdi, r14
mov    rsi, OFFSET colon
mov    rdx, OFFSET colon.len
call   writeFd
.endm

.macro writeComma
mov    rdi, r14
mov    rsi, OFFSET comma
mov    rdx, OFFSET comma.len
call   writeFd
.endm

.macro writeMov
mov    rdi, r14
mov    rsi, OFFSET mov
mov    rdx, OFFSET mov.len
call   writeFd
.endm

.macro writeRet
mov    rdi, r14
mov    rsi, OFFSET ret
mov    rdx, OFFSET ret.len
call   writeFd
.endm

.macro writeCall
mov    rdi, r14
mov    rsi, OFFSET call.str
mov    rdx, OFFSET call.len
call   writeFd
.endm

.macro writePush
mov    rdi, r14
mov    rsi, OFFSET push.str
mov    rdx, OFFSET push.len
call   writeFd
.endm

.macro writeSub
mov    rdi, r14
mov    rsi, OFFSET sub.str
mov    rdx, OFFSET sub.len
call   writeFd
.endm

.macro writeRax
mov    rdi, r14
mov    rsi, OFFSET rax.str
mov    rdx, OFFSET rax.len
call   writeFd
.endm

.macro writeRbp
mov    rdi, r14
mov    rsi, OFFSET rbp.str
mov    rdx, OFFSET rbp.len
call   writeFd
.endm

.macro writeRsp
mov    rdi, r14
mov    rsi, OFFSET rsp.str
mov    rdx, OFFSET rsp.len
call   writeFd
.endm

.macro writeUInt64 reg
mov    rdi, \reg
call   utoa
mov    rdi, rax
push   rdi
call   strlen
pop    rsi
mov    rdi, r14
mov    rdx, rax
call   writeFd
.endm

codegen.function:
	writeGlobal

	mov  rdi, [r15+32]
	call strlen
	mov  r12, rax
	mov  rdx, r12
	mov  rdi, r14
	mov  rsi, [r15+32]
	call writeFd
	writeEndOfLine

	mov  rdx, r12
	mov  rdi, r14
	mov  rsi, [r15+32]
	call writeFd
	writeColon
	writeEndOfLine

	jmp codegen.loop.next

codegen.return:
	writeMov
	writeRax
	writeComma

	mov  rdi, r15
	add  rdi, 32
	call strlen
	mov  rdx, rax
	mov  rdi, r14
	mov  rsi, r15
	add  rsi, 32
	call writeFd
	writeEndOfLine
	writeRet
	writeEndOfLine

	jmp codegen.loop.next

codegen.call:
	cmp qword ptr [r15+8], 0
	je  codegen.call.callFunction

	xor r13, r13
	mov r12, [r15+8]
	cmp r12, 0
	je  codegen.call.callFunction

codegen.call.args:
	writeMov
	mov  rdi, r14
	mov  rsi, r13
	call writeRegisterArg
	writeComma
	mov  rdi, [r12+32]
	call strlen
	mov  rdx, rax
	mov  rsi, [r12+32]
	mov  rdi, r14
	call writeFd
	writeEndOfLine
	cmp  qword ptr [r12+8], 0
	je   codegen.call.callFunction
	inc  r13
	mov  r12, [r12+8]
	jmp  codegen.call.args

codegen.call.callFunction:
	writeCall
	mov  rdi, [r15+32]
	call strlen
	mov  rdx, rax
	mov  rsi, [r15+32]
	mov  rdi, r14
	call writeFd
	writeEndOfLine
	jmp  codegen.loop.next

codegen.define.variable:
	mov  rdi, r15
	call newVariable

	mov rdi, qword ptr [r15+8]
	mov rsi, qword ptr [rdi+24]
	and rsi, 32
	cmp rsi, 32
	jne codegen.define.variable.generate
	mov edi, dword ptr [rdi+32]
	mov dword ptr [rax+16], edi

codegen.define.variable.generate:
	mov rdi, qword ptr [r15+8]
	mov rax, qword ptr [rdi+24]
	and rax, 16
	cmp rax, 16
	je  codegen.loop.next

	writePush
	writeRbp
	writeEndOfLine
	writeMov
	writeRbp
	writeComma
	writeRsp
	writeEndOfLine

	writeSub
	writeRbp
	writeComma

	call        getLastVariable
	mov         eax, dword ptr [rax+28]
	writeUInt64 rax
	writeEndOfLine

	jmp codegen.loop.next

codegen.assign.variable:
	jmp codegen.loop.next

codegen.value.variable:
	jmp codegen.loop.next

.section .bss
.global  variable.list

variable.list:
	.quad 0

#
.section .rodata

code.global.str:
	.ascii ".global "
	.equ   code.global.str.len, . - code.global.str

endLine:
	.ascii "\n"
	.equ   endLine.len, . - endLine

colon:
	.ascii ":"
	.equ   colon.len, . - colon

comma:
	.ascii ","
	.equ   comma.len, . - comma

mov:
	.ascii "mov "
	.equ   mov.len, . - mov

ret:
	.ascii "ret"
	.equ   ret.len, . - ret

call.str:
	.ascii "call "
	.equ   call.len, . - call.str

push.str:
	.ascii "push "
	.equ   push.len, . - push.str

sub.str:
	.ascii "sub "
	.equ   sub.len, . - sub.str

# This file is part of ncc.
#
# BSD 3-Clause License
#
# Copyright (c) 2025-2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
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
