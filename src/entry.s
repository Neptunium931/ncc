.intel_syntax noprefix

.global _start

.section .text

_start:
	mov rbp, rsp

	cmp DWORD PTR [rbp], 2
	jne end_error

	mov  rdi, [rbp + 8]
	call openFile

	mov  rdi, rax
	call closeFile

	jmp end

end_error:
	mov  rdi, 1
	call quit

end:
	xor  rdi, rdi
	call quit
