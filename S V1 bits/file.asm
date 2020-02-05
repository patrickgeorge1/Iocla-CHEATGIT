%include "includes/io.inc"

section .data
	a: 			dd    1
	n:			dd    5

	nr1:		dd    1
	nr2:		dd    1

section .bss

section .text

global CMAIN
CMAIN:
    mov ebp, esp

    ;call compute_powN

    push dword 3
	call change_bits_32
	add esp, 4

    PRINT_UDEC 4, eax
    NEWLINE

    ret


compute_powN:
	enter 0, 0

	mov eax, DWORD[a]
	mov ecx, DWORD[n]
	loop_shift:
		shl eax, 1
	loop loop_shift

	leave
	ret

change_bits_32:
	enter 0, 0
		mov ecx, [ebp + 8]

		mov eax, DWORD[nr1]
		mov ebx, DWORD[nr2]

		mov edx, 32
		sub edx, ecx    ; 32 - k

		push edx			; eax = nr1 << 32 - k
			push edx
			push eax
			call shift_left
			add esp, 8
		pop edx

		xchg eax, ebx       ; ebx = nr1 << 32 - k
		push edx			; eax = nr2 << k
			push DWORD[ebp + 8]
			push eax
			call shift_left
			add esp, 8
		pop edx

		push DWORD[ebp + 8]  ; eax = nr2 >> k
		push eax
		call shift_right
		add esp, 8

		or  eax, ebx

	leave
	ret


shift_left:
	enter 0, 0
		mov eax, [ebp + 8]
		mov edx, [ebp + 12]

		xor ecx, ecx
		left:
			cmp ecx, edx
			jg left_stop
			shl eax, 1
			inc ecx
			jmp left
		left_stop:
	leave
	ret

shift_right:
	enter 0, 0
		mov eax, [ebp + 8]
		mov edx, [ebp + 12]

		xor ecx, ecx
		right:
			cmp ecx, edx
			jg right_stop
			shr eax, 1
			inc ecx
			jmp right
		right_stop:
	leave
	ret