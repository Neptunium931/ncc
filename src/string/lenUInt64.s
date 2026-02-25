# Copyright (c) 2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global lenUInt64

# rdi uint64_t value
# rax int len
lenUInt64:
	mov    rax, 1
	mov    rdx, 10
	cmp    rdi, rdx
	mov    rsi, 2
	cmovge rax, rsi
	mov    rdx, 100
	cmp    rdi, rdx
	mov    rsi, 3
	cmovge rax, rsi
	mov    rdx, 1000
	cmp    rdi, rdx
	mov    rsi, 4
	cmovge rax, rsi
	mov    rdx, 10000
	cmp    rdi, rdx
	mov    rsi, 5
	cmovge rax, rsi
	mov    rdx, 100000
	cmp    rdi, rdx
	mov    rsi, 6
	cmovge rax, rsi
	mov    rdx, 1000000
	cmp    rdi, rdx
	mov    rsi, 7
	cmovge rax, rsi
	mov    rdx, 10000000
	cmp    rdi, rdx
	mov    rsi, 8
	cmovge rax, rsi
	mov    rdx, 100000000
	cmp    rdi, rdx
	mov    rsi, 9
	cmovge rax, rsi
	mov    rdx, 1000000000
	cmp    rdi, rdx
	mov    rsi, 10
	cmovge rax, rsi
	mov    rdx, 10000000000
	cmp    rdi, rdx
	mov    rsi, 11
	cmovge rax, rsi
	mov    rdx, 100000000000
	cmp    rdi, rdx
	mov    rsi, 12
	cmovge rax, rsi
	mov    rdx, 1000000000000
	cmp    rdi, rdx
	mov    rsi, 13
	cmovge rax, rsi
	mov    rdx, 10000000000000
	cmp    rdi, rdx
	mov    rsi, 14
	cmovge rax, rsi
	mov    rdx, 100000000000000
	cmp    rdi, rdx
	mov    rsi, 15
	cmovge rax, rsi
	mov    rdx, 1000000000000000
	cmp    rdi, rdx
	mov    rsi, 16
	cmovge rax, rsi
	mov    rdx, 10000000000000000
	cmp    rdi, rdx
	mov    rsi, 17
	cmovge rax, rsi
	mov    rdx, 100000000000000000
	cmp    rdi, rdx
	mov    rsi, 18
	cmovge rax, rsi
	mov    rdx, 1000000000000000000
	cmp    rdi, rdx
	mov    rsi, 19
	cmovge rax, rsi
	mov    rdx, 10000000000000000000
	cmp    rdi, rdx
	mov    rsi, 20
	cmovae rax, rsi
	ret

# This file is part of ncc.
#
# BSD 3-Clause License
#
# Copyright (c) 2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
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
