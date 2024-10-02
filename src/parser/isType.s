# Copyright (c) 2024, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global isType

isType:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

# rdi char *buf
# rax enum type

# enum {
# AUTO = 1
# CHAR = 2
# DOUBLE = 8
# ENUM = 16
# FLOAT = 32
# INT = 64
# STRUCT = 128
# UNION = 256
# VOID = 512

# CONST = 1028
# EXTERN = 2048
# LONG = 4096
# SHORT = 8192
# SIGNED = 16384
# STATIC = 32768
# UNSIGNED = 65536
#} type

isType.body:
	mov r15, [rdi]
	mov rdi, r15

isType.body.typeBase:
	call isTypeAuto
	cmp  rax, 1
	je   isType.end.true
	call isTypeChar
	cmp  rax, 1
	je   isType.end.true
	call isTypeDouble
	cmp  rax, 1
	je   isType.end.true
	call isTypeEnum
	cmp  rax, 1
	je   isType.end.true
	call isTypeFloat
	cmp  rax, 1
	je   isType.end.true
	call isTypeInt
	cmp  rax, 1
	je   isType.end.true
	call isTypeStruct
	cmp  rax, 1
	je   isType.end.true
	call isTypeUnion
	cmp  rax, 1
	je   isType.end.true
	cmp  rax, 1
	je   isType.end.true
	call isTypeVoid
	cmp  rax, 1
	je   isType.end.true

isType.body.typeModifier:
	call isTypeConst
	cmp  rax, 1
	je   isType.end.true
	call isTypeExtern
	cmp  rax, 1
	je   isType.end.true
	call isTypeLong
	cmp  rax, 1
	je   isType.end.true
	call isTypeShort
	cmp  rax, 1
	je   isType.end.true
	call isTypeSigned
	cmp  rax, 1
	call isTypeStatic
	cmp  rax, 1
	je   isType.end.true
	call isTypeUnsigned
	cmp  rax, 1
	je   isType.end.true

isType.end.true:
	mov rax, 1
	jmp isType.end

isType.end.false:
	xor rax, rax
	jmp isType.end

isType.end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

isTypeAuto:
	cmp dword ptr [rdi], 0x6f747561 #  auto
	jne isType.false
	cmp byte ptr [rdi+4], 0
	jne isType.false
	mov rbx, 1
	jmp isType.true

isTypeChar:
	cmp byte ptr [rdi+0], 'c'
	jne isType.false
	cmp byte ptr [rdi+1], 'h'
	jne isType.false
	cmp byte ptr [rdi+2], 'a'
	jne isType.false
	cmp byte ptr [rdi+3], 'r'
	jne isType.false
	cmp byte ptr [rdi+4], 0
	jne isType.false
	mov rbx, 1
	jmp isType.true

isTypeDouble:
	cmp byte ptr [rdi+0], 'd'
	jne isType.false
	cmp byte ptr [rdi+1], 'o'
	jne isType.false
	cmp byte ptr [rdi+2], 'u'
	jne isType.false
	cmp byte ptr [rdi+3], 'b'
	jne isType.false
	cmp byte ptr [rdi+4], 'l'
	jne isType.false
	cmp byte ptr [rdi+5], 'e'
	jne isType.false
	cmp byte ptr [rdi+6], 0
	jne isType.false
	jmp isType.true

isTypeEnum:
	cmp byte ptr [rdi+0], 'e'
	jne isType.false
	cmp byte ptr [rdi+1], 'n'
	jne isType.false
	cmp byte ptr [rdi+2], 'u'
	jne isType.false
	cmp byte ptr [rdi+3], 'm'
	jne isType.false
	cmp byte ptr [rdi+4], 0
	jne isType.false
	jmp isType.true

isTypeFloat:
	cmp byte ptr [rdi+0], 'f'
	jne isType.false
	cmp byte ptr [rdi+1], 'l'
	jne isType.false
	cmp byte ptr [rdi+2], 'o'
	jne isType.false
	cmp byte ptr [rdi+3], 'a'
	jne isType.false
	cmp byte ptr [rdi+4], 't'
	jne isType.false
	cmp byte ptr [rdi+5], 0
	jne isType.false
	jmp isType.true

isTypeInt:
	cmp byte ptr [rdi+0], 'i'
	jne isType.false
	cmp byte ptr [rdi+1], 'n'
	jne isType.false
	cmp byte ptr [rdi+2], 't'
	jne isType.false
	cmp byte ptr [rdi+3], 0
	jne isType.false
	jmp isType.true

isType.true:
	mov rax, 1
	ret

isType.false:
	xor rax, rax
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
