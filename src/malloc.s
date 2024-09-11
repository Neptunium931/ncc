# Copyright (c) 2024, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix
.global malloc
.global free

# rdi = size
# rax = void *
malloc:
	push rbp
	mov  rbp, rsp

	mov rsi, rdi
	mov rax, 9
	xor rdi, rdi
	mov rdx, 3 # 3 = PROT_READ | PROT_WRITE
	mov r10, 34 # 34 = MAP_PRIVATE | MAP_ANONYMOUS
	xor r8, r8
	xor r9, r9
	syscall

	cmp rax, -1
	je  malloc.error

	pop rbp
	ret

malloc.error:
	mov  rdi, 2
	call quit

# rdi = void *ptr
free:
	push rbp
	mov  rbp, rsp

	mov rax, 11
	syscall

	cmp rax, 0
	jne free.error

	pop rbp
	ret

free.error:
	mov  rdi, 3
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
