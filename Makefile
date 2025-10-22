# Copyright (c) 2024-2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
# See end of file for extended copyright information.
OS := $(shell uname -s)
AS ?= as
AS_FLAGS ?= -g
LD ?= ld
LD_FLAGS ?= -g

ncc_src = ./src/entry.s \
					./src/quit.s \
					./src/openFile.s \
					./src/closeFile.s \
					./src/memory/malloc.s \
					./src/readFd.s \
					./src/writeFd.s \
					./src/checkChar.s \
					./src/lexer/lexer.s \
					./src/lexer/endWord.s \
					./src/parser/parser.s \
					./src/errorMessage.s \
					./src/parser/isType.s \
					./src/string/strcpy.s \
					./src/string/strdup.s \
					./src/string/strlen.s \
					./src/memory/memcpy.s \
					./src/string/strnlen.s \
					./src/string/strndup.s \
					./src/freeArrayString.s \
					./src/freeArrayString.s \
					./src/parser/isfunction.s \
					./src/string/strchr.s \
					./src/memory/free.s \
					./src/memory/realloc.s \
					./src/tree/createnode.s \
					./src/tree/addleft.s \
					./src/tree/addright.s \
					./src/parser/isKeyWord.s \
					./src/tree/freeTree.s \
					./src/codegen/codegen.s \
					./src/codegen/initFile.s \
					./src/string/strcat.s \
					./src/lexer/simpleToken.s \
					./src/parser/parseArgsType.s \
					./src/parser/parseArgsValue.s \
					./src/codegen/writeRegisterArg.s \
					./src/codegen/newVariable.s

ifeq ($(OS), OpenBSD)
LD_FLAGS += --color-diagnostics
ncc_src += ./src/openbsd.s
endif

ncc_obj = $(ncc_src:.s=.s.o) 

ncc: $(ncc_obj)
	$(LD) $(LD_FLAGS) -o $@ $^

%.s.o: %.s
	$(AS) $(AS_FLAGS) -o $@ $<

clean:
	rm -f $(ncc_obj)
	rm -f ncc

lib64 ?= /lib64

check: ncc
	./ncc ./exemple/empty.c
	./ncc ./exemple/simpleMain.c
	! ./ncc ./exemple/invalidChar.c
	! ./ncc ./exemple/invalidSimpleMain.c
	./ncc ./exemple/putc.c
	as -g -o main.o main.s
	ld -o a.out $(lib64)/crt1.o $(lib64)/crti.o $(lib64)/crtn.o -lc main.o --dynamic-linker /lib64/ld-linux-x86-64.so.2
	@bash -c '\
		commandOutput=$$(./a.out); \
		if [[ $$commandOutput != "(" ]]; then \
			echo "output : #$$commandOutput#";  \
			echo "expected : #(#"; \
			exit 1; \
		fi'
	./ncc ./exemple/var.c

distcheck:

.PHONY: clean check distcheck

# This file is part of ncc.
#
# BSD 3-Clause License
#
# Copyright (c) 2024-2025, Tymothé BILLEREY <tymothe_billerey@fastmail.fr>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
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
