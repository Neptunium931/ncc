# Copyright (c) 2025-2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global newVariable

# rdi struct node *
newVariable:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

	xor r13, r13
	mov r14, rdi
	mov r15, [variable.list]

newVariable.loop:
	cmp r15, 0
	je  newVariable.new
	mov r15, qword ptr [r15]
	add r13d, dword  ptr [r15+24]
	jmp newVariable.loop

newVariable.new:
	mov    rdi, 32
	call   malloc
	cmp    r15, 0
	cmovne rbx, r15
	jne    newVariable.initNode
	lea    rbx, [variable.list]

newVariable.initNode:
	xor r12d, r12d
	xor r13d, r13d
	mov qword ptr [rbx], rax

	mov    r15, rax
	mov    rdi, [r14+32]
	call   strdup
	mov    qword ptr [r15+8], rax
	mov    qword ptr [r15+16], 0
	cmp    qword ptr [r14+24], 4 # test if int
	mov    edi, 1    # int
	mov    esi, 4    # sizeof(int)
	cmovz  r12d, edi  # if int r12 = 1 else r12 = 0
	cmovnz ecx, esi  # if int r13 = 4 else r13 = 0

	mov dword ptr [r15+24], r12d # type
	add r13d, ecx
	mov dword ptr [r15+28], r13d # offset

	mov rax, r15

newVariable.end:
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
