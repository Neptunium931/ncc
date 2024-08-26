.intel_syntax noprefix
.global quit

quit:
	mov rax, 60
	syscall
