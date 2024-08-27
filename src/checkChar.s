# Copyright (c) 2024, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
.intel_syntax noprefix

.global checkChar

# See https: // en.cppreference.com/w/c/language/translation_phases
#
# The source character set is a multibyte character set which includes
# the basic source character set as a single-byte subset
# consisting of the following 96 characters:
#
# a) 5 whitespace characters
# (space, horizontal tab, vertical tab, form feed, new-line)
# b) 10 digit characters from '0' to '9'
# c) 52 letters from 'a' to 'z' and from 'A' to 'Z'
# d) 29 punctuation characters:
# _ { } [ ] # ( ) < > % :; . ? * + - / ^ & | ~ ! =, \ " '
#
# char allow
#
# - 0x09 => horizontal tab
# - 0x11 to 0x13 => vertical tab, form feed, new-line
# - 0x20 to 0x23 => space, !, ", #
# - 0x25 to 0x3F => %, &, ', (, ), *, +, ,, -, ., /, 0-9, :, ;, <, =, >, ?
# - 0x41 to 0x5F => A-Z, [, \, ], ^, _
# - 0x61 to 0x7E => a-z, {, |, }, ~
# new line in linux is 0x0A => line feed

checkChar:
# 0x09 to 0x13
cmp byte ptr [rdi], 0x09
jl  checkChar.error
cmp byte ptr [rdi], 0x13
jle checkChar.ok

# 0x20 to 0x23
cmp byte ptr [rdi], 0x20
jl  checkChar.error
cmp byte ptr [rdi], 0x23
jle checkChar.ok

# 0x25 to 0x3F
cmp byte ptr [rdi], 0x25
jl  checkChar.error
cmp byte ptr [rdi], 0x3F
jle checkChar.ok

# 0x41 to 0x5F
cmp byte ptr [rdi], 0x41
jl  checkChar.error
cmp byte ptr [rdi], 0x5F
jle checkChar.ok

# 0x61 to 0x7E
cmp byte ptr [rdi], 0x61
jl  checkChar.error
cmp byte ptr [rdi], 0x7E
jle checkChar.ok

checkChar.ok:
	xor rax, rax
	ret

checkChar.error:
	mov rax, 1
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
