format ELF64
public _start

_start:
	add rax, 'A'
	call _print_char
	jmp _exit

_print_char:
	push rax
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 1

	syscall
	pop rax
	ret

_exit:
	mov rax, 1
	xor rbx, rbx
	int 0x80
