# Copyright (c) 2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global isKeyWord

.macro checkIfTrue
cmp    rax, 1
je     isKeyWord.end.true
.endm

isKeyWord:
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

mov r15, [rdi]
mov rdi, r15

isKeyWord.body:
	call isBreak
	checkIfTrue
	call isContinue
	checkIfTrue
	call isDefault
	checkIfTrue
	call isDo
	checkIfTrue
	call isElse
	checkIfTrue
	call isExtern
	checkIfTrue
	call isFor
	checkIfTrue
	call isGoto
	checkIfTrue
	call isIf
	checkIfTrue
	call isInline
	checkIfTrue
	call isRegister
	checkIfTrue
	call isRestrict
	checkIfTrue
	call isReturn
	checkIfTrue
	call isSizeof
	checkIfTrue
	call isStatic
	checkIfTrue
	call isStruct
	checkIfTrue
	call isSwitch
	checkIfTrue
	call isTypedef
	checkIfTrue
	call isUnion
	checkIfTrue
	call isVolatile
	checkIfTrue
	call isWhile
	checkIfTrue

isKeyWord.end.false:
	xor rax, rax
	jmp isKeyWord.end

isKeyWord.end.true:
	mov rax, rbx
	jmp isKeyWord.end

isKeyWord.end:
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbx
	pop rbp
	ret

isBreak:
	cmp byte ptr [rdi+0], 'b'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'a'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'k'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 0
	jne isKeyWord.false
	mov rbx, 1
	jmp isKeyWord.true

isContinue:
	cmp byte ptr [rdi+0], 'c'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 'u'
	jne isKeyWord.false
	cmp byte ptr [rdi+7], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+8], 0
	jne isKeyWord.false
	mov rbx, 2
	jmp isKeyWord.true

isDefault:
	cmp byte ptr [rdi+0], 'd'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'f'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'a'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'u'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'l'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+7], 0
	jne isKeyWord.false
	mov rbx, 4
	jmp isKeyWord.true

isDo:
	cmp byte ptr [rdi+0], 'd'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 0
	jne isKeyWord.false
	mov rbx, 8
	jmp isKeyWord.true

isElse:
	cmp byte ptr [rdi+0], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'l'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 's'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 0
	jne isKeyWord.false
	mov rbx, 16
	jmp isKeyWord.true

isExtern:
	cmp byte ptr [rdi+0], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'x'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 0
	jne isKeyWord.false
	mov rbx, 32
	jmp isKeyWord.true

isFor:
	cmp byte ptr [rdi+0], 'f'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 0
	jne isKeyWord.false
	mov rbx, 64
	jmp isKeyWord.true

isGoto:
	cmp byte ptr [rdi+0], 'g'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 0
	jne isKeyWord.false
	mov rbx, 128
	jmp isKeyWord.true

isIf:
	cmp byte ptr [rdi+0], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'f'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 0
	jne isKeyWord.false
	mov rbx, 256
	jmp isKeyWord.true

isInline:
	cmp byte ptr [rdi+0], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'l'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 0
	jne isKeyWord.false
	mov rbx, 512
	jmp isKeyWord.true

isRegister:
	cmp byte ptr [rdi+0], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'g'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 's'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+7], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+8], 0
	jne isKeyWord.false
	mov rbx, 1024
	jmp isKeyWord.true

isRestrict:
	cmp byte ptr [rdi+0], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 's'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 'c'
	jne isKeyWord.false
	cmp byte ptr [rdi+7], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+8], 0
	jne isKeyWord.false
	mov rbx, 2048
	jmp isKeyWord.true

isReturn:
	cmp byte ptr [rdi+0], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'u'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 0
	jne isKeyWord.false
	mov rbx, 4096
	jmp isKeyWord.true

isSizeof:
	cmp byte ptr [rdi+0], 's'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'z'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'f'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 0
	jne isKeyWord.false
	mov rbx, 8096
	jmp isKeyWord.true

isStatic:
	cmp byte ptr [rdi+0], 's'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'a'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'c'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 0
	jne isKeyWord.false
	mov rbx, 16192
	jmp isKeyWord.true

isStruct:
	cmp byte ptr [rdi+0], 's'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'r'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'u'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'c'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 0
	jne isKeyWord.false
	mov rbx, 32384
	jmp isKeyWord.true

isSwitch:
	cmp byte ptr [rdi+0], 's'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'w'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'c'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'h'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 0
	jne isKeyWord.false
	mov rbx, 64768
	jmp isKeyWord.true

isTypedef:
	cmp byte ptr [rdi+0], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'y'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'p'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'd'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 'f'
	jne isKeyWord.false
	mov rbx, 129536
	jmp isKeyWord.true

isUnion:
	cmp byte ptr [rdi+0], 'u'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'n'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 0
	jne isKeyWord.false
	mov rbx, 259072
	jmp isKeyWord.true

isVolatile:
	cmp byte ptr [rdi+0], 'v'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'o'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'l'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'a'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 't'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+6], 'l'
	jne isKeyWord.false
	cmp byte ptr [rdi+7], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+8], 0
	jne isKeyWord.false
	mov rbx, 518144
	jmp isKeyWord.true

isWhile:
	cmp byte ptr [rdi+0], 'w'
	jne isKeyWord.false
	cmp byte ptr [rdi+1], 'h'
	jne isKeyWord.false
	cmp byte ptr [rdi+2], 'i'
	jne isKeyWord.false
	cmp byte ptr [rdi+3], 'l'
	jne isKeyWord.false
	cmp byte ptr [rdi+4], 'e'
	jne isKeyWord.false
	cmp byte ptr [rdi+5], 0
	jne isKeyWord.false
	mov rbx, 1032688
	jmp isKeyWord.true

isKeyWord.false:
	xor rax, rax
	ret

isKeyWord.true:
	mov rax, 1
	ret

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
