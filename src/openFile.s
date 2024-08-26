.intel_syntax noprefix

.global openFile

openFile:
	mov rax, 2
	syscall
	ret
