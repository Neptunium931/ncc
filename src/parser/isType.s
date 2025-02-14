# Copyright (c) 2024-2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
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
# DOUBLE = 4
# ENUM = 8
# FLOAT = 16
# INT = 32
# STRUCT = 64
# UNION = 128
# VOID = 256

# CONST = 512
# EXTERN = 1024
# LONG = 2048
# SHORT = 4096
# SIGNED = 8192
# STATIC = 16384
# UNSIGNED = 32768
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

isType.end.false:
	xor rax, rax
	jmp isType.end

isType.end.true:
	mov rax, rbx
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
	cmp byte ptr [rdi+0], 'a'
	jne isType.false
	cmp byte ptr [rdi+1], 'u'
	jne isType.false
	cmp byte ptr [rdi+2], 't'
	jne isType.false
	cmp byte ptr [rdi+3], 'o'
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
	mov rbx, 2
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
	mov rbx, 4
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
	mov rbx, 8
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
	mov rbx, 16
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
	mov rbx, 32
	jmp isType.true

isTypeStruct:
	cmp byte ptr [rdi+0], 's'
	jne isType.false
	cmp byte ptr [rdi+1], 't'
	jne isType.false
	cmp byte ptr [rdi+2], 'r'
	jne isType.false
	cmp byte ptr [rdi+3], 'u'
	jne isType.false
	cmp byte ptr [rdi+4], 'c'
	jne isType.false
	cmp byte ptr [rdi+5], 't'
	jne isType.false
	cmp byte ptr [rdi+6], 0
	jne isType.false
	mov rbx, 64
	jmp isType.true

isTypeUnion:
	cmp byte ptr [rdi+0], 'u'
	jne isType.false
	cmp byte ptr [rdi+1], 'n'
	jne isType.false
	cmp byte ptr [rdi+2], 'i'
	jne isType.false
	cmp byte ptr [rdi+3], 'o'
	jne isType.false
	cmp byte ptr [rdi+4], 'n'
	jne isType.false
	cmp byte ptr [rdi+5], 0
	jne isType.false
	mov rbx, 128
	jmp isType.true

isTypeVoid:
	cmp byte ptr [rdi+0], 'v'
	jne isType.false
	cmp byte ptr [rdi+1], 'o'
	jne isType.false
	cmp byte ptr [rdi+2], 'i'
	jne isType.false
	cmp byte ptr [rdi+3], 'd'
	jne isType.false
	cmp byte ptr [rdi+4], 0
	jne isType.false
	mov rbx, 256
	jmp isType.true

isTypeConst:
	cmp byte ptr [rdi+0], 'c'
	jne isType.false
	cmp byte ptr [rdi+1], 'o'
	jne isType.false
	cmp byte ptr [rdi+2], 'n'
	jne isType.false
	cmp byte ptr [rdi+3], 's'
	jne isType.false
	cmp byte ptr [rdi+4], 't'
	jne isType.false
	cmp byte ptr [rdi+5], 0
	jne isType.false
	mov rbx, 512
	jmp isType.true

isTypeExtern:
	cmp byte ptr [rdi+0], 'e'
	jne isType.false
	cmp byte ptr [rdi+1], 'x'
	jne isType.false
	cmp byte ptr [rdi+2], 't'
	jne isType.false
	cmp byte ptr [rdi+3], 'e'
	jne isType.false
	cmp byte ptr [rdi+4], 'r'
	jne isType.false
	cmp byte ptr [rdi+5], 'n'
	jne isType.false
	cmp byte ptr [rdi+6], 0
	jne isType.false
	mov rbx, 1024
	jmp isType.true

isTypeLong:
	cmp byte ptr [rdi+0], 'l'
	jne isType.false
	cmp byte ptr [rdi+1], 'o'
	jne isType.false
	cmp byte ptr [rdi+2], 'n'
	jne isType.false
	cmp byte ptr [rdi+3], 'g'
	jne isType.false
	cmp byte ptr [rdi+4], 0
	jne isType.false
	mov rbx, 2048
	jmp isType.true

isTypeShort:
	cmp byte ptr [rdi+0], 's'
	jne isType.false
	cmp byte ptr [rdi+1], 'h'
	jne isType.false
	cmp byte ptr [rdi+2], 'o'
	jne isType.false
	cmp byte ptr [rdi+3], 'r'
	jne isType.false
	cmp byte ptr [rdi+4], 't'
	jne isType.false
	cmp byte ptr [rdi+5], 0
	jne isType.false
	mov rbx, 4096
	jmp isType.true

isTypeSigned:
	cmp byte ptr [rdi+0], 's'
	jne isType.false
	cmp byte ptr [rdi+1], 'i'
	jne isType.false
	cmp byte ptr [rdi+2], 'g'
	jne isType.false
	cmp byte ptr [rdi+3], 'n'
	jne isType.false
	cmp byte ptr [rdi+4], 'e'
	jne isType.false
	cmp byte ptr [rdi+5], 'd'
	jne isType.false
	cmp byte ptr [rdi+6], 0
	jne isType.false
	mov rbx, 8192
	jmp isType.true

isTypeStatic:
	cmp byte ptr [rdi+0], 's'
	jne isType.false
	cmp byte ptr [rdi+1], 't'
	jne isType.false
	cmp byte ptr [rdi+2], 'a'
	jne isType.false
	cmp byte ptr [rdi+3], 't'
	jne isType.false
	cmp byte ptr [rdi+4], 'i'
	jne isType.false
	cmp byte ptr [rdi+5], 'c'
	jne isType.false
	cmp byte ptr [rdi+6], 0
	jne isType.false
	mov rbx, 16384
	jmp isType.true

isTypeUnsigned:
	cmp byte ptr [rdi+0], 'u'
	jne isType.false
	cmp byte ptr [rdi+1], 'n'
	jne isType.false
	cmp byte ptr [rdi+2], 's'
	jne isType.false
	cmp byte ptr [rdi+3], 'i'
	jne isType.false
	cmp byte ptr [rdi+4], 'g'
	jne isType.false
	cmp byte ptr [rdi+5], 'n'
	jne isType.false
	cmp byte ptr [rdi+6], 0
	jne isType.false
	mov rbx, 32768
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
