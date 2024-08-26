.intel_syntax noprefix
.global malloc
.global free

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
