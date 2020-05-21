format 		ELF64
public	       _start

	bs_char rb 1

_start:
	mov rax, 65536
	call 	_print_number

	jmp 	_exit

_print_char:
	push rax
	push rbx
	push rcx
	push rdx
	mov [bs_char], al
	mov rax, 4
	mov rbx, 1
	mov rcx, bs_char
	mov rdx, 1
	int 0x80
	pop rdx
	pop rcx
	pop rbx
	pop rax
	ret

_print_number:
	push rax
	push rbx
	push rcx
	push rdx

	xor rcx, rcx
	._next_iteration:
		cmp  rax, 0
		je ._print_iter
		mov  rbx, 10
		xor  rdx, rdx
		div  rbx
		add  rdx, '0'
		push rdx
		inc  rcx
		jmp ._next_iteration
	._print_iter:
		cmp  rcx, 0
		je ._close
		pop  rax
		call _print_char
		dec  rcx
		jmp ._print_iter
	._close:

	pop rdx
	pop rcx
	pop rbx
	pop rax
		ret

_new_line:
	push rax
	mov rax, 0xA
	call _print_char
	pop rax
	ret

_exit:
	mov rax, 1
	xor rbx, rbx
	int 0x80
