# Copyright (c) 2026, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.section .rodata

.macro  generateRegisterString name
.global \name\().str
.global \name\().len

\name\().str:
	.asciz "\name"
	.equ   \name\().len, . - \name\().str
	.endm

#

generateRegisterString rax
generateRegisterString rbx
generateRegisterString rcx
generateRegisterString rdx
generateRegisterString rsi
generateRegisterString rdi
generateRegisterString rsp
generateRegisterString rbp
generateRegisterString r8
generateRegisterString r9
generateRegisterString r10
generateRegisterString r11
generateRegisterString r12
generateRegisterString r13
generateRegisterString r14
generateRegisterString r15

# rdi.str:
# .ascii "rdi"
# .equ   rdi.len, . - rdi.str
#
# rsi.str:
# .ascii "rsi"
# .equ   rsi.len, . - rsi.str
#
# rdx.str:
# .ascii "rdx"
# .equ   rdx.len, . - rdx.str
#
# rcx.str:
# .ascii "rcx"
# .equ   rcx.len, . - rcx.str
#
# r8.str:
# .ascii "r8"
# .equ   r8.len, . - r8.str
#
# r9.str:
# .ascii "r9"
# .equ   r9.len, . - r9.str

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
