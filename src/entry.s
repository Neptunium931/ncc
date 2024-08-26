.intel_syntax noprefix

.global _start

.section .text

_start:
	mov rbp, rsp

end:
	xor  rdi, rdi
	call quit
