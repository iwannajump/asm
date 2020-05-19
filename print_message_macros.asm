format ELF64
public _start

section '_data' writable
	asm_message_1 db "assembly_test_string", 	0xA, 0

	asm_message_2 db "assembly_test_string 1", 	0xA, 0

	asm_message_3 db "assembly_test_string 2", 	0xA, 0

section '_text' executable
	_start:
		mov rax, asm_message_1
		call _print_string

		mov rax, asm_message_2
		call _print_string

		mov rax, asm_message_3
		call _print_string

		call _exit

section '_print_string' executable
	_print_string:
		push rax
		push rbx
		push rcx
		push rdx
		mov rcx, rax
		call _length_string
		mov rdx, rax
		mov rax, 4
		xor rbx, rbx
		inc rbx
		int 0x80
		pop rdx
		pop rcx
		pop rbx
		pop rax
		ret

section '_length_string' executable
	_length_string:
		push rdx
		xor rdx, rdx
		._next_iteration:
			cmp [rax+rdx], byte 0
			je .close
			inc rdx
			jmp ._next_iteration
		.close:
			mov rax, rdx
			pop rdx
			ret

_exit:
		mov rax, 1 ; 1 - exit
		mov rbx, 0 ; 0 - return
		int 0x80