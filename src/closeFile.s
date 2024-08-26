.intel_syntax noprefix

.global closeFile

closeFile:
	mov rax, 3
	syscall
	ret
