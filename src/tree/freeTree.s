# Copyright (c) 2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global freeTree

# rdi struct node *
freeTree:
	push rbp
	mov  rbp, rsp
	push rbx
	push r11
	push r12
	push r13
	push r14
	push r15

	mov r15, rdi

freeTree.loop:
	cmp  qword ptr [r15+8], 0
	jne  freeTree.left
	cmp  qword ptr [r15+16], 0
	jne  freeTree.right
	cmp  qword ptr [r15+32], 0
	jne  freeTree.value
	mov  r14, [r15]
	mov  rdi, r15
	call free
	cmp  r14, 0
	je   freeTree.loop.end
	mov  r15, r14
	jmp  freeTree.loop

freeTree.left:
	mov r14, [r15+8]
	mov qword ptr [r15+8], 0
	mov r15, r14
	jmp freeTree.loop

freeTree.right:
	mov r14, [r15+16]
	mov qword ptr [r15+16], 0
	mov r15, r14
	jmp freeTree.loop

freeTree.value:
	mov  rdi, [r15+32]
	mov  r14, [r15+24]
	and  r14, 0b1010 # mask for 2 or 8
	cmp  r14, 0
	je   freeTree.value.end
	call free

freeTree.value.end:
	mov qword ptr [r15+32], 0
	jmp freeTree.loop

freeTree.loop.end:

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
